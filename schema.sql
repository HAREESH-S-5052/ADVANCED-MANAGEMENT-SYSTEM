-- ==============================================================
-- EduTrack - Supabase PostgreSQL Database Schema
-- Run this script in your Supabase SQL Editor (SQL Editor -> New Query)
-- ==============================================================

-- 1. Create Students Table
CREATE TABLE IF NOT EXISTS public.students (
    id TEXT PRIMARY KEY,
    roll_no TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    grade TEXT NOT NULL,
    section TEXT NOT NULL,
    gender TEXT,
    dob TEXT,
    blood_group TEXT,
    address TEXT,
    guardian_name TEXT,
    guardian_phone TEXT,
    guardian_relation TEXT,
    status TEXT DEFAULT 'Active',
    enrollment_date TEXT,
    attendance_rate NUMERIC DEFAULT 95,
    gpa NUMERIC DEFAULT 3.5,
    avatar_bg TEXT DEFAULT 'bg-brand-600',
    fees JSONB DEFAULT '{"total": 4200, "paid": 4200, "status": "Paid"}'::jsonb,
    grades JSONB DEFAULT '[]'::jsonb,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Create Courses Table
CREATE TABLE IF NOT EXISTS public.courses (
    id TEXT PRIMARY KEY,
    code TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    teacher TEXT NOT NULL,
    grade TEXT NOT NULL,
    credits INTEGER DEFAULT 3,
    room TEXT,
    schedule TEXT,
    max_capacity INTEGER DEFAULT 30,
    enrolled_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Create Daily Attendance Table
CREATE TABLE IF NOT EXISTS public.attendance (
    date TEXT NOT NULL,
    records JSONB NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    PRIMARY KEY (date)
);

-- 4. Enable Row Level Security (RLS)
ALTER TABLE public.students ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendance ENABLE ROW LEVEL SECURITY;

-- 5. Create Permissive Policies for the Anon API Key (Read, Insert, Update, Delete)
CREATE POLICY "Allow public read access on students" ON public.students FOR SELECT USING (true);
CREATE POLICY "Allow public insert on students" ON public.students FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update on students" ON public.students FOR UPDATE USING (true);
CREATE POLICY "Allow public delete on students" ON public.students FOR DELETE USING (true);

CREATE POLICY "Allow public read access on courses" ON public.courses FOR SELECT USING (true);
CREATE POLICY "Allow public insert on courses" ON public.courses FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update on courses" ON public.courses FOR UPDATE USING (true);
CREATE POLICY "Allow public delete on courses" ON public.courses FOR DELETE USING (true);

CREATE POLICY "Allow public read access on attendance" ON public.attendance FOR SELECT USING (true);
CREATE POLICY "Allow public insert on attendance" ON public.attendance FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update on attendance" ON public.attendance FOR UPDATE USING (true);
