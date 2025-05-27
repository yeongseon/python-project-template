# Detect Python command
ifeq ($(OS),Windows_NT)
    PYTHON := $(shell where python)
    VENV_PYTHON := .venv/Scripts/python.exe
else
    PYTHON := $(shell which python3)
    VENV_PYTHON := .venv/bin/python
endif

# ------------------------------
# 🔧 Environment Setup
# ------------------------------
.PHONY: check-python
check-python:
	@$(PYTHON) -c "import sys; assert sys.version_info >= (3,9), '❌ Python 3.9+ is required'" || exit 1

.PHONY: venv
venv: check-python
	@$(PYTHON) -m venv .venv
	@echo "✅ Virtual environment created at .venv"

.PHONY: install
install: venv
	@$(VENV_PYTHON) -m pip install --upgrade pip
	@$(VENV_PYTHON) -m pip install -e .
	@$(VENV_PYTHON) -m pip install -e ".[dev]"
	
.PHONY: reset
reset: clean-all venv install
	@echo "🔁 Project reset complete."

# ------------------------------
# 🧹 Code Quality
# ------------------------------
.PHONY: format
format:
	@$(VENV_PYTHON) -m ruff format src tests
	@$(VENV_PYTHON) -m black src tests

.PHONY: lint
lint:
	@$(VENV_PYTHON) -m ruff check src tests

.PHONY: typecheck
typecheck:
	@$(VENV_PYTHON) -m mypy src tests

.PHONY: check
check: lint typecheck test
	@echo "✅ All checks passed!"

.PHONY: precommit
precommit:
	@$(VENV_PYTHON) -m pre_commit run --all-files

.PHONY: precommit-install
precommit-install:
	@$(VENV_PYTHON) -m pre_commit install

# ------------------------------
# 🧪 Testing & Coverage
# ------------------------------
.PHONY: test
test:
ifeq ($(OS),Windows_NT)
	@cmd /C "set PYTHONPATH=src && .venv\Scripts\python.exe -m pytest -v tests"
else
	@PYTHONPATH=src .venv/bin/python -m pytest -v tests
endif

.PHONY: coverage
coverage:
	@PYTHONPATH=src $(VENV_PYTHON) -m coverage run -m pytest
	@$(VENV_PYTHON) -m coverage report
	@$(VENV_PYTHON) -m coverage html
	@echo "📂 Open htmlcov/index.html in your browser to view the coverage report"

# ------------------------------
# 📦 Build & Release
# ------------------------------
.PHONY: build
build:
	@$(VENV_PYTHON) -m build

.PHONY: release
release:
ifndef VERSION
	$(error VERSION is not set. Usage: make release VERSION=0.1.0)
endif
	@git tag -a v$(VERSION) -m "Release v$(VERSION)"
	@git push origin v$(VERSION)

.PHONY: release-patch
release-patch:
	@hatch version patch
	@make release VERSION=$(shell hatch version)

.PHONY: release-minor
release-minor:
	@hatch version minor
	@make release VERSION=$(shell hatch version)

.PHONY: release-major
release-major:
	@hatch version major
	@make release VERSION=$(shell hatch version)

.PHONY: publish
publish:
	@hatch publish

# ------------------------------
# 📚 Documentation
# ------------------------------
.PHONY: docs
docs:
	@$(VENV_PYTHON) -m mkdocs serve

# ------------------------------
# 🩺 Diagnostic
# ------------------------------
.PHONY: doctor
doctor:
	@echo "🔍 Python version:"
	@$(VENV_PYTHON) --version
	@echo "🔍 Installed packages:"
	@$(VENV_PYTHON) -m pip list
	@echo "🔍 Azure Function Core Tools version:"
	@func --version || echo "⚠️ func not found. Install with: npm i -g azure-functions-core-tools@4"
	@echo "🔍 Pre-commit hook installed:"
ifeq ($(OS),Windows_NT)
	@if exist .git\hooks\pre-commit (echo ✅ Yes) else (echo ❌ No)
else
	@if [ -f .git/hooks/pre-commit ]; then echo ✅ Yes; else echo ❌ No; fi
endif

# ------------------------------
# 🧹 Clean
# ------------------------------
.PHONY: clean
ifeq ($(OS),Windows_NT)
clean:
	@for /d %%D in (*.egg-info dist build __pycache__ .pytest_cache) do if exist %%D rmdir /s /q %%D
else
clean:
	rm -rf *.egg-info dist build __pycache__ .pytest_cache
endif

.PHONY: clean-all
clean-all: clean
ifeq ($(OS),Windows_NT)
	@if exist .venv rmdir /s /q .venv
	@for /r %%D in (__pycache__) do if exist %%D rmdir /s /q %%D
	@for /r %%F in (*.pyc *.pyo) do if exist %%F del /q %%F
	@if exist .mypy_cache rmdir /s /q .mypy_cache
	@if exist .ruff_cache rmdir /s /q .ruff_cache
	@if exist .pytest_cache rmdir /s /q .pytest_cache
	@if exist .coverage del /q .coverage
	@if exist coverage.xml del /q coverage.xml
	@if exist .DS_Store del /q .DS_Store
else
	rm -rf .venv
	find . -type d -name "__pycache__" -exec rm -rf {} \;
	find . -type f \( -name "*.pyc" -o -name "*.pyo" \) -delete
	rm -rf .mypy_cache .ruff_cache .pytest_cache .coverage coverage.xml .DS_Store
endif

# ------------------------------
# 🆘 Help
# ------------------------------
.PHONY: help
help:
	@echo "📖 Available commands:" && \
	grep -E '^\.PHONY: ' Makefile | cut -d ':' -f2 | xargs -n1 echo "  - make"
