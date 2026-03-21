# BACKLOG - BizzExpo

Este documento lista funcionalidades implementadas, em andamento e planejadas.

**Última atualização:** 2026-03-19 (Sprint 06)
**Mantido por:** Equipe de Desenvolvimento

---

## Visão Geral do Projeto

### Épicos

| # | Épico | Status | Sprint |
|---|-------|--------|--------|
| 1 | Infraestrutura | Em Andamento | 04 (US-1.6) |
| 2 | Gestão de Eventos | Concluído | 02-03 |
| 3 | Gestão de Expositores | Concluído | 02-03 |
| 4 | Sistema de Inscrição | Concluído | 03 |
| 5 | Dashboard Analítico | Concluído | 03 |
| 6 | Landing Page Evento | Em Andamento | 04 |
| 7 | Pagamento | Em Andamento | 06 |
| 8 | Check-in | Concluído | 03-04 (validação) |
| 9 | Gestão de Organizador | Pendente | - |
| 10 | Gestão de Staff | Concluído | 02 |
| 11 | Captura de Leads | Concluído | 03 |
| 12 | Customização Visual | Pendente | - |
| 13 | Sistema Administrativo | Concluído | 05 |

---

## Épico 1: Infraestrutura

**Objetivo:** Configurar base do projeto, autenticação e estrutura multi-tenant.

### User Stories

#### US-1.1: Setup do Projeto Backend
**Como** desenvolvedor,
**Quero** ter o projeto Laravel configurado com Docker,
**Para** iniciar o desenvolvimento da API.

**Critérios de aceite:**
- [ ] Laravel 12 instalado
- [ ] Docker Compose configurado (PHP, PostgreSQL, Redis)
- [ ] Breeze API com Sanctum instalado
- [ ] Estrutura de pastas seguindo padrões do projeto (Actions, etc.)
- [ ] Migrations iniciais rodando

**Tarefas:**
- [ ] Criar docker-compose.yml
- [ ] Instalar Laravel 12
- [ ] Configurar Breeze API
- [ ] Configurar PostgreSQL
- [ ] Criar estrutura de pastas (Actions, Services, etc.)

---

#### US-1.2: Setup do Projeto Frontend
**Como** desenvolvedor,
**Quero** ter o projeto Vue 3 configurado como PWA,
**Para** iniciar o desenvolvimento do frontend.

**Critérios de aceite:**
- [ ] Vue 3 + TypeScript configurado
- [ ] Tailwind v4 instalado
- [ ] Pinia configurado
- [ ] Reka-UI instalado
- [ ] PWA manifest configurado
- [ ] Estrutura de pastas definida

**Tarefas:**
- [ ] Criar projeto Vue 3 com Vite
- [ ] Configurar TypeScript
- [ ] Instalar e configurar Tailwind v4
- [ ] Instalar Pinia
- [ ] Instalar Reka-UI
- [ ] Configurar PWA (manifest, service worker básico)

---

#### US-1.3: Autenticação por Email/Senha
**Como** usuário (organizador, expositor, participante, staff),
**Quero** me cadastrar e fazer login com email e senha,
**Para** acessar a plataforma.

**Critérios de aceite:**
- [ ] Endpoint de registro funcional
- [ ] Endpoint de login funcional
- [ ] Endpoint de logout funcional
- [ ] Endpoint de recuperação de senha funcional
- [ ] Tokens Sanctum sendo gerados
- [ ] Validações de email único e senha forte
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes de registro
- [ ] Criar testes de login
- [ ] Criar testes de logout
- [ ] Criar testes de recuperação de senha
- [ ] Implementar endpoints
- [ ] Configurar emails transacionais

---

#### US-1.4: Autenticação OAuth2
**Como** usuário,
**Quero** me cadastrar e fazer login com Google ou LinkedIn,
**Para** ter acesso mais rápido à plataforma.

**Critérios de aceite:**
- [ ] Login com Google funcional
- [ ] Login com LinkedIn funcional
- [ ] Vinculação de conta social com conta existente
- [ ] Testes automatizados

**Tarefas:**
- [ ] Instalar Laravel Socialite
- [ ] Configurar provider Google
- [ ] Configurar provider LinkedIn
- [ ] Criar testes
- [ ] Implementar endpoints

---

#### US-1.5: Cadastro de Organizador
**Como** pessoa interessada em organizar eventos,
**Quero** me cadastrar como organizador,
**Para** criar e gerenciar meus eventos.

**Critérios de aceite:**
- [ ] Formulário com campos: nome, email, telefone, empresa, CNPJ, cargo
- [ ] Validação de CNPJ
- [ ] Email de boas-vindas enviado
- [ ] Organizador criado com status ativo
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration de organizadores
- [ ] Criar model Organizador
- [ ] Criar testes
- [ ] Criar Action de cadastro
- [ ] Criar endpoint

---

#### US-1.6: Estrutura Multi-tenant
**Como** sistema,
**Quero** isolar dados por organizador,
**Para** garantir segurança e privacidade.

**Critérios de aceite:**
- [ ] Todas as queries filtradas por organizador
- [ ] Middleware de tenant configurado
- [ ] Testes de isolamento

**Tarefas:**
- [ ] Definir estratégia de multi-tenancy (coluna tenant_id)
- [ ] Criar trait HasTenant
- [ ] Criar middleware de tenant
- [ ] Criar testes

---

## Épico 2: Gestão de Eventos

**Objetivo:** Permitir que organizadores criem e configurem eventos.

### User Stories

#### US-2.1: Criar Evento
**Como** organizador,
**Quero** criar um novo evento,
**Para** começar a configurá-lo.

**Critérios de aceite:**
- [ ] Formulário com campos: nome, descrição, data início, data fim, local, logo, banner
- [ ] Evento criado com status "rascunho"
- [ ] Slug gerado automaticamente a partir do nome
- [ ] Validações de datas (fim >= início, início >= hoje)
- [ ] Upload de logo e banner funcional
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration de eventos
- [ ] Criar model Evento
- [ ] Criar testes
- [ ] Criar Action de criação
- [ ] Criar endpoint
- [ ] Implementar upload de imagens

---

#### US-2.2: Editar Evento
**Como** organizador,
**Quero** editar os dados do meu evento,
**Para** manter as informações atualizadas.

**Critérios de aceite:**
- [ ] Todos os campos editáveis (exceto slug após publicação)
- [ ] Validações mantidas
- [ ] Histórico de alterações (audit log)
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de edição
- [ ] Criar endpoint
- [ ] Implementar audit log

---

#### US-2.3: Listar Eventos
**Como** organizador,
**Quero** ver todos os meus eventos,
**Para** gerenciá-los.

**Critérios de aceite:**
- [ ] Lista paginada
- [ ] Filtros por status (rascunho, pago, publicado, encerrado)
- [ ] Ordenação por data
- [ ] Exibir: nome, data, status, total inscritos
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de listagem
- [ ] Criar endpoint

---

#### US-2.4: Configurar Categorias de Participantes
**Como** organizador,
**Quero** definir categorias de participantes para meu evento,
**Para** segmentar o público nos relatórios.

**Critérios de aceite:**
- [ ] CRUD de categorias por evento
- [ ] Campos: nome, descrição (opcional)
- [ ] Mínimo 1 categoria por evento
- [ ] Categorias padrão sugeridas (Visitante, Comprador, Imprensa, VIP)
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration de categorias
- [ ] Criar model Categoria
- [ ] Criar testes
- [ ] Criar Actions (criar, editar, listar, excluir)
- [ ] Criar endpoints

---

#### US-2.5: Alterar Status do Evento
**Como** organizador,
**Quero** publicar ou encerrar meu evento,
**Para** controlar seu ciclo de vida.

**Critérios de aceite:**
- [ ] Transições válidas: rascunho → pago → publicado → encerrado
- [ ] Publicação só permitida após pagamento
- [ ] Evento encerrado não aceita mais inscrições
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de transição de status
- [ ] Criar endpoint
- [ ] Implementar validações de transição

---

## Épico 3: Gestão de Expositores

**Objetivo:** Permitir cadastro de expositores e estandes por evento.

### User Stories

#### US-3.1: Cadastrar Expositor
**Como** organizador,
**Quero** cadastrar expositores no meu evento,
**Para** que participem da feira.

**Critérios de aceite:**
- [ ] Campos: nome empresa, CNPJ, contato, email, telefone, site, redes sociais, logo, descrição
- [ ] Email de convite enviado ao expositor
- [ ] Expositor pode criar conta a partir do convite
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration de expositores
- [ ] Criar model Expositor
- [ ] Criar testes
- [ ] Criar Action de cadastro
- [ ] Criar endpoint
- [ ] Implementar email de convite

---

#### US-3.2: Listar Expositores
**Como** organizador,
**Quero** ver todos os expositores do meu evento,
**Para** gerenciá-los.

**Critérios de aceite:**
- [ ] Lista paginada
- [ ] Busca por nome
- [ ] Exibir: logo, nome, contato, qtd estandes, qtd leads
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de listagem
- [ ] Criar endpoint

---

#### US-3.3: Editar Expositor
**Como** organizador,
**Quero** editar dados de um expositor,
**Para** manter informações atualizadas.

**Critérios de aceite:**
- [ ] Todos os campos editáveis
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de edição
- [ ] Criar endpoint

---

#### US-3.4: Remover Expositor
**Como** organizador,
**Quero** remover um expositor do evento,
**Para** casos de cancelamento.

**Critérios de aceite:**
- [ ] Soft delete
- [ ] Estandes vinculados também removidos
- [ ] Leads mantidos para histórico
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de remoção
- [ ] Criar endpoint

---

#### US-3.5: Cadastrar Estande
**Como** organizador ou expositor,
**Quero** cadastrar estandes,
**Para** gerar QR Codes de captura de leads.

**Critérios de aceite:**
- [ ] Campos: nome/identificação, localização (opcional)
- [ ] QR Code gerado automaticamente
- [ ] Múltiplos estandes por expositor
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration de estandes
- [ ] Criar model Estande
- [ ] Criar testes
- [ ] Criar Action de cadastro
- [ ] Criar endpoint
- [ ] Implementar geração de QR Code

---

#### US-3.6: Visualizar QR Code do Estande
**Como** expositor,
**Quero** visualizar e baixar o QR Code do meu estande,
**Para** exibir no local.

**Critérios de aceite:**
- [ ] QR Code exibido em tela
- [ ] Download em PNG e PDF
- [ ] QR Code contém URL única do estande
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de geração
- [ ] Criar endpoint de download

---

## Épico 4: Sistema de Inscrição

**Objetivo:** Permitir que participantes se inscrevam em eventos.

### User Stories

#### US-4.1: Inscrever-se em Evento
**Como** visitante,
**Quero** me inscrever em um evento,
**Para** participar.

**Critérios de aceite:**
- [ ] Formulário com campos: nome, email, telefone, empresa, cargo, cidade/UF, categoria
- [ ] Criação de conta automática (se não existir)
- [ ] Seleção de categoria obrigatória
- [ ] Aceite de termos obrigatório
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration de inscrições
- [ ] Criar model Inscricao
- [ ] Criar testes
- [ ] Criar Action de inscrição
- [ ] Criar endpoint

---

#### US-4.2: Gerar QR Code do Participante
**Como** sistema,
**Quero** gerar QR Code único para cada inscrição,
**Para** uso no check-in.

**Critérios de aceite:**
- [ ] QR Code único por inscrição
- [ ] Contém identificador criptografado
- [ ] Gerado automaticamente após inscrição
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Implementar geração de QR Code
- [ ] Vincular à inscrição

---

#### US-4.3: Enviar Email de Confirmação
**Como** participante,
**Quero** receber email de confirmação,
**Para** ter meu QR Code de acesso.

**Critérios de aceite:**
- [ ] Email enviado após inscrição
- [ ] Contém QR Code anexo ou inline
- [ ] Contém informações do evento (data, local, horário)
- [ ] Link para adicionar ao calendário
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar template de email
- [ ] Criar testes
- [ ] Implementar envio
- [ ] Gerar link de calendário (.ics)

---

#### US-4.4: Listar Inscrições (Organizador)
**Como** organizador,
**Quero** ver todas as inscrições do meu evento,
**Para** acompanhar o público.

**Critérios de aceite:**
- [ ] Lista paginada
- [ ] Filtros por categoria, status (inscrito, check-in realizado)
- [ ] Busca por nome ou email
- [ ] Exportação CSV
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de listagem
- [ ] Criar endpoint
- [ ] Implementar exportação CSV

---

#### US-4.5: Cancelar Inscrição
**Como** participante,
**Quero** cancelar minha inscrição,
**Para** liberar minha vaga.

**Critérios de aceite:**
- [ ] Cancelamento via painel do participante
- [ ] QR Code invalidado
- [ ] Email de confirmação de cancelamento
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de cancelamento
- [ ] Criar endpoint
- [ ] Implementar email

---

## Épico 5: Dashboard Analítico

**Objetivo:** Fornecer métricas e relatórios para organizadores e expositores.

### User Stories

#### US-5.1: Dashboard do Organizador
**Como** organizador,
**Quero** ver métricas do meu evento,
**Para** acompanhar o desempenho.

**Critérios de aceite:**
- [ ] Total de inscritos
- [ ] Total de check-ins realizados
- [ ] Taxa de conversão (check-ins / inscritos)
- [ ] Distribuição por categoria
- [ ] Gráfico de inscrições ao longo do tempo
- [ ] Atualização em tempo real (ou polling)
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Actions de métricas
- [ ] Criar endpoints
- [ ] Implementar agregações

---

#### US-5.2: Ranking de Expositores
**Como** organizador,
**Quero** ver quais expositores têm mais interesse,
**Para** identificar os mais populares.

**Critérios de aceite:**
- [ ] Lista ordenada por quantidade de leads
- [ ] Exibir: posição, nome, total leads
- [ ] Filtro por período
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de ranking
- [ ] Criar endpoint

---

#### US-5.3: Horários de Pico
**Como** organizador,
**Quero** ver os horários de maior movimento,
**Para** planejar operações.

**Critérios de aceite:**
- [ ] Gráfico de check-ins por hora
- [ ] Identificação visual de picos
- [ ] Filtro por dia (eventos multi-dia)
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de análise temporal
- [ ] Criar endpoint

---

#### US-5.4: Dashboard do Expositor
**Como** expositor,
**Quero** ver métricas dos meus leads,
**Para** acompanhar interesse no meu estande.

**Critérios de aceite:**
- [ ] Total de leads capturados
- [ ] Leads por estande
- [ ] Distribuição por nível de interesse
- [ ] Lista de leads com detalhes
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Actions de métricas do expositor
- [ ] Criar endpoints

---

#### US-5.5: Exportar Leads
**Como** expositor,
**Quero** exportar meus leads,
**Para** trabalhar no meu CRM.

**Critérios de aceite:**
- [ ] Exportação em CSV
- [ ] Campos: nome, email, nível interesse, data/hora, estande
- [ ] Filtros aplicados na exportação
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de exportação
- [ ] Criar endpoint

---

## Épico 6: Landing Page do Evento

**Objetivo:** Página pública para divulgação e inscrição.

### User Stories

#### US-6.1: Página Pública do Evento
**Como** visitante,
**Quero** acessar a página do evento,
**Para** conhecer e me inscrever.

**Critérios de aceite:**
- [ ] URL amigável: /evento/[slug]
- [ ] Seções: hero, sobre, expositores, como participar, localização
- [ ] Informações do evento exibidas
- [ ] Botão de inscrição visível
- [ ] SEO otimizado (meta tags, Open Graph)
- [ ] Responsivo
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar rota pública
- [ ] Criar componentes Vue
- [ ] Implementar seções conforme wireframe
- [ ] Configurar meta tags dinâmicas
- [ ] Testes e2e

---

#### US-6.2: Lista de Expositores Pública
**Como** visitante,
**Quero** ver os expositores do evento,
**Para** saber quem estará presente.

**Critérios de aceite:**
- [ ] Grid de expositores com logo e nome
- [ ] Página de detalhes do expositor (opcional no MVP)
- [ ] Responsivo
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar componente de grid
- [ ] Criar endpoint público
- [ ] Testes

---

#### US-6.3: Formulário de Inscrição
**Como** visitante,
**Quero** preencher o formulário de inscrição,
**Para** me inscrever no evento.

**Critérios de aceite:**
- [ ] Modal ou página dedicada
- [ ] Campos conforme especificação
- [ ] Validações client-side e server-side
- [ ] Opções de OAuth2
- [ ] Feedback de sucesso/erro
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar componente de formulário
- [ ] Integrar com API
- [ ] Implementar validações
- [ ] Testes e2e

---

#### US-6.4: Página de Confirmação
**Como** participante,
**Quero** ver a confirmação da minha inscrição,
**Para** saber que deu certo.

**Critérios de aceite:**
- [ ] Exibir QR Code
- [ ] Exibir informações do evento
- [ ] Botões: adicionar ao calendário, ver mapa
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar página de confirmação
- [ ] Gerar link de calendário
- [ ] Integrar Google Maps
- [ ] Testes

---

#### US-6.5: Cloudflare Workers para SEO
**Como** sistema,
**Quero** injetar meta tags dinâmicas via Cloudflare Workers,
**Para** otimizar SEO e compartilhamento em redes sociais.

**Documentação técnica:** [docs/analises/tecnicas/cloudflare-workers-seo.md](analises/tecnicas/cloudflare-workers-seo.md)

**Critérios de aceite:**
- [ ] Worker detecta crawlers por User-Agent
- [ ] Meta tags dinâmicas injetadas (Open Graph, Twitter Cards, Schema.org)
- [ ] Dados do evento buscados via API
- [ ] Cache na edge (KV) funcionando
- [ ] Fallback para SPA se API falhar
- [ ] Deploy automatizado via CI/CD
- [ ] Validação com Facebook Debugger e Twitter Card Validator

**Tarefas:**
- [ ] Setup projeto Wrangler
- [ ] Implementar detecção de crawlers
- [ ] Criar template de meta tags
- [ ] Implementar fetch da API
- [ ] Implementar injeção no HTML
- [ ] Configurar cache KV
- [ ] Criar testes unitários
- [ ] Configurar CI/CD
- [ ] Deploy e validação

---

## Épico 7: Pagamento

**Objetivo:** Integrar Pagar.me para cobranca de organizadores e expositores, com catalogo de produtos e sistema de faturas.

**Documentacao:** [Sprint 06](sprints/sprint-06.md) | [Analise Feature](analises/features/integracao-pagarme-catalogo.md)

### User Stories

#### US-7.1: Gestao de Catalogo (Admin)
**Como** admin,
**Quero** gerenciar um catalogo global de produtos e servicos,
**Para** oferecer itens padronizados aos clientes.

**Critérios de aceite:**
- [ ] CRUD de categorias de produto
- [ ] CRUD de produtos com tipo (estande, marketing, equipamento, servico)
- [ ] Preco base definido por produto
- [ ] Produtos podem ser ativados/desativados
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migrations (categorias_produto, produtos)
- [ ] Criar models (CategoriaProduto, Produto)
- [ ] Criar Actions de CRUD
- [ ] Criar Controllers admin
- [ ] Criar testes

---

#### US-7.2: Precos por Evento
**Como** admin,
**Quero** definir precos especificos de produtos por evento,
**Para** flexibilizar a precificacao conforme o contexto.

**Critérios de aceite:**
- [ ] Preco especifico sobrescreve preco base
- [ ] Vinculo produto-evento unico
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration produtos_evento
- [ ] Criar model ProdutoEvento
- [ ] Criar Action DefinirPrecoEvento
- [ ] Criar endpoint
- [ ] Criar testes

---

#### US-7.3: Sistema de Faturas
**Como** sistema/admin,
**Quero** criar faturas com multiplos itens para clientes,
**Para** registrar as cobrancas de forma organizada.

**Critérios de aceite:**
- [ ] Fatura com numero sequencial (ANO-SEQUENCIAL)
- [ ] Cliente polimorfico (Organizador ou Expositor)
- [ ] Status: rascunho, pendente, paga, cancelada, vencida
- [ ] Adicionar/remover itens em rascunho
- [ ] Aplicar desconto
- [ ] Finalizar fatura (rascunho -> pendente)
- [ ] Cancelar fatura
- [ ] Campos fiscais preparados para NF-e futura
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migrations (faturas, itens_fatura)
- [ ] Criar models (Fatura, ItemFatura)
- [ ] Criar Actions de gestao de faturas
- [ ] Criar Controllers admin e cliente
- [ ] Criar testes

---

#### US-7.4: Pagamento com Cartao
**Como** cliente (organizador/expositor),
**Quero** pagar minhas faturas com cartao de credito ou debito,
**Para** ter flexibilidade no pagamento.

**Critérios de aceite:**
- [ ] Integracao com Pagar.me
- [ ] Cartao de credito com parcelamento ate 12x
- [ ] Juros repassados ao cliente
- [ ] Cartao de debito a vista
- [ ] Tokenizacao de dados do cartao (nunca salvar)
- [ ] Fatura marcada como paga apos confirmacao
- [ ] Testes automatizados (mocked)

**Tarefas:**
- [ ] Criar config/pagarme.php
- [ ] Criar Service de integracao Pagar.me
- [ ] Criar Action ProcessarCartao
- [ ] Criar endpoint
- [ ] Criar testes

---

#### US-7.5: Pagamento com PIX
**Como** cliente (organizador/expositor),
**Quero** pagar minhas faturas com PIX,
**Para** ter opcao de pagamento instantaneo.

**Critérios de aceite:**
- [ ] Geracao de QR Code via Pagar.me
- [ ] Codigo copia-e-cola disponivel
- [ ] Expiracao de 30 minutos
- [ ] Webhook confirma pagamento
- [ ] Fatura marcada como paga apos confirmacao
- [ ] Testes automatizados (mocked)

**Tarefas:**
- [ ] Criar Action GerarPix
- [ ] Criar endpoint
- [ ] Criar componente PixQrCode
- [ ] Criar testes

---

#### US-7.6: Webhook Pagar.me
**Como** sistema,
**Quero** receber notificacoes de pagamento do Pagar.me,
**Para** atualizar status das faturas automaticamente.

**Critérios de aceite:**
- [ ] Endpoint publico /api/webhook/pagarme
- [ ] Validacao de assinatura do Pagar.me
- [ ] Tratar eventos: charge.paid, charge.refunded, charge.payment_failed
- [ ] Atualizar status da fatura
- [ ] Notificar cliente por email
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar Action ProcessarWebhook
- [ ] Criar Controller publico
- [ ] Criar Events e Listeners
- [ ] Criar testes

---

#### US-7.7: Parcelamento
**Como** cliente,
**Quero** parcelar meu pagamento em ate 12x no cartao,
**Para** diluir o valor da compra.

**Critérios de aceite:**
- [ ] Calcular valor de cada parcela com juros
- [ ] Exibir simulacao antes de confirmar
- [ ] Taxa de juros configuravel
- [ ] Registro de parcelas e juros no pagamento
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar Action CalcularParcelas
- [ ] Criar componente ParcelamentoSelector
- [ ] Criar testes

---

#### US-7.8: Visualizar Minhas Faturas
**Como** cliente (organizador/expositor),
**Quero** visualizar minhas faturas,
**Para** acompanhar pagamentos.

**Critérios de aceite:**
- [ ] Lista de faturas do cliente autenticado
- [ ] Filtro por status
- [ ] Detalhes da fatura com itens
- [ ] Link para pagamento de fatura pendente
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar Action Listar (cliente)
- [ ] Criar Controllers cliente
- [ ] Criar Views Vue
- [ ] Criar testes

---

## Épico 8: Check-in

**Objetivo:** Permitir check-in de participantes no evento.

### User Stories

#### US-8.1: Check-in por QR Code (Autoatendimento)
**Como** participante,
**Quero** fazer check-in escaneando meu QR Code,
**Para** registrar minha presença.

**Critérios de aceite:**
- [ ] Totem/tela exibe leitor de QR Code
- [ ] QR Code validado
- [ ] Check-in registrado com data/hora
- [ ] Feedback visual de sucesso
- [ ] Impedir check-in duplicado
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar página de autoatendimento
- [ ] Implementar leitor de QR Code (câmera)
- [ ] Criar testes
- [ ] Criar Action de check-in
- [ ] Criar endpoint

---

#### US-8.2: Check-in por QR Code (Staff)
**Como** staff,
**Quero** escanear o QR Code do participante,
**Para** fazer o check-in.

**Critérios de aceite:**
- [ ] App/PWA com leitor de QR Code
- [ ] Exibir nome do participante após scan
- [ ] Confirmar check-in
- [ ] Feedback de sucesso/erro
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar tela de check-in para staff
- [ ] Implementar leitor de QR Code
- [ ] Integrar com API
- [ ] Testes

---

#### US-8.3: Check-in por Busca
**Como** staff,
**Quero** buscar participante por nome,
**Para** fazer check-in quando QR Code não funcionar.

**Critérios de aceite:**
- [ ] Campo de busca por nome ou email
- [ ] Lista de resultados
- [ ] Selecionar e confirmar check-in
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar componente de busca
- [ ] Criar endpoint de busca
- [ ] Integrar com check-in
- [ ] Testes

---

#### US-8.4: Cadastro Walk-in
**Como** staff,
**Quero** cadastrar participante no local,
**Para** inscrever quem não se registrou online.

**Critérios de aceite:**
- [ ] Formulário simplificado (nome, email, telefone, categoria)
- [ ] Inscrição + check-in simultâneos
- [ ] QR Code gerado para o participante
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar tela de walk-in
- [ ] Criar testes
- [ ] Criar Action de walk-in
- [ ] Criar endpoint

---

## Épico 9: Gestão de Organizador

**Objetivo:** Permitir que organizador gerencie seu perfil.

### User Stories

#### US-9.1: Editar Perfil do Organizador
**Como** organizador,
**Quero** editar meus dados cadastrais,
**Para** manter informações atualizadas.

**Critérios de aceite:**
- [ ] Editar todos os campos do cadastro
- [ ] Validação de CNPJ
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de edição
- [ ] Criar endpoint

---

#### US-9.2: Alterar Senha
**Como** organizador,
**Quero** alterar minha senha,
**Para** manter minha conta segura.

**Critérios de aceite:**
- [ ] Exigir senha atual
- [ ] Validar nova senha (força)
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action
- [ ] Criar endpoint

---

## Épico 10: Gestão de Staff

**Objetivo:** Permitir cadastro e gestão de staff por evento.

### User Stories

#### US-10.1: Cadastrar Staff
**Como** organizador,
**Quero** cadastrar membros do staff,
**Para** que ajudem no credenciamento.

**Critérios de aceite:**
- [ ] Campos: nome, email
- [ ] Email de convite enviado
- [ ] Staff vinculado a evento específico
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration de staff
- [ ] Criar model Staff
- [ ] Criar testes
- [ ] Criar Action de cadastro
- [ ] Criar endpoint
- [ ] Implementar email de convite

---

#### US-10.2: Listar Staff
**Como** organizador,
**Quero** ver o staff do meu evento,
**Para** gerenciá-los.

**Critérios de aceite:**
- [ ] Lista de staff do evento
- [ ] Status de ativação da conta
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de listagem
- [ ] Criar endpoint

---

#### US-10.3: Remover Staff
**Como** organizador,
**Quero** remover um membro do staff,
**Para** revogar acesso.

**Critérios de aceite:**
- [ ] Remoção revoga acesso imediato
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar testes
- [ ] Criar Action de remoção
- [ ] Criar endpoint

---

## Épico 11: Captura de Leads

**Objetivo:** Permitir que participantes registrem interesse em expositores.

### User Stories

#### US-11.1: Escanear QR Code do Estande
**Como** participante,
**Quero** escanear o QR Code de um estande,
**Para** registrar meu interesse.

**Critérios de aceite:**
- [ ] PWA com leitor de QR Code
- [ ] Identificar estande pelo QR Code
- [ ] Exibir tela de consentimento
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar tela de scan no PWA
- [ ] Implementar leitor de QR Code
- [ ] Criar endpoint de identificação de estande
- [ ] Testes

---

#### US-11.2: Registrar Interesse com Consentimento
**Como** participante,
**Quero** confirmar meu interesse e consentir compartilhamento,
**Para** que o expositor entre em contato.

**Critérios de aceite:**
- [ ] Exibir nome do expositor
- [ ] Checkbox de consentimento obrigatório
- [ ] Seleção de nível de interesse (quero orçamento, profissional, entusiasta, apenas conhecendo)
- [ ] Confirmação de registro
- [ ] Se já registrou interesse, avisar e não duplicar
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration de leads
- [ ] Criar model Lead
- [ ] Criar tela de consentimento
- [ ] Criar testes
- [ ] Criar Action de registro
- [ ] Criar endpoint

---

#### US-11.3: Consultar Meus Interesses
**Como** participante,
**Quero** ver os expositores que demonstrei interesse,
**Para** consultá-los depois.

**Critérios de aceite:**
- [ ] Lista de expositores com interesse registrado
- [ ] Exibir: nome, site, redes sociais, descrição
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar tela "Meus Interesses"
- [ ] Criar endpoint de listagem
- [ ] Testes

---

#### US-11.4: Visualizar Leads (Expositor)
**Como** expositor,
**Quero** ver os leads capturados,
**Para** fazer follow-up.

**Critérios de aceite:**
- [ ] Lista de leads: nome, email, interesse, data/hora
- [ ] Filtro por estande
- [ ] Filtro por nível de interesse
- [ ] Ordenação por data
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar tela de leads do expositor
- [ ] Criar endpoint de listagem
- [ ] Testes

---

## Épico 12: Customização Visual

**Objetivo:** Permitir personalização visual de páginas públicas e perfis.

### User Stories

#### US-12.1: Customização da Página do Evento
**Como** organizador,
**Quero** personalizar a aparência da página pública do meu evento,
**Para** criar uma identidade visual única.

**Critérios de aceite:**
- [ ] Upload de banner principal
- [ ] Definição de cores/tema (primária, secundária, background)
- [ ] Preview em tempo real
- [ ] Responsivo em dispositivos móveis
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration para customização de evento
- [ ] Criar model/campos de customização
- [ ] Criar endpoints de configuração
- [ ] Criar componentes Vue de customização
- [ ] Implementar upload de banner
- [ ] Implementar seletor de cores
- [ ] Criar preview

---

#### US-12.2: Customização do Perfil do Organizador
**Como** organizador,
**Quero** personalizar meu perfil público,
**Para** fortalecer minha marca.

**Critérios de aceite:**
- [ ] Upload de logo
- [ ] Upload de banner
- [ ] Definição de cores/tema
- [ ] Bio/descrição
- [ ] Links de redes sociais
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration para customização de organizador
- [ ] Criar endpoints de configuração
- [ ] Criar componentes Vue
- [ ] Implementar uploads

---

#### US-12.3: Customização do Perfil do Expositor
**Como** expositor,
**Quero** personalizar minha página no evento,
**Para** destacar minha empresa.

**Critérios de aceite:**
- [ ] Upload de logo
- [ ] Upload de banner/galeria
- [ ] Descrição detalhada
- [ ] Vídeo institucional (embed YouTube/Vimeo)
- [ ] Links de redes sociais
- [ ] Catálogo de produtos (opcional)
- [ ] Testes automatizados

**Tarefas:**
- [ ] Criar migration para customização de expositor
- [ ] Criar endpoints de configuração
- [ ] Criar componentes Vue
- [ ] Implementar uploads e embeds

---

## Épico 13: Sistema Administrativo

**Objetivo:** Permitir gestão administrativa da plataforma pelos usuários SIM/Code2.

### User Stories

#### US-13.1: Roles e Permissões ✅
**Como** sistema,
**Quero** ter um sistema de roles e permissões,
**Para** controlar acesso às funcionalidades administrativas.

**Critérios de aceite:**
- [x] Pacote spatie/laravel-permission instalado
- [x] Role "admin" criada
- [x] Permissões configuradas (eventos.marcar.pago, eventos.listar.todos, etc.)
- [x] Guard Sanctum configurado
- [x] Seeder de roles e permissões
- [x] Testes automatizados

---

#### US-13.2: Marcar Evento como Pago (Admin) ✅
**Como** admin,
**Quero** marcar eventos como pagos,
**Para** liberar a publicação pelo organizador.

**Critérios de aceite:**
- [x] Endpoint PATCH /admin/eventos/{id}/pago
- [x] Somente admin pode acessar
- [x] Registro de pagamento manual criado
- [x] Evento muda de rascunho para pago
- [x] Evento EventoPago disparado
- [x] Notificação enviada ao organizador (database + email)
- [x] Auditoria registrada
- [x] Testes automatizados

---

#### US-13.3: Listar Todos os Eventos (Admin) ✅
**Como** admin,
**Quero** visualizar todos os eventos da plataforma,
**Para** ter visão geral do sistema.

**Critérios de aceite:**
- [x] Endpoint GET /admin/eventos
- [x] Somente admin pode acessar
- [x] Lista todos os eventos de todos os organizadores
- [x] Testes automatizados

---

#### US-13.4: Auditoria de Eventos ✅
**Como** admin,
**Quero** visualizar histórico de alterações,
**Para** rastrear mudanças nos eventos.

**Critérios de aceite:**
- [x] Pacote owen-it/laravel-auditing instalado
- [x] Models User e Evento auditáveis
- [x] Registro de alterações automático
- [x] Testes automatizados

---

#### US-13.5: Notificações de Pagamento ✅
**Como** organizador,
**Quero** ser notificado quando meu evento for marcado como pago,
**Para** saber que posso publicá-lo.

**Critérios de aceite:**
- [x] Notificação salva no banco (database)
- [x] Email enviado via Mailpit (dev)
- [x] Model Notificacao criado
- [x] Jobs para envio assíncrono
- [x] Testes automatizados

---

#### US-13.6: Interface Admin no Frontend ✅
**Como** admin,
**Quero** ter botão de "Marcar como Pago" na página do evento,
**Para** realizar a operação de forma visual.

**Critérios de aceite:**
- [x] Botão visível apenas para admin
- [x] Modal com campos: valor e observação
- [x] Integração com endpoint /admin/eventos/{id}/pago
- [x] Feedback de sucesso/erro
- [x] Store eventos com método marcarComoPago

---

## Fora do MVP

Funcionalidades para versões futuras:

- [ ] Impressão de credenciais
- [ ] Funcionamento offline
- [ ] Backoffice admin (SIM/Code2)
- [ ] Campos personalizáveis na inscrição
- [ ] App nativo
- [ ] Networking inteligente
- [ ] Heatmaps de circulação
- [ ] Integração com CRM
- [ ] Rede de anúncios

---

## Notas

- **Priorização:** Seguir ordem dos épicos
- **Dependências:** Épicos posteriores dependem dos anteriores
- **Documentação:** Cada sprint deve ter arquivo em `docs/sprints/`
- **Testes:** Sempre criar testes antes de implementar

---

**Última revisão:** 2026-03-19
