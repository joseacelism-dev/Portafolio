create table if not exists public.solicitudes_cita (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  name text not null,
  company text not null,
  role text,
  email text not null,
  phone text not null,
  sector text not null,
  problem text not null,
  solution text not null,
  budget text,
  message text not null,
  privacy_accepted boolean not null default false,
  status text not null default 'pendiente',
  source_url text
);

alter table public.solicitudes_cita enable row level security;

drop policy if exists "Permitir registro publico de solicitudes" on public.solicitudes_cita;

create policy "Permitir registro publico de solicitudes"
on public.solicitudes_cita
for insert
to anon
with check (privacy_accepted = true);
