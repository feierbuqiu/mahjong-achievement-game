"""Regression cases for the escaped-path disclosure found in October 2026."""
import importlib.util
import io
import json
from pathlib import Path
import unittest
from urllib.parse import quote
import zipfile

SPEC = importlib.util.spec_from_file_location('privacy_guard', Path(__file__).with_name('privacy_guard.py'))
GUARD = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GUARD)


class PrivacyRegressionTests(unittest.TestCase):
    def setUp(self):
        self.private = 'C:' + chr(92) + 'Users' + chr(92) + 'example-user' + chr(92) + 'research'

    def test_plain_json_and_nested_json_paths(self):
        for text in [self.private, json.dumps({'nested': [self.private]}),
                     json.dumps({'embedded': json.dumps({'root': self.private})})]:
            with self.subTest(representation=text[:2]):
                self.assertIn('personal-home-path', GUARD.inspect_text(text))

    def test_unicode_and_url_escaped_paths(self):
        encoded = self.private.replace(chr(92), chr(92) + 'u005c')
        for text in [encoded, quote(self.private, safe='')]:
            self.assertIn('personal-home-path', GUARD.inspect_text(text))

    def test_unix_and_mounted_home_paths(self):
        for prefix in ['/' + 'home/', '/' + 'Users/', '/mnt/c/' + 'Users/']:
            self.assertIn('personal-home-path', GUARD.inspect_text(prefix + 'example-user/work'))

    def test_placeholders_and_relative_sources_are_allowed(self):
        for text in ['<user-home>/research', '<research-root>/runs/example',
                     'runs/lean_table_checker/example', '/opt/toolchain/bin/lean']:
            self.assertEqual(GUARD.inspect_text(text), [])

    def test_archive_contents_are_scanned(self):
        stream = io.BytesIO()
        with zipfile.ZipFile(stream, 'w') as archive:
            archive.writestr('receipt.json', json.dumps({'root': self.private}))
        with self.assertRaisesRegex(ValueError, 'Privacy check failed'):
            GUARD.check_zip(stream)

    def test_unsafe_archive_member_is_rejected(self):
        stream = io.BytesIO()
        with zipfile.ZipFile(stream, 'w') as archive:
            archive.writestr('../outside.txt', 'example')
        with self.assertRaisesRegex(ValueError, 'Unsafe archive'):
            GUARD.check_zip(stream)


if __name__ == '__main__':
    unittest.main()
