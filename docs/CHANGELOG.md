# Changelog - Documentacao BizzExpo

Historico de alteracoes na documentacao do projeto.

Formato baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/).

---

## [0.7.0] - 2026-04-08

### Adicionado

#### Backend (API)
- **Refatoracao Pessoa/Expositor/Patrocinador/EspacoComercial**
  - Nova entidade `Pessoa` (PF/PJ) centralizando dados cadastrais
  - Nova entidade `Contato` para multiplos emails, telefones, WhatsApp
  - Nova entidade `EspacoComercial` unificando stands e espacos de ativacao
  - Nova entidade `Patrocinador` com vinculo a Pessoa e CotaPatrocinio

- **Enums**
  - `TipoPessoa` (PF, PJ)
  - `TipoContato` (EMAIL, TELEFONE, CELULAR, WHATSAPP)
  - `TipoEspaco` (STAND, ATIVACAO, OUTRO)

- **Events e Listeners**
  - `PessoaCriada` + `CriarContatoPrincipal` (cria email automatico)
  - `ExpositorCadastrado` + `GerarFaturaExpositor`, `EnviarEmailExpositor`
  - `PatrocinadorCadastrado` + `GerarFaturaPatrocinador`, `EnviarEmailPatrocinador`

- **Actions**
  - `Pessoa/Criar` - Cria pessoa com documento
  - `Pessoa/BuscarPorDocumento` - Busca no escopo do organizador
  - `EspacoComercial/Criar`, `Listar`, `Atualizar`, `Excluir`
  - `Patrocinador/Cadastrar`, `Listar`

- **Migrations**
  - 12 migrations para criacao de tabelas, migracao de dados e limpeza
  - Migracao automatica de dados existentes (organizadores, expositores)
  - Preparacao para remocao de colunas legadas (comentadas)

- **Testes**
  - `CriarPessoaTest`, `BuscarPorDocumentoTest`, `ContatoTest`
  - `CriarEspacoComercialTest`, `ListarEspacosComerciaisTest`, `AtualizarEspacoComercialTest`, `ExcluirEspacoComercialTest`
  - `CriarExpositorRefatoradoTest`
  - `CadastrarPatrocinadorTest`

- **Factories**
  - `PessoaFactory`, `ContatoFactory`, `EspacoComercialFactory`, `PatrocinadorFactory`

### Alterado
- **Model User** - Adicionado `hasOne Pessoa`
- **Model Documento** - Adicionado `hasOne Pessoa`, atualizado `estaEmUso()`
- **Model Evento** - Adicionado `hasMany espacosComerciais`, `hasMany patrocinadores`
- **Model Expositor** - Refatorado com `belongsTo Pessoa`, `belongsTo EspacoComercial`, accessors de compatibilidade
- **Model Organizador** - Refatorado com `belongsTo Pessoa`, accessors de compatibilidade
- **Model CotaPatrocinio** - Adicionado `hasMany Patrocinador`, metodos `atingiuLimite()`, accessor `vagas_disponiveis`
- **Action CriarExpositor** - Refatorada para usar Pessoa + EspacoComercial, dispara ExpositorCadastrado
- **EventServiceProvider** - Registrados novos eventos (PessoaCriada, ExpositorCadastrado, PatrocinadorCadastrado)

### Documentacao
- Atualizado modelo de dados com novas entidades
- Atualizado backlog com features de gestao do organizador

---

## [0.6.1] - 2026-03-25

### Adicionado

#### Backend (API)
- **Pacote resend/resend-laravel** para envio de emails via Resend
- **Migration auditable_id** - Altera coluna de UUID para string(36) para suportar models com ID inteiro
- **Testes InscricaoTest** - 5 cenarios (inscricao publica, listagem, duplicata, evento nao publicado, isolamento)

#### Frontend (Vue 3)
- **Toast feedback** em inscricao e walk-in para erros de servidor/rede
- **Variaveis CSS Material Design 3**:
  - `--color-surface-container-*` (lowest, low, default, high, highest)
  - `--color-on-surface`, `--color-on-surface-variant`
  - Cores de estado: error, success, warning, info
- **Testes E2E Playwright** - 10 cenarios para inscricao, walk-in e listagem

### Corrigido
- **Erro 500 na inscricao** - Pacote Resend faltava em producao
- **Modais transparentes** - CSS variables do Material Design 3 faltando
- **Falta de feedback visual** - Adicionado Toast apos inscricao/walk-in com erro
- **Factories com fake()** - Substituido por `$this->faker` (compatibilidade)

---

## [0.6.0] - 2026-03-19 (Em Andamento)

### Adicionado

#### Backend (API)
- **MarcarEventoComoPago refatorada**
  - Cria fatura automaticamente quando evento nao possui fatura
  - Valida valor conforme plano (Essencial R$ 299 / Profissional R$ 899)
  - Plano Enterprise aceita qualquer valor positivo (sob consulta)
  - Gera item da fatura com descricao apropriada por tipo de plano
  - 8 novos testes cobrindo cenarios de criacao automatica e validacao

#### Documentacao
- **Sprint 06** - Planejamento da sprint com foco em:
  - Integracao Pagar.me (cartao credito, debito, PIX)
  - Catalogo global de produtos e servicos
  - Sistema de faturas com itens
  - Preparacao para NF-e futura
- **Analise Feature** - `docs/analises/features/integracao-pagarme-catalogo.md`
  - Modelo de dados completo
  - Criterios de aceitacao em Gherkin
  - Endpoints da API
  - Regras de negocio
  - Fluxos de pagamento

### Alterado
- BACKLOG.md atualizado com Epico 7 detalhado (8 user stories)
- Epico 7 mudou de "Pendente" para "Em Andamento"

---

## [0.5.1] - 2026-03-19

### Adicionado

#### Backend (API)
- **Sistema de Impersonation**
  - Migration `create_impersonation_sessions_table` para auditoria de sessões
  - Model `ImpersonationSession` com relacionamentos e scopes
  - Action `Admin/Impersonation/BuscarOrganizadores` - busca por empresa ou CNPJ
  - Action `Admin/Impersonation/IniciarImpersonation` - cria token e sessão
  - Action `Admin/Impersonation/EncerrarImpersonation` - revoga token e fecha sessão
  - Resource `OrganizadorBuscaResource` para retorno da busca
  - Controllers: `Buscar`, `Iniciar`, `Encerrar`
  - Rotas: GET /admin/impersonation/buscar, POST /admin/impersonation/iniciar, POST /impersonation/encerrar

- **Página Financeiro Admin**
  - Action `Admin/ObterMetricasFinanceiras` - receita do mês, eventos pagos/pendentes
  - Controller `Admin/Financeiro/Metricas`
  - Rota: GET /admin/financeiro/metricas

- **Correções**
  - Controller `Evento/Visualizar` permite admin visualizar qualquer evento
  - Action `BuscarOrganizadores` compatível com SQLite (LOWER ao invés de ILIKE)

- **Testes**
  - `BuscarOrganizadoresTest` - 9 cenários
  - `IniciarImpersonationTest` - 8 cenários
  - `EncerrarImpersonationTest` - 7 cenários
  - `ObterMetricasFinanceirasTest`

#### Frontend (Vue 3)
- **Sistema de Impersonation**
  - Type `OrganizadorBusca` em types/index.ts
  - Store `auth` com state e actions para impersonation
  - Componente `OrganizadorCombobox` - busca de organizadores no header
  - Componente `ImpersonationBanner` - banner amarelo quando impersonando
  - Header atualizado com combobox para admin
  - AppLayout com banner de impersonation

- **Página Financeiro**
  - View `FinanceiroView` com cards de métricas e lista de eventos
  - Rota `/admin/financeiro` com guard `requiresAdmin`
  - Sidebar com menu admin (visível apenas para admin não impersonando)

### Alterado
- Guard `authGuard` - adicionada verificação de `requiresAdmin`
- Sidebar oculta menu admin quando impersonando

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

