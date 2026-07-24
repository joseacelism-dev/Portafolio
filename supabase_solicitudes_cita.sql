create table if not exists public.solicitudes_cita (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  name text not null,
  company text not null,
  role text,
  email text not null,
  phone text not null,
  sector text,
  problem text,
  solution text,
  budget text,
  message text,
  privacy_accepted boolean not null default false,
  status text not null default 'pendiente',
  source_url text
);

alter table public.solicitudes_cita enable row level security;

alter table public.solicitudes_cita alter column sector drop not null;
alter table public.solicitudes_cita alter column problem drop not null;
alter table public.solicitudes_cita alter column solution drop not null;
alter table public.solicitudes_cita alter column message drop not null;

drop policy if exists "Permitir registro publico de solicitudes" on public.solicitudes_cita;

create policy "Permitir registro publico de solicitudes"
on public.solicitudes_cita
for insert
to anon
with check (privacy_accepted = true);
