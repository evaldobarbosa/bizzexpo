# Milestones - duevento

Marcos do projeto que agrupam funcionalidades relacionadas.

**Convencao:** Milestones sao reativos - novos marcos podem ser inseridos antes de outros na fila conforme necessidade do negocio.

---

## Indice de Milestones

| ID | Nome | Status | Sprints | Versao Docs |
|----|------|--------|---------|-------------|
| M0 | Landing Page Institucional | Concluido | Sprint 01 | v0.1.0 |
| M1 | Gestao de Eventos | Concluido | Sprint 02 | v0.2.0 |
| M2 | Fluxo Completo MVP | Concluido | Sprint 03 | v0.3.0 |
| M3 | SEO e Multi-tenancy | Em Andamento | Sprint 04 | v0.4.0 |

---

## M0 - Landing Page Institucional

**Status:** Concluido
**Versao:** v0.1.0
**Tag Git:** `docs-v0.1.0`

### Escopo
- Landing page institucional do duevento
- Apresentacao do produto e planos
- Autenticacao basica

### Funcionalidades
- [x] Landing Page institucional
- [x] Login/Registro
- [x] Cadastro de Organizador

### Artefatos
- Sprint: `docs/sprints/sprint-01.md`

---

## M1 - Gestao de Eventos

**Status:** Concluido
**Versao:** v0.2.0
**Tag Git:** `docs-v0.2.0`

### Escopo
- CRUD completo de eventos e entidades relacionadas
- Dashboard do organizador

### Funcionalidades
- [x] CRUD Eventos
- [x] CRUD Expositores
- [x] CRUD Categorias
- [x] CRUD Estandes
- [x] CRUD Staff
- [x] Dashboard Organizador

### Artefatos
- Sprint: `docs/sprints/sprint-02.md`

---

## M2 - Fluxo Completo MVP

**Status:** Concluido
**Versao:** v0.3.0
**Tag Git:** `docs-v0.3.0`

### Escopo
- Fluxo completo de inscricao ate check-in
- Dashboard do expositor
- Captura de leads

### Funcionalidades
- [x] Sistema de Inscricao
- [x] Landing Page do Evento
- [x] Check-in (Totem, Staff, Walk-in)
- [x] Dashboard Expositor
- [x] Captura de Leads

### Artefatos
- Sprint: `docs/sprints/sprint-03.md`

---

## M3 - SEO e Multi-tenancy

**Status:** Em Andamento
**Versao:** v0.4.0 (planejada)
**Tag Git:** `docs-v0.4.0` (a criar)

### Escopo
- Otimizacao de SEO via Cloudflare Workers
- Completar estrutura multi-tenant
- Validacao do sistema de check-in

### Funcionalidades
- [ ] US-1.6: Estrutura Multi-tenant completa
- [ ] US-6.5: Cloudflare Workers para SEO
- [ ] Validacao Check-in em producao
- [ ] Testes e2e Landing Page

### Artefatos
- Sprint: `docs/sprints/sprint-04.md`
- Analise Tecnica: `docs/analises/tecnicas/cloudflare-workers-seo.md`

---

## Proximos Milestones (Planejados)

| ID | Nome | Escopo Principal |
|----|------|------------------|
| M4 | Pagamento | Integracao Pagar.me |
| M5 | Gestao Organizador | Perfil, senha, configuracoes |
| M6 | OAuth2 | Login com Google/LinkedIn |

---

## Regras de Versionamento

### Documentacao
- Ao iniciar um milestone, criar tag git: `docs-vX.Y.Z`
- Ao concluir, arquivar modelo de dados: `arquivo/modelo-dados.mN.md`
- Atualizar CHANGELOG.md com alteracoes

### Codigo
- Tags de release seguem semver: `vX.Y.Z`
- Cada milestone pode ter multiplas releases

### Convencoes de Versao
- **Major (X):** Mudancas estruturais no modelo de dados
- **Minor (Y):** Novas entidades ou funcionalidades
- **Patch (Z):** Correcoes e ajustes

---

**Ultima atualizacao:** 2026-03-16
