"""Read or rewrite Formula/locally.rb for the homebrew-tap update workflow."""

import argparse
import json
import re
from pathlib import Path

PLATFORMS = ("darwin/arm64", "darwin/amd64", "linux/arm64", "linux/amd64")


def parse_formula(content: str) -> dict:
    version_match = re.search(r'^\s*version\s+"([^"]+)"', content, re.MULTILINE)
    if not version_match:
        raise ValueError("version declaration not found in Formula")

    shas: dict = {}
    for platform in PLATFORMS:
        pattern = (
            r'url\s+"[^"]*/'
            + re.escape(platform)
            + r'"\s*\n\s*sha256\s+"([^"]+)"'
        )
        sha_match = re.search(pattern, content)
        if not sha_match:
            raise ValueError(f"sha256 line for platform {platform} not found")
        shas[platform] = sha_match.group(1)

    return {"version": version_match.group(1), "shas": shas}


def write_formula(content: str, new_version: str, new_shas: dict) -> str:
    new_content, count = re.subn(
        r'^(\s*version\s+")[^"]+(")',
        lambda m: m.group(1) + new_version + m.group(2),
        content,
        count=1,
        flags=re.MULTILINE,
    )
    if count != 1:
        raise ValueError("version declaration not found in Formula")

    for platform in PLATFORMS:
        if platform not in new_shas:
            raise ValueError(f"new sha for platform {platform} not provided")
        pattern = (
            r'(url\s+"[^"]*/'
            + re.escape(platform)
            + r'"\s*\n\s*sha256\s+")[^"]+(")'
        )
        new_content, count = re.subn(
            pattern,
            lambda m, sha=new_shas[platform]: m.group(1) + sha + m.group(2),
            new_content,
            count=1,
        )
        if count != 1:
            raise ValueError(f"sha256 line for platform {platform} not found")

    return new_content


def cmd_read(args: argparse.Namespace) -> None:
    content = Path(args.formula).read_text()
    parsed = parse_formula(content)
    print(json.dumps(parsed))


def cmd_write(args: argparse.Namespace) -> None:
    path = Path(args.formula)
    content = path.read_text()
    new_shas = {
        "darwin/arm64": args.sha_darwin_arm64,
        "darwin/amd64": args.sha_darwin_amd64,
        "linux/arm64": args.sha_linux_arm64,
        "linux/amd64": args.sha_linux_amd64,
    }
    new_content = write_formula(content, args.version, new_shas)
    path.write_text(new_content)


def _build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="update_formula")
    subs = parser.add_subparsers(dest="cmd", required=True)

    read_p = subs.add_parser("read", help="Print current Formula state as JSON")
    read_p.add_argument("formula", help="Path to Formula/locally.rb")
    read_p.set_defaults(func=cmd_read)

    write_p = subs.add_parser("write", help="Rewrite Formula in place")
    write_p.add_argument("formula", help="Path to Formula/locally.rb")
    write_p.add_argument("--version", required=True)
    write_p.add_argument("--sha-darwin-arm64", required=True)
    write_p.add_argument("--sha-darwin-amd64", required=True)
    write_p.add_argument("--sha-linux-arm64", required=True)
    write_p.add_argument("--sha-linux-amd64", required=True)
    write_p.set_defaults(func=cmd_write)

    return parser


if __name__ == "__main__":
    args = _build_parser().parse_args()
    args.func(args)
