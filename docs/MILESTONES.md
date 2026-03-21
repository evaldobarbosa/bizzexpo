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
| M3.5 | Sistema Administrativo | Concluido | Sprint 05 | v0.5.0 |
| M4 | Pagamento e Catalogo | Em Andamento | Sprint 06 | v0.6.0 |

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

## M3.5 - Sistema Administrativo

**Status:** Concluido
**Versao:** v0.5.0
**Tag Git:** `docs-v0.5.0`

### Escopo
- Interface administrativa para SIM/Code2
- Impersonation de organizadores
- Metricas financeiras

### Funcionalidades
- [x] US-13.1: Roles e Permissoes (spatie/laravel-permission)
- [x] US-13.2: Marcar Evento como Pago (Admin)
- [x] US-13.3: Listar Todos os Eventos (Admin)
- [x] US-13.4: Auditoria de Eventos (owen-it/laravel-auditing)
- [x] US-13.5: Notificacoes de Pagamento
- [x] US-13.6: Interface Admin no Frontend
- [x] Sistema de Impersonation completo
- [x] Pagina Financeiro com metricas

### Artefatos
- Sprint: `docs/sprints/sprint-05.md` (nao documentada)

---

## M4 - Pagamento e Catalogo

**Status:** Em Andamento
**Versao:** v0.6.0 (planejada)
**Tag Git:** `docs-v0.6.0` (a criar)

### Escopo
- Integracao com Pagar.me (cartao, debito, PIX)
- Catalogo global de produtos e servicos
- Sistema de faturas com multiplos itens
- Parcelamento com juros

### Funcionalidades
- [ ] US-7.1: Gestao de Catalogo (Admin)
- [ ] US-7.2: Precos por Evento
- [ ] US-7.3: Sistema de Faturas
- [ ] US-7.4: Pagamento com Cartao
- [ ] US-7.5: Pagamento com PIX
- [ ] US-7.6: Webhook Pagar.me
- [ ] US-7.7: Parcelamento
- [ ] US-7.8: Visualizar Minhas Faturas

### Artefatos
- Sprint: `docs/sprints/sprint-06.md`
- Analise Feature: `docs/analises/features/integracao-pagarme-catalogo.md`

---

## Proximos Milestones (Planejados)

| ID | Nome | Escopo Principal |
|----|------|------------------|
| M5 | Gestao Organizador | Perfil, senha, configuracoes |
| M6 | OAuth2 | Login com Google/LinkedIn |
| M7 | Customizacao Visual | Temas e personalizacao |

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

**Ultima atualizacao:** 2026-03-19
