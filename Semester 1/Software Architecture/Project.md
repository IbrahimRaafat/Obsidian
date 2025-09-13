# Schema (two seperate):
---------------------------------------------------------------------------- 
--one-time
CREATE EXTENSION IF NOT EXISTS citext;

-- ===== auth =====
CREATE SCHEMA IF NOT EXISTS auth;
CREATE TYPE auth.role_enum AS ENUM ('patient','doctor','admin');

CREATE TABLE auth.users (
  id UUID PRIMARY KEY,
  email CITEXT UNIQUE NOT NULL,
  pass_hash TEXT NOT NULL,
  role auth.role_enum NOT NULL,
  totp_secret BYTEA,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE auth.refresh_tokens (
  id UUID PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ===== care =====
CREATE SCHEMA IF NOT EXISTS care;

CREATE TYPE care.appt_status AS ENUM ('REQUESTED','APPROVED','REJECTED','SCHEDULED','CANCELLED','COMPLETED');
CREATE TYPE care.doc_status  AS ENUM ('UPLOADED','PROCESSING','READY','FAILED');

CREATE TABLE care.patients (
  id UUID PRIMARY KEY,
  user_id UUID UNIQUE NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT NOT NULL,
  dob DATE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE care.doctors (
  id UUID PRIMARY KEY,
  user_id UUID UNIQUE NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  specialty TEXT NOT NULL,
  capacity INT NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE care.appointments (
  id UUID PRIMARY KEY,
  patient_id UUID NOT NULL REFERENCES care.patients(id) ON DELETE CASCADE,
  doctor_id  UUID NOT NULL REFERENCES care.doctors(id)  ON DELETE CASCADE,
  status care.appt_status NOT NULL DEFAULT 'REQUESTED',
  scheduled_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE care.documents (
  id UUID PRIMARY KEY,
  patient_id UUID NOT NULL REFERENCES care.patients(id) ON DELETE CASCADE,
  file_name TEXT NOT NULL,
  mime_type TEXT NOT NULL,
  size_bytes BIGINT,
  storage_ref TEXT,      -- use this OR file_bytea
  file_bytea BYTEA,      -- (keep one path; simplest is BYTEA)
  status care.doc_status NOT NULL DEFAULT 'UPLOADED',
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE care.document_summaries (
  id UUID PRIMARY KEY,
  document_id UUID UNIQUE NOT NULL REFERENCES care.documents(id) ON DELETE CASCADE,
  summary_text TEXT NOT NULL,
  keywords TEXT[],
  pages INT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Helpful indexes
CREATE INDEX ix_auth_users_email ON auth.users(email);
CREATE INDEX ix_care_appt_patient ON care.appointments(patient_id, created_at DESC);
CREATE INDEX ix_care_appt_doctor  ON care.appointments(doctor_id, created_at DESC);
CREATE INDEX ix_care_doc_patient  ON care.documents(patient_id, created_at DESC);


--------------------------------------------------------------------------
# Folder layout (feature-/domain-first)

/src
  /app                    # app shell, providers, global error boundaries
    App.tsx
    AppRouter.tsx
    providers.tsx
    error-boundary.tsx
  /shared                 # reused everywhere
    /ui                   # design system: Button, Card, Table, Modal, Form...
    /lib                  # axios client, date utils, zod schemas, constants
    /hooks                # useDebounce, useLocalStorage, etc.
    /auth                 # RBAC utils, RoleGate component, auth types
    /assets               # logos, icons
  /domains
    /admin                # admin-only features
      /routes             # route components
      /api                # admin endpoints (thin wrappers)
      /components         # admin-specific UI
    /patient              # patient portal
      /routes             # Profile, Documents, Appointments
      /api                # patient endpoints
      /components
    /doctor               # doctor portal
      /routes             # Queue, Schedule, PatientDocs
      /api
      /components
    /documents            # cross-role document widgets
      /components         # PdfUploader, SummaryCard
      /api                # doc endpoints (owned by Care svc)
    /appointments         # cross-role appointment widgets
      /components         # AppointmentTable, RequestForm, Scheduler
      /api
  /test                   # test utils, fixtures
main.tsx
index.css

# Routing & RBAC
``` tsx
// src/app/AppRouter.tsx
import { lazy, Suspense } from "react";
import { Route, Routes, Navigate } from "react-router-dom";
import { RequireAuth, RoleGate } from "@/shared/auth";

const AdminApp   = lazy(() => import("@/domains/admin/routes"));
const PatientApp = lazy(() => import("@/domains/patient/routes"));
const DoctorApp  = lazy(() => import("@/domains/doctor/routes"));

export default function AppRouter() {
  return (
    <Suspense fallback={<div className="p-8">Loading…</div>}>
      <Routes>
        <Route path="/login" element={<LoginPage />} />
        <Route element={<RequireAuth />}>
          <Route
            path="/admin/*"
            element={<RoleGate roles={["admin"]}><AdminApp/></RoleGate>}
          />
          <Route
            path="/patient/*"
            element={<RoleGate roles={["patient"]}><PatientApp/></RoleGate>}
          />
          <Route
            path="/doctor/*"
            element={<RoleGate roles={["doctor","nurse"]}><DoctorApp/></RoleGate>}
          />
        </Route>
        <Route path="*" element={<Navigate to="/login" replace />} />
      </Routes>
    </Suspense>
  );
}

```

``` tsx
// src/shared/auth/index.tsx
import { createContext, useContext } from "react";
type Role = "admin" | "doctor" | "nurse" | "patient";
type User = { id: string; role: Role; mfa?: boolean };

const AuthCtx = createContext<{ user?: User } | null>(null);
export const useAuth = () => useContext(AuthCtx)!;

export function RoleGate({ roles, children }:{ roles:Role[]; children:React.ReactNode }) {
  const { user } = useAuth();
  return user && roles.includes(user.role) ? <>{children}</> : <NoAccess />;
}
export function RequireAuth(){ /* redirects to /login if no user; wraps Outlet */ }

```


# Domain responsibilities (front end)

- **Admin**
    
    - Users table (read-only from Auth), audit feed.
        
    - MFA indicator on admin routes.
        
- **Patient**
    
    - Profile (create/update), **PDF upload** → “Process” → see **summary** attached.
        
    - Request appointment with a doctor; view upcoming visits.
        
- **Doctor**
    
    - Approve/Reject appointment requests; **schedule** date/time.
        
    - View patient document summaries prior to visit.
        
- **Documents (shared module)**
    
    - `PdfUploader` (drag-&-drop, accepts `.pdf`, shows page count).
        
    - `SummaryCard` (keywords, top sentences).
        
- **Appointments (shared module)**
    
    - `AppointmentTable` (filter by status), `RequestForm`, `Scheduler`.




Awesome—let’s land this in **one day** with a tight, realistic plan for your stack:

- **Monolith React** (with shadcn/ui)
    
- **NGINX** API Gateway (reverse proxy + CORS)
    
- **2 Node.js services**: `auth` and `care` (users data + booking + documents)
    
- **1 Python** service: `pdf-summarizer`
    
- **1 Postgres** (single DB, two schemas: `auth`, `care`)
    

Below is a **time-boxed checklist** (≈10–12 hours). Copy it into your TODO and go.

---

# 0) Repo & layout (30 min)

`/app   /gateway-nginx     nginx.conf   /services     /auth           # Node + Express     /care           # Node + Express     /pdf-summarizer # Python + FastAPI   /web              # React + shadcn/ui   /ops     postgres-init.sql   docker-compose.yml   .env`

---

# 1) Infrastructure bootstrap (60–75 min)

**Postgres (one instance, two schemas)**

```
CREATE SCHEMA IF NOT EXISTS auth;
CREATE SCHEMA IF NOT EXISTS care;
CREATE EXTENSION IF NOT EXISTS citext;

```
```
```
```
-- auth
CREATE TYPE auth.role_enum AS ENUM ('patient','doctor','admin');
CREATE TABLE auth.users (
  id UUID PRIMARY KEY, email CITEXT UNIQUE NOT NULL,
  pass_hash TEXT NOT NULL, role auth.role_enum NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE auth.refresh_tokens(
  id UUID PRIMARY KEY, user_id UUID NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL, created_at TIMESTAMPTZ DEFAULT now()
);

-- care
CREATE TYPE care.appt_status AS ENUM ('REQUESTED','APPROVED','REJECTED','SCHEDULED','CANCELLED','COMPLETED');
CREATE TYPE care.doc_status  AS ENUM ('UPLOADED','PROCESSING','READY','FAILED');

CREATE TABLE care.patients(
  id UUID PRIMARY KEY, user_id UUID UNIQUE NOT NULL,
  full_name TEXT NOT NULL, created_at TIMESTAMPTZ DEFAULT now()
);
CREATE TABLE care.doctors(
  id UUID PRIMARY KEY, user_id UUID UNIQUE NOT NULL,
  specialty TEXT NOT NULL, capacity INT DEFAULT 0, created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE care.appointments(
  id UUID PRIMARY KEY, patient_id UUID NOT NULL, doctor_id UUID NOT NULL,
  status care.appt_status DEFAULT 'REQUESTED',
  scheduled_at TIMESTAMPTZ, created_at TIMESTAMPTZ DEFAULT now(), updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE care.documents(
  id UUID PRIMARY KEY, patient_id UUID NOT NULL,
  file_name TEXT, mime_type TEXT, size_bytes BIGINT,
  file_path TEXT, status care.doc_status DEFAULT 'UPLOADED',
  created_at TIMESTAMPTZ DEFAULT now(), updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE care.document_summaries(
  id UUID PRIMARY KEY, document_id UUID UNIQUE NOT NULL,
  summary_text TEXT, keywords TEXT[], pages INT, created_at TIMESTAMPTZ DEFAULT now()
);

```

**NGINX gateway**

```
events {}
http {
  server {
    listen 8080;

    # CORS (dev)
    add_header Access-Control-Allow-Origin $http_origin always;
    add_header Access-Control-Allow-Credentials "true" always;
    add_header Access-Control-Allow-Headers "*" always;
    add_header Access-Control-Allow-Methods "GET,POST,PUT,PATCH,DELETE,OPTIONS" always;
    if ($request_method = OPTIONS) { return 204; }

    location /api/auth/ { proxy_pass http://auth:3001/; }
    location /api/care/ { proxy_pass http://care:3002/; }
    # pdf service is backend-only; no public route needed

    location / { proxy_pass http://web:80/; } # serve React build
  }
}

```
    

**Docker Compose**

- `docker-compose.yml` with services: `db`, `gateway`, `auth`, `care`, `pdf`, `web`, and a shared `uploads` volume mounted into `care` and `pdf`.
    

---

# 2) Auth service (Node.js) (90 min)

**Stack:** Express + `pg` + `bcrypt` + `jsonwebtoken` + `zod`.

**Env:** `JWT_SECRET`, `DATABASE_URL`

**Endpoints**

- `POST /auth/register` — body `{email, password, role}` → create user (hash with bcrypt).
    
- `POST /auth/login` — returns `{access, refresh}`.
    
- `POST /auth/refresh` — rotates refresh.
    
- `GET /auth/me` — verify access token and return `{userId, role, email}`.
    

**Notes**

- Access token TTL ~15m; refresh ~7d.
    
- Middleware `requireAuth` verifying `Authorization: Bearer`.
    

---

# 3) Care service (Node.js) (2–2.5 h)

**Stack:** Express + `pg` + `multer` (for PDF upload) + `zod`.

**Folders**

`/care   /routes (patients, doctors, appts, docs)   /lib/db.ts (pg Pool)   /lib/auth.ts (JWT decode to get userId/role)   /uploads (mounted volume)`

**Profiles**

- `POST /care/patients` (role patient) → create patient with `user_id`.
    
- `POST /care/doctors` (role doctor) → create doctor profile.
    
- `GET /care/patients/me` / `GET /care/doctors/me`.
    

**Bookings**

- `POST /care/appointments` `{patientId, doctorId}` → `REQUESTED`.
    
- `POST /care/appointments/:id/approve` (doctor) → `APPROVED`.
    
- `POST /care/appointments/:id/schedule` `{dateTime}` (doctor) → `SCHEDULED`.
    
- `GET /care/appointments?patientId=&doctorId=&status=`.
    

**Documents**

- `POST /care/documents/upload` (multipart) → save to `/data/uploads/<uuid>.pdf`, insert row (status `UPLOADED`).
    
- `POST /care/documents/:id/process` → call pdf service (`POST http://pdf:8000/analyze`) with JSON `{ path: "/data/uploads/<uuid>.pdf" }`; await result; update `document_summaries` and set document `READY`.
    
- `GET /care/documents/:id` → status + summary if ready.
    
- (Optional) `GET /care/documents/:id/download` for debugging.
    

**Auth**

- All `/care/**` guarded by `requireAuth` (decode JWT, attach `req.user`).
    

---

# 4) PDF summarizer (Python FastAPI) (60–75 min)

**Stack:** FastAPI + `pdfminer.six` (or `pypdf`) + `sumy` (LexRank) for fast extractive summary.

**Endpoint**

- `POST /analyze` → body `{ "path": "/data/uploads/....pdf" }`
    
    1. Extract text (first N pages or up to ~10k chars).
        
    2. Summarize to ~5–8 sentences with LexRank.
        
    3. Simple keywords (top TF words minus stopwords).
        
    4. Return `{ summaryText, keywords, pages }`.
        

**No DB**. It just returns JSON; Care persists it.

**Mount uploads**

- In compose, mount the same `uploads` volume to `/data/uploads` in both `care` and `pdf`.
    

---

# 5) React app (shadcn/ui) (2–3 h)

**Init**

- Vite + React + TS. Install shadcn/ui and set up the theme.
    
- Add TanStack Query for fetching, React Router for routes.
    

**Auth**

- Login page → calls `/api/auth/login` → store access token in memory (or localStorage for speed).
    
- API client adds `Authorization: Bearer`.
    

**Routes**

- `/patient`:
    
    - Profile form (create if absent).
        
    - **Documents**: upload PDF → shows status → “Process” → shows summary.
        
    - **Appointments**: request appointment (select doctor).
        
- `/doctor`:
    
    - Profile form.
        
    - **Inbox**: list `REQUESTED` → Approve.
        
    - **Schedule**: set date/time for `APPROVED`.
        
- (Optional) `/admin` minimal list of users.
    

**Components (shadcn)**

- Button, Input, Card, Table, Dialog, Toast, FileUpload drag&drop.
    

**Polling**

- Document status: poll every 3s until `READY`.
    

---

# 6) Wire NGINX + Compose (30–45 min)

- `web` serves built React bundle via Nginx (or Vite dev if you prefer).
    
- NGINX reverse-proxies `/api/auth/**` → `auth:3001`, `/api/care/**` → `care:3002`.
    
- Expose `gateway:8080` and `web:80` (proxy `/` to web for simplicity as in config).
    

**Compose tips**

- Add healthchecks for `auth`, `care`, `pdf` (hit `/health` endpoints).
    
- Add volume:
    
    `volumes:   uploads:`
    
    and mount to `/data/uploads` in `care` and `pdf`.
    

---

# 7) Seed & smoke tests (45–60 min)

**Seed script** (quick SQL or small Node script):

- Create users: 1 patient, 1 doctor (get their UUIDs).
    
- Create doctor profile and patient profile.
    

**Manual flow (curl or Postman)**

1. **Login patient** → token.
    
2. **Upload PDF** → `POST /api/care/documents/upload` (multipart).
    
3. **Process** → `POST /api/care/documents/:id/process`; `GET /api/care/documents/:id` until `READY`.
    
4. **Request appointment** → `POST /api/care/appointments`.
    
5. **Login doctor** → approve → schedule.
    

**UI sanity**

- Repeat the same in the React app; grab screenshots.
    

---

# 8) Guardrails & polish (last 45 min)

- **Validation** with zod in both services.
    
- **Error handling**: JSON error envelope `{error: {message, code}}`.
    
- **CORS**: already handled by NGINX.
    
- **Security**:
    
    - Hash passwords (`bcrypt`).
        
    - Verify JWT in both services (don’t trust only NGINX).
        
    - Limit upload size (e.g., 15–25 MB).
        
- **Logs**: request logs with request IDs in services.
    
- **README** with commands:
    
    - `docker compose up -d --build`
        
    - creds, URLs, and a 5-step demo script.
        

---

## Minimal success criteria (what to show at the end)

- **Auth**: register/login returns tokens; `/auth/me` works.
    
- **Docs**: upload a PDF, click Process, summary appears under the patient profile.
    
- **Bookings**: patient requests → doctor approves → schedules date/time; status updates visible on both sides.
    
- **Gateway**: React calls ONLY `http://localhost:8080/api/...`.
    
- **One DB**: Postgres running with `auth` & `care` schemas populated.
    

---

## Contingency (if time slips)

- Skip refresh tokens (access token only).
    
- Make PDF summarizer **synchronous** (as described) and limit to first 5 pages.
    
- Store PDFs on disk only (no BYTEA).
    
- Appointments: support only `REQUESTED → APPROVED → SCHEDULED`.
    

Ship the core loop; add nice-to-haves only if you have time left.

  

ChatGPT can make mistakes. Check important info. See Coo