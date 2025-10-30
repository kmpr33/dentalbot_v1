# Makefile pentru DentalBot

.PHONY: help setup dev test lint format clean seed

help:
	@echo "Comenzi utile:"
	@echo "  make setup      - Instalează dependențele în mediul curent"
	@echo "  make dev        - Pornește aplicația în mod de dezvoltare"
	@echo "  make test       - Rulează testele cu pytest"
	@echo "  make lint       - Rulează linting (ruff, mypy, black --check)"
	@echo "  make format     - Rulează formatarea codului cu black"
	@echo "  make seed       - Populează baza de date cu date inițiale"
	@echo "  make clean      - Șterge artefacte temporare"

setup:
	pip install -r requirements.txt

dev:
	uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

test:
	pytest -q

lint:
	ruff check app
	black --check app
	mypy app

format:
	black app

seed:
	python scripts/seed_data.py

clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -exec rm -r {} +