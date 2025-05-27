# Python Project Template 🧰

**mycli** is a Python-based CLI tool starter template designed to help you bootstrap high-quality Python applications with batteries-included tooling. It features structured layouts, automation, testing, linting, and documentation support.

---

## 🚀 Features

- ✅ CLI entrypoint with [Typer](https://typer.tiangolo.com/)
- ✅ `src/mycli/` layout with type hints and linting
- ✅ Modern dependency and build system using `pyproject.toml` + [Hatch](https://hatch.pypa.io/latest/)
- ✅ Pre-configured development tools (black, ruff, mypy, pytest)
- ✅ Markdown documentation with live preview ([MkDocs Material](https://squidfunk.github.io/mkdocs-material/))
- ✅ Makefile-based automation for common tasks
- ✅ Release automation and PyPI publishing support

---

## 🧰 Requirements

- Python 3.9+
- Git
- Recommended: Unix-like shell or PowerShell for Makefile usage

---

## 📦 Installation

```bash
git clone https://github.com/your-username/python-project-template.git
cd python-project-template

make venv                 # Create virtual environment (.venv/)
make install              # Install dependencies
make precommit-install    # Optional: install pre-commit Git hooks
```

---

## 📂 Project Structure

```
python-project-template/
├── src/
│   └── mycli/
│       ├── __init__.py
│       └── cli.py
├── tests/
│   └── test_cli.py
├── docs/
│   └── index.md
├── pyproject.toml
├── hatch.toml
├── Makefile
├── README.md
└── ...
```

---

## 🧪 Usage

```bash
mycli --help
```

> This assumes your CLI entrypoint is defined in `mycli.cli:main`.

---

## 🛠 Development Workflow

### 🔍 Lint, Format, Type Check, Test

```bash
make format        # Format code using ruff & black
make lint          # Lint using ruff
make typecheck     # Type checking using mypy
make test          # Run all tests using pytest
make check         # Run lint + typecheck + test
```

---

### 🧼 Cleaning

```bash
make clean         # Remove build artifacts but keep .venv
make clean-all     # Remove .venv and all caches
```

---

### 🧪 Code Coverage

```bash
make coverage
```

Generates an HTML report in `htmlcov/index.html`.

---

### 🔁 Reset Environment

```bash
make reset
```

Performs: `clean-all → venv → install`

---

## 📚 Documentation (Live Preview)

```bash
make docs
```

Visit: [http://127.0.0.1:8000](http://127.0.0.1:8000)

---

## 🧹 Git Hooks & Pre-commit

```bash
make precommit-install  # Install pre-commit hook
make precommit          # Run all hooks manually (black, ruff, mypy)
```

---

## 🚀 Release & Publishing (with hatch)

```bash
make release-patch   # bump patch version, tag, push
make release-minor   # bump minor version, tag, push
make release-major   # bump major version, tag, push
make publish         # build and publish to PyPI using hatch
```

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).
