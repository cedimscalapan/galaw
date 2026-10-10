CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS exercises (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(160) NOT NULL,
  muscle_group VARCHAR(80) NOT NULL,
  equipment VARCHAR(80) NOT NULL,
  difficulty VARCHAR(50) DEFAULT 'Beginner',
  instructions JSONB DEFAULT '[]'::jsonb,
  common_mistakes JSONB DEFAULT '[]'::jsonb,
  safety_tip TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS routines (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(160) NOT NULL,
  description TEXT,
  estimated_minutes INT DEFAULT 45,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS workout_sessions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  routine_id UUID REFERENCES routines(id) ON DELETE SET NULL,
  name VARCHAR(160) NOT NULL,
  status VARCHAR(30) DEFAULT 'active',
  started_at TIMESTAMP DEFAULT NOW(),
  ended_at TIMESTAMP,
  total_sets INT DEFAULT 0,
  total_volume NUMERIC(12,2) DEFAULT 0
);

CREATE TABLE IF NOT EXISTS workout_sets (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  session_id UUID REFERENCES workout_sessions(id) ON DELETE CASCADE,
  exercise_id UUID,
  set_number INT NOT NULL,
  weight_kg NUMERIC(8,2) DEFAULT 0,
  reps INT DEFAULT 0,
  rest_seconds INT DEFAULT 60,
  completed BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO exercises (name, muscle_group, equipment, instructions, common_mistakes, safety_tip)
VALUES
('Bench Press','Chest','Barbell','["Lie flat on the bench.","Grip slightly wider than shoulder width.","Lower slowly to mid-chest.","Press upward with control."]','["Bouncing the bar","Flaring elbows too wide","Using too much weight"]','Keep feet planted and use a spotter when lifting heavy.'),
('Overhead Press','Shoulders','Barbell','["Stand tall.","Keep core tight.","Press overhead.","Lower slowly."]','["Leaning too far back","Using momentum"]','Avoid over-arching your lower back.'),
('Tricep Pushdown','Triceps','Cable','["Face the cable machine.","Keep elbows close.","Push down.","Return slowly."]','["Moving elbows forward","Swinging body"]','Use a weight you can control.')
ON CONFLICT DO NOTHING;

INSERT INTO routines (name, description, estimated_minutes)
VALUES
('Push Day','Chest, Shoulders, and Triceps',45),
('Pull Day','Back and Biceps',45),
('Leg Day','Quads, Hamstrings, Glutes, and Calves',50)
ON CONFLICT DO NOTHING;
