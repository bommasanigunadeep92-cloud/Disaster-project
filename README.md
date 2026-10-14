# AI-Assisted Smart Disaster Response & Emergency Coordination Platform

A mission-critical emergency operations control-center web application built with **React 19 + TypeScript + Vite + Tailwind CSS** on the frontend and **FastAPI + SQLAlchemy + Pydantic** on the backend, featuring the official **Google Gen AI SDK (`google-genai`)** for decision-support intelligence.

---

## 🌟 Key Innovative Features

### 1. AI-Powered Disaster Victim Detection & Rescue Prioritization
- **Transparent Deterministic Risk-Scoring Engine (0–100 Points)**:
  - **Hazard Severity (0–40 pts)**: Water depth / seismic intensity / fire spread velocity.
  - **Estimated Population Exposure (0–25 pts)**: Population density per affected census polygon.
  - **Structural Building Exposure (0–20 pts)**: Cadastral building footprint count.
  - **Verified Incident Evidence (0–15 pts)**: Scaled from confirmed nearby SOS reports (3 pts per verified report, capped at 15).
- **Categories**:
  - `0–24`: Low Risk
  - `25–49`: Moderate Risk
  - `50–74`: High Risk
  - `75–100`: Critical Risk
- **Ethical Safeguard**: Highlights **RISK AREAS**, not confirmed individual victims. Incomplete satellite or census data displays an explicit data-completeness warning and does not imply safety. Requires mandatory human coordinator confirmation before dispatching rescue investigation tasks.

### 2. Official Google Gemini Gen AI Integration (`google-genai`)
Four specialized backend AI services with **zero API key leakage** to the browser:
1. **AI Emergency Triage**: Summarizes incoming distress signals, classifies the emergency, and provides preliminary urgency suggestions with confidence indicators.
2. **Emergency Report Assistant**: Parses raw citizen audio transcripts and unstructured text into structured operational parameters (disaster type, location, affected count, immediate danger).
3. **Disaster Response Assistant**: Generates tactical situational briefings, recommended team profiles (e.g. Swift Water, Heavy USAR, Drone Recon), and critical hazard warnings for coordinators.
4. **Disaster Analytics Assistant**: Analyzes operational telemetry to uncover spatial clustering, resource bottlenecks, and strategic deployment advice.
5. **High-Fidelity Heuristic Fallback**: If `GEMINI_API_KEY` is not provided or encounters network limits, the platform switches seamlessly to deterministic rule-based heuristics without crashing.

---

## 🏛️ Platform Architecture & 8 Interactive Pages

| Module / Page | Route | Description |
|---|---|---|
| **Command Dashboard** | `/` | Real-time KPIs, multi-hazard intake queue, team readiness, interactive map preview, and 24h demand trajectory chart. |
| **Victim Risk Prioritization** | `/risk-zones` | Leaflet spatial inundation polygons, 0–100 risk score breakdown, ranked hotspot table, and investigation dispatch. |
| **One-Tap Voice SOS** | `/voice-sos` | Minimal-interaction public reporting with browser MediaRecorder audio capture, GPS tagging, Gemini structured extraction, and tracking token lookup. |
| **AI Emergency Triage** | `/triage` | Coordinator queue with Gemini incident summarization, uncertainty ratings, priority overrides, and audit logging. |
| **Interactive Incident Map** | `/map` | Full-screen multi-layer GIS map (reported distress points, risk zone boundaries, and rescue unit positions). |
| **Rescue Teams & Dispatch** | `/teams` | Unit availability, atomic database transaction assignment, duplicate assignment prevention, and Gemini Disaster Response Assistant. |
| **Missing Persons Portal** | `/missing-persons` | Missing/Found registries with explainable multi-factor similarity matching (age, gender, location, clothing) and privacy masking for the public. |
| **Disaster Analytics** | `/analytics` | Recharts visualizations for incident types, response timings, weekly trends, Gemini Analytics Assistant, and safe CSV export. |

---

## 👥 Demo Roles & Sample Accounts

The application provides a built-in **Persona Switcher** in the sidebar:

| Role | Email | Password | Permissions |
|---|---|---|---|
| **Emergency Coordinator** | `coordinator@ops.local` | `CoordPass123!` | Full operational access: triage, risk zones, dispatch, matching review |
| **Administrator** | `admin@ops.local` | `AdminPass123!` | System-wide visibility, account review, and audit trail inspection |
| **Rescue Team Leader** | `teamlead@ops.local` | `RescuePass123!` | View dispatched incidents, report on-scene findings, and update readiness |
| **Public Citizen** | `citizen@example.com` | `PublicPass123!` | Submit Voice/Text SOS reports, register missing persons, track report token |

---

## 🚀 Quick Start Guide

### Prerequisites
- **Python**: 3.10+ (Tested on Python 3.11 - 3.14)
- **Node.js**: v18+ or v20+
- **npm**: v9+

### Step 1: Configure Backend Environment
Navigate to the `backend` directory:
```bash
cd backend
```

Create your local `.env` file from the provided `.env.example`:
```bash
copy .env.example .env    # On Windows
# or: cp .env.example .env # On Linux/macOS
```

Edit `backend/.env` and insert your Gemini API key:
```env
GEMINI_API_KEY=your_actual_gemini_api_key_here
PORT=8000
HOST=0.0.0.0
DATABASE_URL=sqlite:///./disaster_platform.db
JWT_SECRET_KEY=demo_secret_key_change_in_production_8947291038571
ALLOWED_ORIGINS=http://localhost:5173,http://localhost:3000,http://127.0.0.1:5173
```
> **Security Note:** `backend/.env` is ignored by Git in `.gitignore`. Your Gemini API key is never exposed to the frontend or git repositories.

### Step 2: Install Backend Dependencies & Run Server
In `backend`:
```bash
pip install -r requirements.txt
python -m uvicorn app.main:app --reload --port 8000
```
- API Documentation (Swagger UI): `http://localhost:8000/docs`
- Healthcheck: `http://localhost:8000/api/health`
- AI Status: `http://localhost:8000/api/ai/status`

### Step 3: Start Frontend Client
Open a second terminal and navigate to `frontend`:
```bash
cd frontend
npm install
npm run dev
```
Open your browser at: **`http://localhost:5173`**

---

## 🧪 Running Tests

### Backend Test Suite (Pytest)
Run the automated test suite covering authentication, deterministic risk scoring, missing person matching, invalid state transitions, and mocked Gemini AI calls:
```bash
# In the project root:
$env:PYTHONPATH="backend"; python -m pytest backend/tests/test_backend.py -v
```
All tests use **mocked Gemini responses**, allowing full test execution without requiring an active API key or incurring quota costs.

### Frontend Production Build
```bash
cd frontend
npm run build
```

---

## 🐳 Docker Deployment

To launch the complete platform using Docker Compose:
```bash
docker-compose up --build
```
- Backend API: `http://localhost:8000`
- Frontend Portal: `http://localhost:5173`

---

## 🛡️ Gemini Integration Verification

1. **Verify Backend Status**:
   Visit `http://localhost:8000/api/ai/status`.
   - If `GEMINI_API_KEY` is present and valid, you will see:
     ```json
     {
       "gemini_configured": true,
       "model": "gemini-2.5-flash",
       "mode": "gemini_live",
       "disclaimer": "AI-assisted decision-support suggestion only..."
     }
     ```
   - If no key is set, it gracefully displays `"mode": "demo_fallback"`.
2. **Verify Frontend Indicator**:
   Look at the top header bar in the web app:
   - When live: Displays a purple **"Gemini 2.5 Flash Live"** pill.
   - In fallback: Displays a blue **"AI Demo Mode (Heuristic Fallback)"** pill.
3. **Verify AI Assistants**:
   - Go to **One-Tap Voice SOS** (`/voice-sos`), enter text, and click **"Analyze with Gemini Assistant"**.
   - Go to **AI Emergency Triage** (`/triage`), select any incident, and click **"Re-analyze with Gemini"**.
   - Go to **Rescue Teams** (`/teams`) to view the **Gemini Tactical Assistant** recommendations.
   - Go to **Disaster Analytics** (`/analytics`) to view the **Gemini Operational Intelligence** briefing.
