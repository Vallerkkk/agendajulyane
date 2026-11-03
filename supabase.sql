-- Agenda da Julyane — tabelas no Supabase
-- Rode este script no SQL Editor do projeto NOVO.
-- O servidor acessa com a SECRET key (service_role), que ignora RLS.
-- RLS fica ligado sem políticas: o navegador não lê o banco diretamente.

create table if not exists public.juliane_eventos (
  id text primary key,
  dados jsonb not null,
  atualizado_em timestamptz not null default now()
);

create index if not exists juliane_eventos_atualizado_em_idx
  on public.juliane_eventos (atualizado_em);

create table if not exists public.juliane_acesso (
  id integer primary key default 1 check (id = 1),
  usuario text not null,
  salt text not null,
  hash text not null,
  criado_em timestamptz not null default now()
);

create table if not exists public.juliane_push (
  endpoint text primary key,
  dados jsonb not null,
  criado_em timestamptz not null default now()
);

alter table public.juliane_eventos enable row level security;
alter table public.juliane_acesso enable row level security;
alter table public.juliane_push enable row level security;

comment on table public.juliane_eventos is 'Compromissos da agenda (JSON completo por evento)';
comment on table public.juliane_acesso is 'Login único do painel (salt + hash PBKDF2)';
comment on table public.juliane_push is 'Inscrições de notificação push por dispositivo';
