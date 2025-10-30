#!/usr/bin/env bash
set -e

# Script de pornire pentru container

echo "Pornire migrări (dacă există)"
python scripts/create_db.py || true
python scripts/seed_data.py || true

echo "Pornire aplicație FastAPI"
exec uvicorn app.main:app --host 0.0.0.0 --port 8000