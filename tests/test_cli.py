from typer.testing import CliRunner

from mycli.cli import app

runner = CliRunner()

def test_hello_default():
    result = runner.invoke(app, [])
    print(result.output)
    assert result.exit_code == 0
    assert "Hello, world!" in result.output

def test_hello_custom():
    result = runner.invoke(app, ["--name", "Alice"])
    print(result.output)
    assert result.exit_code == 0
    assert "Hello, Alice!" in result.output
