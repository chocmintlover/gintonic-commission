-- รันทั้งไฟล์ใน Supabase → SQL Editor (รันซ้ำได้)

create table if not exists public.site_content (
  id         text primary key,
  data       jsonb not null,
  updated_at timestamptz not null default now()
);

create table if not exists public.admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);

alter table public.site_content enable row level security;
alter table public.admins       enable row level security;

drop policy if exists "site public read"  on public.site_content;
drop policy if exists "site admin insert" on public.site_content;
drop policy if exists "site admin update" on public.site_content;
drop policy if exists "admins read self"  on public.admins;

-- ใครก็อ่านเนื้อหาเว็บได้
create policy "site public read" on public.site_content
  for select using (true);

-- เฉพาะแอดมินเท่านั้นที่เขียนได้
create policy "site admin insert" on public.site_content
  for insert to authenticated
  with check (exists (select 1 from public.admins a where a.user_id = auth.uid()));

create policy "site admin update" on public.site_content
  for update to authenticated
  using      (exists (select 1 from public.admins a where a.user_id = auth.uid()))
  with check (exists (select 1 from public.admins a where a.user_id = auth.uid()));

-- ผู้ล็อกอินอ่านได้เฉพาะแถวของตัวเอง (ใช้เช็คว่าเป็นแอดมินไหม)
create policy "admins read self" on public.admins
  for select to authenticated using (user_id = auth.uid());

-- ขั้นสุดท้าย (หลังสร้างผู้ใช้ใน Authentication → Users): ใส่อีเมลของคุณ แล้วรัน
-- insert into public.admins (user_id) select id from auth.users where email = 'you@example.com';
