import sys
import textwrap
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(REPO_ROOT / "scripts"))

import update_formula  # noqa: E402


FORMULA_FIXTURE = textwrap.dedent('''\
    class Locally < Formula
      desc "Local Azure environment that runs entirely on your machine"
      homepage "https://locally.build/"
      version "2026.09"

      if OS.mac?
        if Hardware::CPU.arm?
          url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"
          sha256 "aaa"
        end

        if Hardware::CPU.intel?
          url "https://get.locally.build/v1/cli/#{version}/darwin/amd64"
          sha256 "bbb"
        end
      end

      if OS.linux?
        if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
          url "https://get.locally.build/v1/cli/#{version}/linux/arm64"
          sha256 "ccc"
        end

        if Hardware::CPU.intel?
          url "https://get.locally.build/v1/cli/#{version}/linux/amd64"
          sha256 "ddd"
        end
      end

      def install
        bin.install "locally"
      end

      test do
        system bin/"locally", "version"
      end
    end
''')


class TestSmoke(unittest.TestCase):
    def test_module_imports(self):
        self.assertEqual(
            update_formula.PLATFORMS,
            ("darwin/arm64", "darwin/amd64", "linux/arm64", "linux/amd64"),
        )


class TestParseFormula(unittest.TestCase):
    def test_parses_version(self):
        result = update_formula.parse_formula(FORMULA_FIXTURE)
        self.assertEqual(result["version"], "2026.09")

    def test_parses_all_four_shas(self):
        result = update_formula.parse_formula(FORMULA_FIXTURE)
        self.assertEqual(
            result["shas"],
            {
                "darwin/arm64": "aaa",
                "darwin/amd64": "bbb",
                "linux/arm64": "ccc",
                "linux/amd64": "ddd",
            },
        )

    def test_missing_version_raises(self):
        bad = FORMULA_FIXTURE.replace('version "2026.09"', "")
        with self.assertRaisesRegex(ValueError, "version declaration"):
            update_formula.parse_formula(bad)

    def test_missing_platform_sha_raises(self):
        bad = FORMULA_FIXTURE.replace('sha256 "aaa"', "")
        with self.assertRaisesRegex(ValueError, "darwin/arm64"):
            update_formula.parse_formula(bad)


class TestWriteFormula(unittest.TestCase):
    NEW_SHAS = {
        "darwin/arm64": "newAA",
        "darwin/amd64": "newBB",
        "linux/arm64": "newCC",
        "linux/amd64": "newDD",
    }

    def test_rewrites_version(self):
        new = update_formula.write_formula(
            FORMULA_FIXTURE, "2026.09.01", self.NEW_SHAS
        )
        self.assertIn('version "2026.09.01"', new)
        self.assertNotIn('version "2026.09"\n', new)

    def test_rewrites_each_platform_sha(self):
        new = update_formula.write_formula(
            FORMULA_FIXTURE, "2026.09", self.NEW_SHAS
        )
        self.assertIn('sha256 "newAA"', new)
        self.assertIn('sha256 "newBB"', new)
        self.assertIn('sha256 "newCC"', new)
        self.assertIn('sha256 "newDD"', new)
        for old in ("aaa", "bbb", "ccc", "ddd"):
            self.assertNotIn(f'"{old}"', new)

    def test_idempotent(self):
        once = update_formula.write_formula(
            FORMULA_FIXTURE, "2026.09", self.NEW_SHAS
        )
        twice = update_formula.write_formula(once, "2026.09", self.NEW_SHAS)
        self.assertEqual(once, twice)

    def test_round_trip_through_parse(self):
        new = update_formula.write_formula(
            FORMULA_FIXTURE, "2026.09.01", self.NEW_SHAS
        )
        parsed = update_formula.parse_formula(new)
        self.assertEqual(parsed["version"], "2026.09.01")
        self.assertEqual(parsed["shas"], self.NEW_SHAS)

    def test_missing_target_platform_raises(self):
        bad = FORMULA_FIXTURE.replace(
            '      url "https://get.locally.build/v1/cli/#{version}/darwin/arm64"\n      sha256 "aaa"',
            "",
        )
        with self.assertRaisesRegex(ValueError, "darwin/arm64"):
            update_formula.write_formula(bad, "2026.09.01", self.NEW_SHAS)


class TestRealFormula(unittest.TestCase):
    def test_parses_committed_formula(self):
        content = (REPO_ROOT / "Formula" / "locally.rb").read_text()
        parsed = update_formula.parse_formula(content)
        self.assertRegex(parsed["version"], r"^\d{4}\.\d{2}(\.\d+)?$")
        self.assertEqual(set(parsed["shas"]), set(update_formula.PLATFORMS))
        for platform, sha in parsed["shas"].items():
            with self.subTest(platform=platform):
                self.assertRegex(sha, r"^[0-9a-f]{64}$")
        self.assertEqual(
            len(set(parsed["shas"].values())),
            len(update_formula.PLATFORMS),
            "each platform should have a distinct sha256",
        )
