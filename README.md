# Galaw Workout Module Development Starter

**Galaw** is an offline-first fitness and workout management application.

This repository starts the development of the **workout module** with backend, frontend, database schema, workout process, UI/UX structure, and basic logic.

## Main Features Included

- Dashboard summary
- Workout routine list
- Exercise library and form guide
- Active workout session
- Sets, reps, weight, and rest logging
- Workout completion calculation
- Progress summary
- PostgreSQL database schema
- Express backend API
- Ionic Angular frontend UI
- Offline-first sync-ready structure

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Ionic + Angular |
| Backend | Node.js + Express |
| Database | PostgreSQL |
| Local Dev DB | Docker Compose |
| Offline Concept | Local queue / local storage, sync-ready |

## Folder Structure

```txt
galaw-workout-development-starter/
├── backend/              # Express API and PostgreSQL logic
├── frontend/             # Ionic Angular app
├── docs/                 # Workout process documentation
├── docker-compose.yml    # PostgreSQL local database
├── .gitignore            # Git-ready ignore rules
├── package.json          # Root helper scripts
└── GITHUB_PUSH_GUIDE.md  # Push instructions
```

## Core Workout Flow

```txt
Dashboard
→ Workout Routines
→ Start Workout
→ Active Workout
→ Log Sets / Reps / Weight
→ Finish Workout
→ Save Workout Transaction
→ View Progress Summary
```

## Run PostgreSQL

```bash
npm run db:up
```

Or directly:

```bash
docker compose up -d
```

## Run Backend

```bash
cd backend
npm install
cp .env.example .env
npm run migrate
npm run seed
npm run dev
```

Copy the demo user ID shown after running seed.

## Run Frontend

```bash
cd frontend
npm install
npm run start
```

In the browser console, set the demo user ID:

```js
localStorage.setItem('galaw_user_id', 'PASTE_DEMO_USER_ID_HERE')
```

## API Endpoints

```txt
GET    /api/health
GET    /api/exercises
GET    /api/exercises/:id
GET    /api/routines?userId=
POST   /api/routines
GET    /api/routines/:id
POST   /api/workouts/start
GET    /api/workouts/:id
POST   /api/workouts/:id/exercises/:workoutExerciseId/sets
PATCH  /api/workouts/:id/finish
GET    /api/progress/summary?userId=
```


## Android APK / Phone Installation

This project includes a GitHub Actions workflow that can build a debug APK for Android phones.

After pushing to GitHub:

1. Open the repository.
2. Go to **Actions**.
3. Run **Build Android APK**.
4. Download the artifact named **galaw-debug-apk**.
5. Install `app-debug.apk` on your Android phone.

See `INSTALL_ON_PHONE.md` for the full phone installation guide.

The frontend also includes a local demo/offline mode, so the workout module can be tested on a phone even before the backend is deployed online.

## GitHub Ready

This project is ready to be committed and pushed to GitHub.

After creating an empty GitHub repository, run:

```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git
git branch -M main
git push -u origin main
```

If you extracted the project without the `.git` folder, run:

```bash
git init
git add .
git commit -m "Initial Galaw workout module"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git
git push -u origin main
```

## Do Not Commit

The `.gitignore` already excludes:

- `node_modules/`
- `.env`
- build outputs
- logs
- local database files
- editor cache files

## Next Development Phase

After this workout module, the next phase can add:

- User authentication
- Nutrition log
- Food scan interface
- Workout sharing card generator
- Real offline SQLite synchronization
- Deployment setup
