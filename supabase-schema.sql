-- Wedding invitation single-site schema
-- 1) Replace YOUR_ADMIN_EMAIL@example.com with the exact email used for your Supabase Auth user.
-- 2) Run this entire script in Supabase SQL Editor.
create table if not exists public.wedding_site (
  id text primary key check (id = 'main'),
  content jsonb not null default '{}'::jsonb,
  is_published boolean not null default false,
  updated_at timestamptz not null default now()
);

insert into public.wedding_site (id, content, is_published)
values ('main', '{}'::jsonb, false)
on conflict (id) do nothing;

alter table public.wedding_site enable row level security;

create or replace function public.is_wedding_admin()
returns boolean
language sql
stable
as $$
  select lower(coalesce(auth.jwt() ->> 'email', '')) = lower('YOUR_ADMIN_EMAIL@example.com');
$$;

drop policy if exists "Public can read published wedding" on public.wedding_site;
create policy "Public can read published wedding"
on public.wedding_site for select
using (is_published = true);

drop policy if exists "Wedding admin can read all wedding content" on public.wedding_site;
create policy "Wedding admin can read all wedding content"
on public.wedding_site for select to authenticated
using (public.is_wedding_admin());

drop policy if exists "Wedding admin can insert wedding content" on public.wedding_site;
create policy "Wedding admin can insert wedding content"
on public.wedding_site for insert to authenticated
with check (public.is_wedding_admin());

drop policy if exists "Wedding admin can update wedding content" on public.wedding_site;
create policy "Wedding admin can update wedding content"
on public.wedding_site for update to authenticated
using (public.is_wedding_admin())
with check (public.is_wedding_admin());

-- Public image bucket for wedding photos.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('wedding-assets', 'wedding-assets', true, 5242880, array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public = true, file_size_limit = 5242880,
  allowed_mime_types = array['image/jpeg','image/png','image/webp'];

drop policy if exists "Public can view wedding assets" on storage.objects;
create policy "Public can view wedding assets"
on storage.objects for select
using (bucket_id = 'wedding-assets');

drop policy if exists "Wedding admin can upload assets" on storage.objects;
create policy "Wedding admin can upload assets"
on storage.objects for insert to authenticated
with check (bucket_id = 'wedding-assets' and public.is_wedding_admin());

drop policy if exists "Wedding admin can update assets" on storage.objects;
create policy "Wedding admin can update assets"
on storage.objects for update to authenticated
using (bucket_id = 'wedding-assets' and public.is_wedding_admin())
with check (bucket_id = 'wedding-assets' and public.is_wedding_admin());

drop policy if exists "Wedding admin can delete assets" on storage.objects;
create policy "Wedding admin can delete assets"
on storage.objects for delete to authenticated
using (bucket_id = 'wedding-assets' and public.is_wedding_admin());
