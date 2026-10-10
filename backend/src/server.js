const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
const pool = new Pool({ connectionString: process.env.DATABASE_URL });

app.use(cors());
app.use(express.json());

app.get('/api/health', (req, res) => {
  res.json({ status: 'ok', app: 'Galaw Backend API' });
});

app.get('/api/exercises', async (req, res) => {
  const { rows } = await pool.query('SELECT * FROM exercises ORDER BY muscle_group, name');
  res.json(rows);
});

app.get('/api/routines', async (req, res) => {
  const { rows } = await pool.query('SELECT * FROM routines ORDER BY created_at DESC');
  res.json(rows);
});

app.post('/api/workouts/start', async (req, res) => {
  const { routineId } = req.body;
  const routine = await pool.query('SELECT * FROM routines WHERE id=$1', [routineId]);
  const name = routine.rows[0]?.name || 'Workout';
  const created = await pool.query(
    'INSERT INTO workout_sessions (routine_id, name, status) VALUES ($1,$2,$3) RETURNING *',
    [routineId, name, 'active']
  );
  res.status(201).json({ ...created.rows[0], exercises: [] });
});

app.post('/api/workouts/:id/exercises/:exerciseId/sets', async (req, res) => {
  const { setNumber, weightKg, reps, restSeconds } = req.body;
  const { rows } = await pool.query(
    'INSERT INTO workout_sets (session_id, exercise_id, set_number, weight_kg, reps, rest_seconds) VALUES ($1,$2,$3,$4,$5,$6) RETURNING *',
    [req.params.id, req.params.exerciseId, setNumber, weightKg || 0, reps || 0, restSeconds || 60]
  );
  res.status(201).json(rows[0]);
});

app.patch('/api/workouts/:id/finish', async (req, res) => {
  const totals = await pool.query(
    'SELECT COUNT(*)::int AS total_sets, COALESCE(SUM(weight_kg * reps),0)::numeric AS total_volume FROM workout_sets WHERE session_id=$1',
    [req.params.id]
  );
  const { rows } = await pool.query(
    'UPDATE workout_sessions SET status=$2, ended_at=NOW(), total_sets=$3, total_volume=$4 WHERE id=$1 RETURNING *',
    [req.params.id, 'completed', totals.rows[0].total_sets, totals.rows[0].total_volume]
  );
  res.json(rows[0]);
});

app.get('/api/progress/summary', async (req, res) => {
  const summary = await pool.query(
    "SELECT COUNT(*) FILTER (WHERE status='completed')::int AS completed_workouts, COALESCE(SUM(total_sets),0)::int AS total_sets, COALESCE(SUM(total_volume),0)::numeric AS total_volume FROM workout_sessions"
  );
  const recent = await pool.query('SELECT * FROM workout_sessions ORDER BY started_at DESC LIMIT 5');
  res.json({ summary: summary.rows[0], recent: recent.rows, personalRecords: [] });
});

const port = process.env.PORT || 4000;
app.listen(port, () => console.log(`Galaw backend running on http://localhost:${port}`));
