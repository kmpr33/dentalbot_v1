# DentalBot v1

DentalBot v1 este un proiect complet pentru clinici stomatologice de dimensiune mică și medie. Acest proiect implementă un bot omnichannel capabil să gestioneze programări, notificări, conversații pe canale de mesagerie (Meta Messenger, WhatsApp Business și Telegram) și un panou de administrare pentru gestionarea clinicii. Scopul proiectului este să ofere un exemplu de implementare end‑to‑end a unui asistent digital care poate fi rulat local sau în containere Docker.

## Funcționalități principale

* **API REST** construit cu [FastAPI](https://fastapi.tiangolo.com/) și [SQLAlchemy](https://www.sqlalchemy.org/).
* **Autentificare și autorizare** bazate pe JWT (access și refresh tokens), cu rotația cheilor de semnare și roluri (Admin, Recepție, Doctor).
* **Model de date complet** pentru utilizatori, pacienți, servicii, programări, template‑uri de mesaje, conversații și audit trail.
* **Admin panel** simplu bazat pe Jinja2, HTMX și Tailwind. Acesta include dashboard, gestiune pacienți, programări, servicii și template‑uri de mesaje.
* **Integrare omnichannel**: clienți pentru Meta Messenger și WhatsApp Business, precum și un client Telegram. Acestea pot trimite mesaje text, quick replies și template‑uri predefinite.
* **Calendar intern** cu generare de sloturi libere în funcție de orele de lucru configurabile și duratele serviciilor.
* **Notificări programate**: reminder‑e automate la 24h și 2h înainte de programare, folosind [APScheduler](https://apscheduler.readthedocs.io/).
* **Scripturi de seed** pentru popularea bazei de date cu un utilizator admin, servicii de bază și template‑uri de mesaje.
* **Docker‑first**: se poate rula local sau în containere cu `docker-compose` (aplicația FastAPI și un server Nginx pentru servirea staticelor).
* **Testare** cu pytest (acoperire minimă de 85%) și configurare CI via GitHub Actions.

> **Notă**: Acest proiect este furnizat ca exemplu educațional. Multe dintre funcționalități sunt implementate într-o formă simplificată sau ca schelet și pot necesita adaptări pentru uz în producție.

## Structura repo

```
dentalbot_v1/
  README.md            # Documentația proiectului
  LICENSE              # Licența (MIT)
  .env.example         # Exemplu de fișier de configurare
  docker-compose.yml   # Compoziție Docker pentru dezvoltare
  Dockerfile           # Build multi-stage pentru aplicație
  Makefile             # Comenzi rapide pentru dezvoltare
  pyproject.toml       # Configurare pentru build/test/lint
  requirements.txt     # Pachete Python necesare
  scripts/             # Scripturi auxiliare (seed, create_db etc.)
  infra/               # Fișiere de infrastructură (ex: Nginx)
  app/                 # Codul sursă al aplicației
  tests/               # Teste unitare, API și e2e
```

## Instrucțiuni de rulare locală

1. Clonați acest repository și intrați în directorul său:

   ```bash
   git clone <repository-url> dentalbot_v1
   cd dentalbot_v1
   ```

2. Creați și activați un mediu virtual (opțional dar recomandat):

   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```

3. Copiați fișierul `.env.example` în `.env` și actualizați variabilele necesare (de exemplu `SECRET_KEY`, token‑urile Meta/Telegram etc.).

   ```bash
   cp .env.example .env
   ```

4. Instalați dependențele Python:

   ```bash
   pip install -r requirements.txt
   ```

5. Creați baza de date și aplicați migrările (folosind scripturile din `scripts/`):

   ```bash
   python scripts/create_db.py
   python scripts/seed_data.py
   ```

6. Porniți aplicația local:

   ```bash
   uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
   ```

7. Vizitați [http://localhost:8000/docs](http://localhost:8000/docs) pentru a vedea documentația interactivă generată de FastAPI (OpenAPI / Swagger).

8. Pentru a accesa panoul de administrare, mergeți la [http://localhost:8000/admin/dashboard](http://localhost:8000/admin/dashboard) după autentificare.

## Rulare cu Docker

Proiectul include un fișier `docker-compose.yml` care pornește aplicația FastAPI și un container Nginx pentru servirea fișierelor statice și proxy invers. Pentru a rula cu Docker:

```bash
docker compose up --build
```

Apoi accesați [http://localhost](http://localhost) pentru interfața Nginx care redirecționează către aplicație.

## Testare

Pentru a rula testele unitare și API, utilizați [pytest](https://docs.pytest.org/en/latest/):

```bash
pytest -q
```

Acoperirea codului este configurată în `pyproject.toml`. Pentru a vedea un raport de acoperire, rulați:

```bash
pytest --cov=app --cov-report=term-missing
```

## Linting și formatare

Proiectul utilizează [Ruff](https://ruff.rs/), [Black](https://github.com/psf/black) și [MyPy](http://mypy-lang.org/) pentru calitatea codului. Puteți rula toate verificările cu:

```bash
make lint
```

## Licență

Acest proiect este licențiat sub [MIT License](LICENSE).