"""Bounded actual epoch counters; row soundness remains the compiled checker."""
import linux_worker_gate as gate


def require(value, message):
    if not value:
        raise ValueError(message)


def cost_floor_policy(resource_acceptance,basis):
    gate.record(resource_acceptance)
    intervals=basis['minimum_validated_full_epoch_frames_by_bank_class']
    require(set(intervals)=={'0','1','2','3'},'Actual resource coverage needs all four bank classes')
    require(all(type(n) is int and 1<=n<=16 for n in intervals.values()),'Invalid observed complete epoch')
    return dict(schema='OBSERVED_RESOURCE_EPOCH_COST_FLOOR_WITH_ONE_FRAME_MARGIN_V14',
        resource_acceptance=dict(resource_acceptance),conservative_margin_frames=1,
        minimum_complete_epoch_frames_by_bank_class={k:max(1,n-1) for k,n in intervals.items()},
        pause_before_commit_if_actual_epoch_shorter=True)


def bank_class_from_locked_files(files):
    rows=[v['bytes'] for name,v in files.items() if name.endswith(('.bits','.dir'))]
    require(bool(rows) and all(type(n) is int and n>0 for n in rows),'Missing actual bound bank bits/directories')
    size=sum(rows)
    for cls,limit in enumerate((64*1024**2,512*1024**2,2*1024**3,6000000000)):
        if size<=limit:return str(cls)
    raise ValueError('Actual bank exceeds the measured resource classes')


class EpochTracker:
    def __init__(self, previous_global_epoch=0):
        require(type(previous_global_epoch) is int and previous_global_epoch >= 0, 'Bad native epoch origin')
        self.previous_global = previous_global_epoch
        self.current = None
        self.completed = 0
        self.closed_counts = []
        self.frames = self.rows = 0
        self.minimum_complete_epoch_frames=1

    def set_cost_floor(self,minimum):
        require(self.frames==0 and self.current is None,'An active epoch cost floor cannot change')
        require(type(minimum) is int and 1<=minimum<=16,'Invalid bounded complete-epoch floor')
        self.minimum_complete_epoch_frames=minimum

    def accept(self, reply, start, count):
        life = reply['native_lifecycle']
        worker = reply['worker']
        require(reply.get('schema') == 'FUSED_LINUX_INDEXED_BYTE_LEAN_BRIDGE_V16' and reply.get('event') == 'SPAN_DONE', 'Wrong sparse bridge event')
        require(reply.get('start') == start and reply.get('count') == count, 'Wrong exact epoch frame extent')
        require(life.get('native_io_policy') == gate.IO_POLICY, '16-frame/1MiB native policy changed')
        capacity = life['stdin_pipe_capacity']
        require(all(capacity.get(k) == v for k, v in dict(requested_capacity_bytes=1048576,
            set_return_capacity_bytes=1048576, actual_capacity_bytes=1048576,
            configured_by_uid=1000, capacity_get_confirmed=True).items()), 'Actual native pipe differs')
        rss = life['RSS_before_bytes']
        epoch = life['native_epochs']
        require(type(rss) is int and 0 < rss < 11250000000, 'Unobserved or excessive native RSS')
        require(type(epoch) is int and epoch > 0 and type(life.get('rotated')) is bool, 'Missing actual epoch identity')
        should_rotate = self.completed >= 16 or rss >= 9000000000
        if self.current is None:
            require(not should_rotate and not life['rotated'] and epoch == self.previous_global + 1, 'A fresh bucket must start a new nonempty actual epoch below its RSS rotation threshold')
            first = True
        elif should_rotate:
            require(self.completed>=self.minimum_complete_epoch_frames,
                'RESOURCE_EPOCH_SHORTER_THAN_COST_GUARD_REESTIMATE_REQUIRED_BEFORE_CURRENT_FRAME_COMMIT')
            require(life['rotated'] and epoch == self.current + 1, 'Required16/RSS rotation was skipped')
            require(self.completed > 0 and life['total_seconds'] > 0, 'Empty or unaccounted rotation')
            self.closed_counts.append(self.completed)
            self.completed = 0
            first = True
        else:
            require(not life['rotated'] and epoch == self.current, 'Unexpected native epoch or early rotation')
            first = False
        require(life['rotated'] or life['total_seconds'] == 0, 'A nonrotation has an invented restart fee')
        event = reply['native_event']
        require(all(event.get(k) == v for k, v in dict(schema='INDEXED_BYTE_LARGE_FRAME_RESIDENT_PROTOCOL_V16', event='SPAN_DONE',
            start=start, count=count, completed_spans=self.completed + 1).items()), 'Actual Lean epoch counter differs')
        require(worker.get('plan_checker_kind') == gate.MARKER and worker.get('actual_successors_all_checked') is True, 'Actual sparse checker missing')
        expected=dict(indexed_byte_mode=True,compact_word_mode=False,gpu_source_packet_mode=False,
            gpu_witness_mode=True,pure_checker_theorem_fingerprints=104,
            source_r_guard_every_row=True,source_block_cover_checked=True,
            row_checker_kind='PROVED_INDEXED_NEXT_BYTE_SCALAR_SCAN_V16',
            plan_constructor_kind='PROVED_ONCE_CHECKED_TEMPLATE_CONSTRUCTOR_V16',
            small_plan_serial_template_threshold=4096,compact_bytes=count)
        require(all(type(worker.get(k)) is type(v) and worker[k]==v for k,v in expected.items()),
            'Actual104 indexed row/source/constructor identity missing')
        fullT=worker.get('frame_full_templates_without_reuse');blocks=worker.get('plan_blocks')
        require(type(fullT) is int and 0<=fullT<=500000 and type(blocks) is int and 0<blocks<=8192,
            'Full complete T and source block admission absent')
        require(worker.get('plan_prepare_workers')==(1 if fullT<=4096 else min(12,blocks)),
            'Adaptive plan workers must use fullT before reuse')
        require(worker.get('row_schedule_kind') == 'PROVED_CONTIGUOUS_PARTITION_STRIDED_FIXED_ROUNDS_V13' and
            worker.get('row_rounds') == 1 and worker.get('row_partition_checked') is True and
            worker.get('row_partition_chunks') == 12, 'The actual104-proof selected partition is missing')
        require(worker.get('reference_rows') == (min(count, 64) if first else 0), 'Reference rows must occur once per actual native epoch')
        self.current = epoch
        self.completed += 1
        self.frames += 1
        self.rows += count

    def completed_counts(self):
        return self.closed_counts + ([self.completed] if self.completed else [])
