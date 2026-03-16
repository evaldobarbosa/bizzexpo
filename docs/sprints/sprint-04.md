# Sprint 04

> **Periodo:** 2026-03-16 a 2026-03-30
> **Status:** Planejamento
> **Objetivo:** Completar multi-tenancy, finalizar landing page do evento com SEO via Cloudflare Workers, e validar sistema de check-in

## Backlog da Sprint

### User Stories

| ID | User Story | Epico | Prioridade | Status |
|----|------------|-------|------------|--------|
| US-1.6 | Estrutura Multi-tenant | 1 - Infraestrutura | Alta | Pendente |
| US-6.1 | Pagina Publica do Evento | 6 - Landing Page | Alta | Revisao |
| US-6.2 | Lista de Expositores Publica | 6 - Landing Page | Media | Revisao |
| US-6.3 | Formulario de Inscricao | 6 - Landing Page | Alta | Revisao |
| US-6.4 | Pagina de Confirmacao | 6 - Landing Page | Media | Revisao |
| US-6.5 | Cloudflare Workers para SEO | 6 - Landing Page | Alta | Pendente |
| US-8.1 | Check-in Autoatendimento | 8 - Check-in | Media | Validacao |
| US-8.2 | Check-in por Staff | 8 - Check-in | Media | Validacao |
| US-8.3 | Check-in por Busca | 8 - Check-in | Media | Validacao |
| US-8.4 | Cadastro Walk-in | 8 - Check-in | Media | Validacao |

---

## US-1.6: Estrutura Multi-tenant

**Como** sistema,
**Quero** isolar dados por organizador,
**Para** garantir seguranca e privacidade.

### Criterios de Aceite

- [ ] Trait `BelongsToOrganizador` aplicado em todos os models relevantes
- [ ] Middleware `EnsureTenant` validando acesso a recursos
- [ ] Global Scope aplicando filtro automatico em queries
- [ ] Testes de isolamento entre organizadores

### Tarefas

| # | Tarefa | Estimativa | Status |
|---|--------|------------|--------|
| 1 | Criar trait `BelongsToOrganizador` | 1h | Pendente |
| 2 | Criar middleware `EnsureTenant` | 1h | Pendente |
| 3 | Aplicar trait nos models: Evento, Expositor, Categoria, Staff, Inscricao | 1h | Pendente |
| 4 | Criar testes de isolamento (Org A nao acessa Org B) | 2h | Pendente |
| 5 | Revisar controllers para usar tenant automatico | 1h | Pendente |

**Estimativa total:** 6h

---

## Epico 6: Landing Page do Evento

### US-6.1: Pagina Publica do Evento

**Status:** 90% implementado - falta SEO e testes

| Item | Status | Acao |
|------|--------|------|
| URL `/evento/[slug]` | ✅ | - |
| Secao Hero | ✅ | - |
| Secao Sobre | ✅ | - |
| Secao Expositores | ✅ | - |
| Secao Localizacao | ✅ | - |
| Botao Inscricao | ✅ | - |
| Meta tags estaticas | ❓ | Verificar |
| Responsividade | ❓ | Testar |
| Testes e2e | ❌ | Criar |

### US-6.2: Lista de Expositores Publica

**Status:** 80% implementado - falta testes

| Item | Status | Acao |
|------|--------|------|
| Grid de expositores | ✅ | - |
| Endpoint publico | ✅ | - |
| Testes | ❌ | Criar |

### US-6.3: Formulario de Inscricao

**Status:** 85% implementado - falta testes e2e

| Item | Status | Acao |
|------|--------|------|
| Pagina de inscricao | ✅ | - |
| Campos completos | ✅ | - |
| Validacoes | ✅ | - |
| Feedback sucesso/erro | ✅ | - |
| Testes e2e | ❌ | Criar |

### US-6.4: Pagina de Confirmacao

**Status:** 85% implementado - falta mapa e testes

| Item | Status | Acao |
|------|--------|------|
| QR Code | ✅ | - |
| Info do evento | ✅ | - |
| Adicionar calendario | ✅ | - |
| Ver mapa | ❓ | Verificar integracao |
| Testes | ❌ | Criar |

### US-6.5: Cloudflare Workers para SEO (NOVA)

**Como** sistema,
**Quero** injetar meta tags dinamicas via Cloudflare Workers,
**Para** otimizar SEO e compartilhamento em redes sociais.

**Documentacao tecnica:** [docs/analises/tecnicas/cloudflare-workers-seo.md](../analises/tecnicas/cloudflare-workers-seo.md)

### Criterios de Aceite

- [ ] Worker detecta crawlers por User-Agent
- [ ] Meta tags dinamicas injetadas (Open Graph, Twitter Cards, Schema.org)
- [ ] Dados do evento buscados via API
- [ ] Cache na edge (KV) funcionando
- [ ] Fallback para SPA se API falhar
- [ ] Deploy automatizado via CI/CD
- [ ] Validacao com Facebook Debugger e Twitter Card Validator

### Tarefas

| # | Tarefa | Estimativa | Status |
|---|--------|------------|--------|
| 1 | Setup projeto Wrangler | 1h | Pendente |
| 2 | Implementar deteccao de crawlers | 1h | Pendente |
| 3 | Criar template de meta tags | 1h | Pendente |
| 4 | Implementar fetch da API | 1h | Pendente |
| 5 | Implementar injecao no HTML | 2h | Pendente |
| 6 | Configurar cache KV | 1h | Pendente |
| 7 | Criar testes unitarios | 2h | Pendente |
| 8 | Configurar CI/CD | 1h | Pendente |
| 9 | Deploy e validacao | 2h | Pendente |

**Estimativa total:** 12h

### Tarefas de Revisao (US-6.1 a US-6.4)

| # | Tarefa | Estimativa | Status |
|---|--------|------------|--------|
| 1 | Revisar responsividade da landing page | 1h | Pendente |
| 2 | Verificar integracao com mapa (Google Maps ou similar) | 1h | Pendente |
| 3 | Criar testes e2e para fluxo de inscricao | 3h | Pendente |
| 4 | Criar testes para pagina publica | 2h | Pendente |

**Estimativa revisao:** 7h

---

## Epico 8: Check-in (Validacao)

**Status:** 100% implementado - precisa validacao em producao

### Componentes Existentes

**Backend:**
- Actions: `RealizarCheckin`, `ValidarQrCode`, `BuscarParticipante`, `RegistrarWalkin`
- Controllers: `Realizar`, `Validar`, `Buscar`, `Walkin`, `Autoatendimento`
- Testes: `RealizarCheckinTest`, `AutoatendimentoTest`, `BuscarParticipanteTest`, `WalkinTest`

**Frontend:**
- Views: `TotemView`, `StaffCheckinView`, `WalkinView`
- Components: `QRScanner`, `ParticipanteInfo`, `CheckinConfirmacao`, `BuscaParticipante`, `WalkinForm`
- Store: `checkin`

### Tarefas de Validacao

| # | Tarefa | Estimativa | Status |
|---|--------|------------|--------|
| 1 | Testar totem em dispositivo real (tablet/totem) | 1h | Pendente |
| 2 | Testar check-in staff em celular | 1h | Pendente |
| 3 | Testar walk-in completo | 0.5h | Pendente |
| 4 | Testar busca por nome/email | 0.5h | Pendente |
| 5 | Validar mensagens de erro (QR invalido, duplicado, evento encerrado) | 0.5h | Pendente |
| 6 | Testar offline mode (se aplicavel) | 1h | Pendente |

**Estimativa validacao:** 4.5h

---

## Resumo de Estimativas

| Item | Estimativa |
|------|------------|
| US-1.6 Multi-tenant | 6h |
| US-6.1 a US-6.4 Revisao | 7h |
| US-6.5 Cloudflare Workers | 12h |
| Epico 8 Validacao | 4.5h |
| **Total** | **29.5h** |

---

## Dependencias

### Cloudflare Workers

| Recurso | Status | Acao |
|---------|--------|------|
| Conta Cloudflare | ❓ | Verificar/criar |
| Dominio no Cloudflare DNS | ❓ | Configurar |
| API Token | ❓ | Gerar |
| KV Namespace | ❓ | Criar |

### Ambiente de Testes

| Recurso | Status | Acao |
|---------|--------|------|
| Dispositivo tablet/totem | ❓ | Disponibilizar |
| Celular para teste staff | ❓ | Disponibilizar |

---

## Decisoes Tomadas

### 2026-03-16 - Cloudflare Workers para SEO

**Contexto:** SPAs nao sao bem indexadas por crawlers. Precisamos de meta tags dinamicas para SEO e compartilhamento em redes sociais.

**Opcoes Consideradas:**
1. SSR com Nuxt.js - Requer reescrever o frontend
2. Pre-rendering estatico - Nao funciona para conteudo dinamico
3. Cloudflare Workers - Intercepta apenas crawlers, mantem SPA

**Decisao:** Cloudflare Workers por ser solucao edge que nao impacta a arquitetura atual e tem custo baixo (free tier suficiente).

**Consequencias:**
- Precisa conta Cloudflare com dominio configurado
- Adiciona complexidade de deploy (mais um servico)
- Melhora significativa em SEO e compartilhamento social

---

## Artefatos Produzidos

### Documentacao

| Tipo | Caminho | Descricao |
|------|---------|-----------|
| Analise Tecnica | [docs/analises/tecnicas/cloudflare-workers-seo.md](../analises/tecnicas/cloudflare-workers-seo.md) | Arquitetura e implementacao do Worker |

### Codigo (a produzir)

| Tipo | Caminho | Descricao |
|------|---------|-----------|
| Trait | api/app/Traits/BelongsToOrganizador.php | Multi-tenancy |
| Middleware | api/app/Http/Middleware/EnsureTenant.php | Validacao de tenant |
| Worker | cloudflare-workers/src/index.ts | Entry point do Worker |
| Tests | api/tests/Feature/MultiTenancyTest.php | Testes de isolamento |
| Tests | front/tests/e2e/inscricao.spec.ts | Testes e2e inscricao |

---

## Impedimentos e Riscos

| ID | Descricao | Impacto | Mitigacao | Status |
|----|-----------|---------|-----------|--------|
| R01 | Conta Cloudflare nao configurada | Alto | Criar/configurar conta antes de iniciar US-6.5 | Aberto |
| R02 | Dispositivos para teste de check-in | Medio | Usar emuladores ou dispositivos pessoais | Aberto |

---

## Metricas

| Metrica | Planejado | Realizado |
|---------|-----------|-----------|
| User Stories concluidas | 10 | - |
| Testes criados | 15+ | - |
| Cobertura e2e | 80% | - |

---

**Criado em:** 2026-03-16
**Ultima atualizacao:** 2026-03-16
