.PHONY: help setup test run sanity-check run-all run-llm clean

help:
	@echo "Available commands:"
	@echo "  make setup        - Setup Python environment and install dependencies"
	@echo "  make test         - Run tests with pytest"
	@echo "  make sanity-check - Run sanity check (HelloWorld:0)"
	@echo "  make run-all      - Run all puzzles and save results"
	@echo "  make run-llm      - Run with LLM fallback (ListIn:1 example)"
	@echo "  make clean        - Clean up generated files and caches"

setup:
	conda create -n holey python=3.12 || echo "Environment may already exist"
	@echo "Run 'conda activate holey' to activate the environment"
	pip install -e ".[test,ollama,anthropic,google-genai,openai]"

test:
	python -m pytest

sanity-check:
	python puzzle_solver.py --name-prefix HelloWorld:0

run-all:
	python puzzle_solver.py >results.txt 2>&1

run-llm:
	python puzzle_solver.py --name-prefix ListIn:1 --llm

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	rm -rf .pytest_cache
	rm -rf *.egg-info
	rm -rf build dist