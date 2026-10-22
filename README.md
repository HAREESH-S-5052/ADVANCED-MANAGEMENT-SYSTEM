# 🎓 EduTrack — Full-Stack Student Management System

EduTrack is a modern, comprehensive **Full-Stack Student Management System** built with a dedicated **Node.js REST API backend**, **native SQLite database engine (`node:sqlite`)**, and **Role-Based Access Control (RBAC)** supporting Administrators, Teachers, Students, and Parents.

---

## ✨ Key Features & Architecture

```text
student-management-system/
├── index.html            # Responsive SPA frontend (Tailwind CSS, Lucide icons, Chart.js)
├── css/
│   └── styles.css        # Theme styles, glassmorphism, animations & printable report card styling
├── js/
│   ├── api.js            # Unified API Client (REST API + offline fallback)
│   ├── app.js            # Frontend controller, dynamic RBAC view gating & Chart.js integration
│   ├── data.js           # Client-side fallback seed data & storage manager
│   └── db.js             # Supabase Cloud Database connector (optional cloud sync)
├── server/
│   ├── server.js         # Native Node.js HTTP server & static asset pipeline
│   ├── api.js            # REST API router (Auth, Students, Courses, Attendance, Grades, Fees)
│   ├── auth.js           # Cryptographic password hashing (PBKDF2/SHA-512) & HMAC signed session tokens
│   ├── db.js             # SQLite Database Manager using Node.js native engine (`node:sqlite`)
│   └── seed-data.js      # Default database seed records
├── tests/
│   └── api.test.js       # Automated end-to-end REST API & RBAC test suite
├── edutrack.db           # Persistent SQLite database file
├── start-server.bat      # 1-Click Windows server launcher & browser opener
├── package.json          # Node.js project manifest & npm scripts
├── schema.sql            # PostgreSQL schema for optional Supabase hosting
└── README.md             # Project documentation
```

---

## 🔐 Role-Based Access Control (RBAC)

EduTrack provides fine-grained access control across 4 distinct user roles:

| Feature / Module | 👑 Administrator | 👨‍🏫 Teacher | 🎓 Student | 👨‍👩‍👧 Parent |
| :--- | :---: | :---: | :---: | :---: |
| **Dashboard Analytics** | School-wide KPI metrics & charts | Academic & class metrics | Personalized student portal | Child's academic dossier |
| **Student Directory** | Full CRUD (Add, Edit, Delete) | View & Edit student profiles | View own profile only | View child's profile only |
| **Courses & Curriculum** | Create, Edit, Delete courses | Add & Edit courses | View enrolled subjects | View child's subjects |
| **Daily Attendance** | Mark, edit, & confirm register | Mark & confirm register | View personal attendance % | View child's attendance % |
| **Grades & Exams** | Manage all scores & report cards | Enter & update subject scores | View & print report card | View & print report card |
| **Tuition & Billing** | Process payments & ledger | Hidden | View personal fee balance | View payment receipts |
| **Database & System Reset**| Full control | Restricted | Restricted | Restricted |

---

## 👥 Pre-Configured Demo Accounts

EduTrack includes an **Instant 1-Click Role Switcher modal** directly in the top header. You can also log in manually with these pre-seeded accounts:

| Role | Email | Password | Description |
| :--- | :--- | :--- | :--- |
| 👑 **Administrator** | `admin@edutrack.edu` | `admin123` | Victoria Adams (Principal) — Full system access |
| 👨‍🏫 **Teacher** | `teacher@edutrack.edu` | `teacher123` | Dr. Alan Turing (Faculty Head) — Attendance & grading |
| 🎓 **Student** | `student@edutrack.edu` | `student123` | Aarav Sharma — Personal student portal (Roll: `STU-1001`) |
| 👨‍👩‍👧 **Parent** | `parent@edutrack.edu` | `parent123` | Rajesh Sharma — Parent of Aarav Sharma |

---

## 🚀 How to Run

### Method 1: 1-Click Windows Launcher (Recommended)
Simply double-click:
```text
start-server.bat
```
*(Starts the backend server on `http://localhost:3000` and automatically opens your browser)*.

### Method 2: Via Terminal / PowerShell
From the project folder, run:
```powershell
node server/server.js
```
Then navigate in your browser to:
```text
http://localhost:3000
```

### Method 3: Offline / Browser-Only Mode
You can also open `index.html` directly in any web browser without running a server. EduTrack automatically falls back to client-side `localStorage` and maintains full UI functionality!

---

## ⚡ REST API Endpoints

All endpoints support Bearer token authentication via the `Authorization: Bearer <token>` header:

### 🔑 Authentication
- `POST /api/auth/login` — Sign in with `{ email, password }`
- `GET /api/auth/me` — Retrieve current authenticated session
- `GET /api/auth/users` — List registered system users *(Admin only)*

### 👨‍🎓 Students
- `GET /api/students` — Retrieve student roster *(Isolated to self for Student/Parent)*
- `GET /api/students/:id` — Get student dossier by ID
- `POST /api/students` — Register a new student *(Admin only)*
- `PUT /api/students/:id` — Update student profile *(Admin & Teacher)*
- `DELETE /api/students/:id` — Remove student record *(Admin only)*

### 📚 Courses
- `GET /api/courses` — List curriculum courses
- `POST /api/courses` — Add new course *(Admin & Teacher)*
- `PUT /api/courses/:id` — Update course details *(Admin & Teacher)*
- `DELETE /api/courses/:id` — Delete course *(Admin only)*

### 📅 Attendance
- `GET /api/attendance?date=YYYY-MM-DD` — Retrieve attendance register for a date
- `POST /api/attendance` — Save daily attendance register `{ date, records }` *(Admin & Teacher)*

### 📝 Grades & Examinations
- `PUT /api/students/:id/grades` — Record subject scores and recalculate GPA *(Admin & Teacher)*

### 💳 Fees & Billing
- `POST /api/fees/payment` — Record tuition payment `{ studentId, amount, note }` *(Admin only)*

### 📊 Dashboard & System
- `GET /api/dashboard/stats` — KPI metrics, grade distributions, and recent activity log
- `POST /api/reset` — Reset database to initial seed dataset *(Admin only)*

---

## 🧪 Automated Testing

EduTrack includes an automated end-to-end API test suite validating authentication, RBAC authorization boundaries, and database operations.

To run tests:
```powershell
node tests/api.test.js
```

---

## 🗄️ Optional Supabase Cloud Sync

In addition to the local SQLite database, EduTrack retains full support for hosted PostgreSQL via **Supabase**:
1. Click the database status badge (`SQLite Server` / `Local DB`) in the header.
2. Enter your Supabase Project URL and Anon API Key.
3. Click **Upload Current Students to Cloud Database** to migrate data into PostgreSQL.
