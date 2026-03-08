# Changelog - Documentacao BizzExpo

Historico de alteracoes na documentacao do projeto.

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/).

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

