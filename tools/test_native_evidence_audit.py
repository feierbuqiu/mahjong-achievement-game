"""Regression tests for the publication auditor's bucket-close acceptance boundary."""
import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location('native_audit', Path(__file__).with_name('audit_native_evidence.py'))
AUDIT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AUDIT)


class NativeCloseAuditTests(unittest.TestCase):
    def event(self):
        return dict(event='BUCKET_CLOSED', layer=32, honor=1,
                    checked_rows=56, exactCoverage=True, ranges=[[0, 56]])

    def test_recorded_complete_close_is_accepted(self):
        AUDIT.check_close(self.event(), 32, 1, 56, [[0, 56]])

    def test_missing_false_or_truthy_non_boolean_flags_are_rejected(self):
        for value in [False, None, 1, 'true']:
            event = self.event()
            event['exactCoverage'] = value
            with self.subTest(flag=value), self.assertRaises(ValueError):
                AUDIT.check_close(event, 32, 1, 56, [[0, 56]])

    def test_preflight_and_incomplete_range_cannot_be_used_as_completed_bucket(self):
        for field, value in [('checked_rows', 0), ('ranges', []), ('honor', 2)]:
            event = self.event()
            event[field] = value
            with self.subTest(field=field), self.assertRaises(ValueError):
                AUDIT.check_close(event, 32, 1, 56, [[0, 56]])


if __name__ == '__main__':
    unittest.main()
