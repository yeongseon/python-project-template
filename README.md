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

make install              # Create Hatch environment & install dev dependencies
make precommit-install    # Optional: install pre-commit Git hooks
```

Hatch uses `[tool.hatch.envs.default] features = ["dev"]` to load optional development dependencies.

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
├── Makefile
├── README.md
└── ...
```

---

## 🧪 Usage

```bash
mycli hello --name Alice
```

> This assumes your CLI entrypoint is defined as a Typer app object (`mycli.cli:app`) with a `hello` command.

---

## 🛠 Development Workflow

### 🔍 Lint, Format, Type Check, Test

```bash
make format        # Format code using ruff & black
make lint          # Lint using ruff
make typecheck     # Type checking using mypy
make test          # Run all tests using pytest
make check         # Run lint + typecheck only
make check-all     # Run lint + typecheck + tests
```

---

### 🧼 Cleaning

```bash
make clean         # Remove build artifacts but keep environment
make clean-all     # Remove all build artifacts and Hatch environment
```

---

### 🧪 Code Coverage

```bash
make cov
```

Generates an HTML report in `htmlcov/index.html`.

---

### 🔁 Reset Environment

```bash
make reset
```

Performs: `clean-all → install`

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
make precommit          # Run pre-commit hooks manually (black, ruff, mypy)

# Note: Tests are NOT included in pre-commit hooks.
# Run `make test` or `make check-all` for full validation.
```

---

## 🚀 Release & Publishing (with Hatch)

```bash
make release-patch   # bump patch version, tag, push
make release-minor   # bump minor version, tag, push
make release-major   # bump major version, tag, push
make publish         # build and publish to PyPI using hatch
```

---


---

## 🔖 Common Commands (Summary)

| Task                 | Command            |
|----------------------|--------------------|
| Format code          | `make format`      |
| Lint code            | `make lint`        |
| Type check           | `make typecheck`   |
| Run tests            | `make test`        |
| Run all checks       | `make check-all`   |
| Pre-commit hooks     | `make precommit`   |
| Coverage report      | `make cov`         |
| Serve documentation  | `make docs`        |
| Clean build artifacts| `make clean`       |
| Full clean/reset     | `make clean-all` / `make reset` |


## 📄 License

This project is licensed under the [MIT License](LICENSE).
