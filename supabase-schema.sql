-- 新建或升級既有 Supabase 資料表：可重複執行
create table if not exists public.osh_quiz_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  question_db jsonb not null default '[]'::jsonb,
  wrong_db jsonb not null default '[]'::jsonb,
  quiz_history jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.osh_quiz_data
  add column if not exists wrong_db jsonb not null default '[]'::jsonb;

alter table public.osh_quiz_data enable row level security;

drop policy if exists "Users can read own quiz data" on public.osh_quiz_data;
create policy "Users can read own quiz data"
  on public.osh_quiz_data for select
  using (auth.uid() = user_id);

drop policy if exists "Users can insert own quiz data" on public.osh_quiz_data;
create policy "Users can insert own quiz data"
  on public.osh_quiz_data for insert
  with check (auth.uid() = user_id);

drop policy if exists "Users can update own quiz data" on public.osh_quiz_data;
create policy "Users can update own quiz data"
  on public.osh_quiz_data for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
