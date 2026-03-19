# Changelog - Documentacao BizzExpo

Historico de alteracoes na documentacao do projeto.

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/).

---

## [0.5.0] - 2026-03-19

### Adicionado

#### Backend (API)
- **Épico 13 - Sistema Administrativo**
  - Pacote `spatie/laravel-permission` para roles e permissões
  - Pacote `owen-it/laravel-auditing` para auditoria
  - Role "admin" com permissões específicas
  - Action `MarcarEventoComoPago` para admin marcar pagamento manual
  - Action `ListarEventosAdmin` para listar todos os eventos
  - Action `EnviarNotificacao` para notificações genéricas
  - Evento `EventoPago` com listeners:
    - `AtualizarStatusEvento` - muda status para PAGO
    - `NotificarOrganizador` - envia notificação database + email
    - `RegistrarPagamento` - log de auditoria
  - Model `Notificacao` com enums TipoNotificacao e NotificacaoStatus
  - Jobs `EnviarEmailNotificacao` e `EnviarWebhookNotificacao`
  - Middleware `EnsureUserIsAdmin`
  - Controllers Admin: `Evento/Listar` e `Evento/MarcarPago`
  - Rotas admin protegidas: GET /admin/eventos, PATCH /admin/eventos/{id}/pago
  - Seeders: `RolesAndPermissionsSeeder`, `AdminUserSeeder`
  - Mailable `NotificacaoGenerica` para emails transacionais
  - Migration para tabela `notificacoes`
  - Migration para campos admin em `pagamentos` (admin_id, observacao)

- **Testes**
  - `MarcarEventoComoPagoTest` - cenários de sucesso e erro
  - `ListarEventosAdminTest` - listagem admin
  - `EnviarNotificacaoTest` - jobs de notificação
  - `EventoAuditoriaTest` - verificação de auditoria
  - Factory `NotificacaoFactory`

#### Frontend (Vue 3)
- Computed `isAdmin` no store `auth`
- Método `marcarComoPago` no store `eventos`
- Modal de pagamento manual em `EventoDetailView`
- Botão "Marcar como Pago" visível apenas para admin
- Tipos atualizados com `roles` e `is_admin` em User

#### Infraestrutura
- Mailpit configurado no docker-compose.yml (portas 8025 e 1025)
- Configuração de email para ambiente de desenvolvimento

### Alterado
- `EventoStatus.canTransitionTo()` - organizer não pode mais alterar rascunho → pago
- `UserResource` - inclui roles e is_admin na resposta
- `DatabaseSeeder` - chama seeders de roles e admin users

---

## [0.4.0] - 2026-03-16 (Em Andamento)

### Adicionado

#### Documentacao
- **Sprint 04** - Planejamento da sprint com foco em:
  - US-1.6: Estrutura Multi-tenant
  - Epico 6: Landing Page do Evento (revisao e SEO)
  - Epico 8: Check-in (validacao)
- **US-6.5: Cloudflare Workers para SEO** - Nova user story adicionada ao backlog
- **Analise Tecnica** - `docs/analises/tecnicas/cloudflare-workers-seo.md`
  - Arquitetura de Workers para injecao de meta tags
  - Diagramas de fluxo e sequencia
  - Codigo de referencia
  - Estrategia de cache e deploy

### Alterado
- BACKLOG.md atualizado com status dos epicos (varios marcados como Concluido)
- MILESTONES.md atualizado com M1, M2, M3 e proximos milestones planejados

---

## [0.3.0] - 2026-03-07

### Adicionado

#### Backend (API)
- **Epico 4 - Sistema de Inscricao**
  - Action `CriarInscricao` com geracao automatica de QR Code
  - Action `ListarInscricoes` com filtros por categoria, check-in e busca
  - Action `CancelarInscricao` com validacoes de regras de negocio
  - Action `ExportarInscricoes` em formato CSV
  - Emails de confirmacao e cancelamento de inscricao

- **Epico 5 - Dashboard Expositor**
  - Action `ObterMetricasExpositor` com totais e leads por interesse
  - Action `ListarLeads` com filtros por nivel de interesse
  - Action `ExportarLeads` em formato CSV

- **Epico 6 - Landing Page Evento**
  - Controller publico `Evento/Publico/Visualizar`
  - Controller publico `Expositor/Publico/Listar`
  - Controller publico `Categoria/Publico/Listar`

- **Epico 8 - Check-in**
  - Action `RealizarCheckin` via QR Code
  - Action `ValidarQrCode` para verificacao de inscricao
  - Action `BuscarParticipante` por nome/email
  - Action `RegistrarWalkin` (cadastro + check-in imediato)
  - Controller `Autoatendimento` para totem publico

- **Testes**
  - 324 testes automatizados (1127 assertions)
  - Cobertura completa de cenarios de sucesso e erro

#### Frontend (Vue 3)
- **Epico 4 - Sistema de Inscricao**
  - View `InscricaoView` com formulario publico
  - View `ConfirmacaoView` com exibicao de QR Code
  - View `InscricoesListView` para gestao pelo organizador
  - Store `inscricoes` com filtros, paginacao e exportacao

- **Epico 5 - Dashboard Expositor**
  - View `DashboardView` com metricas do expositor
  - View `LeadsListView` com tabela e filtros
  - Componentes: `MetricasExpositor`, `LeadsTable`, `FiltrosLeads`, `ExportarLeadsButton`
  - Stores: `expositorDashboard`, `leads`

- **Epico 6 - Landing Page Evento**
  - View `EventoPublicoView` com informacoes do evento
  - Componentes: `HeroEvento`, `SobreEvento`, `ExpositoresGrid`, `LocalizacaoEvento`
  - Store `eventoPublico`

- **Epico 8 - Check-in**
  - View `TotemView` para autoatendimento
  - View `StaffCheckinView` para equipe
  - View `WalkinView` para cadastro local
  - Componentes: `QRScanner`, `ParticipanteInfo`, `CheckinConfirmacao`, `BuscaParticipante`, `WalkinForm`
  - Store `checkin` com integracao html5-qrcode

#### Infraestrutura
- Configuracao PWA com `manifest.json`
- Separacao de repositorios: `bizzexpo-api` e `bizzexpo-front`
- Makefile com comandos `clone`, `clone-https`, `pull`
- Configuracoes do Claude Code (`.claude/`)

### Alterado
- `EventoDetailView` agora exibe links para Inscricoes, Check-in e Totem
- Tipos TypeScript atualizados com `InscricaoCompleta`, `LeadCompleto`, `DashboardExpositor`

---

## [0.2.0] - 2026-03-07

### Adicionado

#### Backend (API)
- **Sprint 2 - Gestao de Eventos**
  - CRUD completo de Eventos
  - CRUD completo de Expositores
  - CRUD completo de Categorias
  - CRUD completo de Estandes
  - CRUD completo de Staff
  - Dashboard do Organizador com metricas
  - Ranking de Expositores por leads
  - Horarios de pico de check-in
  - Alteracao de status de eventos (rascunho -> pago -> publicado -> encerrado)

#### Frontend (Vue 3)
- Views e componentes para gestao de eventos
- Views e componentes para gestao de expositores
- Views e componentes para gestao de categorias
- Views e componentes para gestao de estandes
- Views e componentes para gestao de staff
- Dashboard do organizador

---

## [0.1.0] - 2026-03-07

### Adicionado

#### Backend (API)
- **Sprint 1 - Autenticacao e Organizador**
  - Registro de usuarios
  - Login com Sanctum
  - Logout
  - CRUD de Organizador

#### Frontend (Vue 3)
- Landing page institucional
- Telas de login e registro
- Cadastro de organizador
- Layout autenticado com sidebar

#### Infraestrutura
- Docker Compose com API, Frontend, PostgreSQL e Mailpit
- Makefile com comandos utilitarios
- Documentacao inicial do projeto

