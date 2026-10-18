"""Cheap local reports only: no RPC, model, notification or scheduled task."""
import datetime,time
import campaign_io as c


def write(folder,manifest,state,ticket,initial_committed=0,cleanup_confirmed=None):
    now=time.monotonic();utc=datetime.datetime.now(datetime.timezone.utc)
    total=sum(r["count"] for r in manifest["requests"])
    committed=state["committed_rows"];imported=state.get("imported_unique_rows",0)
    accepted=committed+imported
    if not 0<=accepted<=total:raise ValueError("Local report found inconsistent exact requested coverage")
    elapsed=max(0.,now-ticket.ticket["began_monotonic"])
    fresh=max(0,committed-initial_committed);rate=fresh/elapsed if elapsed and fresh else None
    remaining=total-accepted
    value=dict(schema="LOCAL_NO_MODEL_CAMPAIGN_PROGRESS_V12",utc=utc.isoformat(),state=state["state"],
        committed_rows=committed,committed_chunks=state["committed_chunks"],imported_unique_rows=imported,
        accepted_requested_unique_rows=accepted,requested_unique_rows=total,remaining_requested_rows=remaining,
        requested_percent_complete=100*accepted/total if total else 100.,
        invocation_elapsed_including_parent_setup_seconds=elapsed,actual_new_committed_rows_this_invocation=fresh,
        actual_current_invocation_committed_rows_per_second=rate,
        empirical_requested_ETA_seconds=(remaining/rate if rate else None),ETA_is_not_a_completion_guarantee=True,
        prior_budget_charged_seconds=ticket.ticket["prior_charged_seconds"],
        cumulative_observed_or_conservatively_charged_seconds=ticket.ticket["prior_charged_seconds"]+elapsed,
        budget_reserved_charge_seconds=state.get("budget_used_seconds"),budget_limit_seconds=manifest["cumulative_runtime_budget_seconds"],
        invocation_reservation=state.get("invocation_reservation"),current_activity=state.get("current_activity"),
        all_owned_services_confirmed_exited=cleanup_confirmed,model_calls=0,notifications=False,
        full_table_Lean=state.get("full_table_verification","NOT_VERIFIED"))
    c.atomic(folder/"progress.json",value)
    stamp=utc.strftime("%Y%m%dT%H%M%S.%fZ")+"_"+ticket.ticket["token"][:8]
    c.atomic(folder/"reports"/(stamp+".json"),value)
    speed=f"{rate:,.2f} rows/second" if rate else "No committed-row rate for this invocation yet"
    eta=f"{remaining/rate/3600:.2f} hours (empirical estimate for the requested scope; completion is not guaranteed)" if rate else "No estimate yet"
    text=(f"Time (UTC): {value['utc']}\nState: {value['state']}\n"
        f"Committed by this version: {committed:,} rows / {state['committed_chunks']:,} frames\n"
        f"Imported prior certification: {imported:,} rows\nRequested coverage: {accepted:,} / {total:,}({value['requested_percent_complete']:.6f}%)\n"
        f"Requested rows remaining: {remaining:,} rows\nInvocation including parent setup: {elapsed:.3f} seconds\nMeasured invocation rate: {speed}\nEmpirical time remaining: {eta}\n"
        f"Cumulative observed/conservatively charged time: {value['cumulative_observed_or_conservatively_charged_seconds']:.3f} seconds\n"
        f"Total runtime budget: {value['budget_limit_seconds']:.0f} seconds\nModel calls: 0; Windows notifications: off\n"
        f"All owned processes confirmed exited: {cleanup_confirmed}\nWhole-table state: {value['full_table_Lean']}\n")
    c.atomic(folder/"progress.txt",text.encode("utf-8"))
    c.atomic(c.RUN/"CURRENT_CAMPAIGN.json",dict(
        schema="LOCAL_NO_MODEL_ACTIVE_OR_FINAL_CAMPAIGN_POINTER_V16_INDEXED",utc=utc.isoformat(),
        campaign=manifest["name"],manifest=c.rel(folder/"manifest.json"),
        progress_json=c.rel(folder/"progress.json"),progress_text=c.rel(folder/"progress.txt"),
        state=value["state"],full_table_Lean=value["full_table_Lean"],
        all_owned_services_confirmed_exited=cleanup_confirmed,model_calls=0,notifications=False))
    return value
