#!/usr/bin/env python3
"""
🛠 Project Initialization Script

This script customizes the template by replacing placeholder values such as:
- Project name (e.g., "Python Project Template")
- PyPI name (e.g., "my-cli-tool")
- Package name (e.g., "mycli_tool") — must be a valid Python identifier
- Author name
- Project description

It also renames the default Python package directory (`src/mycli`) to the name you provide.
Optionally, it can reset the Git history by deleting the existing `.git` folder and starting fresh.

📦 Usage:
    python scripts/init.py
"""

import os
import shutil
from pathlib import Path

# Define the root directory of the project (assumes this script is in scripts/)
ROOT = Path(__file__).resolve().parent.parent

# List of files to update with replacements
FILES = [
    "pyproject.toml",
    "README.md",
    "mkdocs.yml",
    "docs/index.md",
    "docs/development.md",
    "docs/release.md",
    "docs/document.md",
    "docs/reference/mycli.md",
    "Makefile",
    "tests/test_cli.py",
]

# Placeholder values in the template
DEFAULTS = {
    "project_name": "Python Project Template",
    "author": "Yeongseon Choe",
    "description": "A modern Python project template with CLI, tests, docs, and automation",
    "package_name": "mycli",
    "pypi_name": "mycli",  # used in pyproject.toml `name`
}


def replace_in_file(file_path: Path, replacements: dict[str, str]) -> None:
    """Replace placeholder strings in a single file."""
    if not file_path.exists():
        return
    text = file_path.read_text(encoding="utf-8")
    for old, new in replacements.items():
        text = text.replace(old, new)
    file_path.write_text(text, encoding="utf-8")


def main() -> None:
    print("🔧 Project Initialization\n")

    # Prompt the user for inputs
    project_name = input("📦 Project name (e.g. My CLI Tool): ").strip()
    pypi_name = input("🔖 PyPI project name (e.g. my-cli-tool): ").strip()
    raw_package_name = input("📂 Python package name (e.g. my_cli_tool): ").strip()
    package_name = raw_package_name.replace("-", "_")  # Python-safe
    author = input("👤 Author name: ").strip()
    description = input("📝 Description: ").strip()
    reset_git = input("🔃 Reset Git history? (y/N): ").strip().lower() == "y"

    # Create replacement mapping
    replacements = {
        DEFAULTS["project_name"]: project_name,
        DEFAULTS["author"]: author,
        DEFAULTS["description"]: description,
        DEFAULTS["package_name"]: package_name,
        DEFAULTS["pypi_name"]: pypi_name,  # for pyproject.toml `name`
    }

    # Apply replacements to files
    for rel_path in FILES:
        file_path = ROOT / rel_path
        replace_in_file(file_path, replacements)

    # Rename the package directory: src/mycli → src/{package_name}
    old_pkg = ROOT / "src" / DEFAULTS["package_name"]
    new_pkg = ROOT / "src" / package_name
    if old_pkg.exists() and old_pkg != new_pkg:
        shutil.move(str(old_pkg), str(new_pkg))
        print(f"📂 Renamed src/{DEFAULTS['package_name']} → src/{package_name}")

    # Optionally reset Git history
    if reset_git:
        print("🧹 Removing existing Git history...")
        shutil.rmtree(ROOT / ".git", ignore_errors=True)
        os.system("git init && git add . && git commit -m 'feat: initialize project from template'")
        print("✅ Git history has been reset.")

    print("\n✅ Initialization complete! You're ready to start coding.")


if __name__ == "__main__":
    main()
