# Sprint 06

> **Periodo:** 2026-03-19 a 2026-04-02
> **Status:** Planejamento
> **Objetivo:** Implementar integracao com Pagar.me, sistema de catalogo de produtos e faturas

## Backlog da Sprint

### Features

| ID | Feature | Prioridade | Status | Responsavel |
|----|---------|------------|--------|-------------|
| F01 | [Integracao Pagar.me e Catalogo](../analises/features/integracao-pagarme-catalogo.md) | Alta | Pendente | - |

### User Stories

| ID | User Story | Prioridade | Status |
|----|------------|------------|--------|
| US-F01 | Gestao de Catalogo (Admin) | Alta | Pendente |
| US-F02 | Precos por Evento | Media | Pendente |
| US-F03 | Criacao de Faturas | Alta | Pendente |
| US-F04 | Pagamento com Cartao | Alta | Pendente |
| US-F05 | Pagamento com PIX | Alta | Pendente |
| US-F06 | Parcelamento | Media | Pendente |

---

## Fase 1: Estrutura Base

### Tarefas

| # | Tarefa | Tipo | Status |
|---|--------|------|--------|
| 1.1 | Criar enum TipoProduto | Enum | Pendente |
| 1.2 | Criar enum StatusFatura | Enum | Pendente |
| 1.3 | Criar enum StatusTransacao | Enum | Pendente |
| 1.4 | Criar enum MetodoPagamento | Enum | Pendente |
| 1.5 | Criar migration categorias_produto | Migration | Pendente |
| 1.6 | Criar migration produtos | Migration | Pendente |
| 1.7 | Criar migration produtos_evento | Migration | Pendente |
| 1.8 | Criar migration faturas | Migration | Pendente |
| 1.9 | Criar migration itens_fatura | Migration | Pendente |
| 1.10 | Alterar migration pagamentos (novos campos) | Migration | Pendente |
| 1.11 | Criar model CategoriaProduto | Model | Pendente |
| 1.12 | Criar model Produto | Model | Pendente |
| 1.13 | Criar model ProdutoEvento | Model | Pendente |
| 1.14 | Criar model Fatura | Model | Pendente |
| 1.15 | Criar model ItemFatura | Model | Pendente |
| 1.16 | Atualizar model Pagamento | Model | Pendente |
| 1.17 | Criar factories | Factory | Pendente |
| 1.18 | Criar seeders | Seeder | Pendente |
| 1.19 | Rodar migrations | Infra | Pendente |

---

## Fase 2: Catalogo de Produtos (Admin)

### Testes (TDD)

| # | Teste | Cenarios | Status |
|---|-------|----------|--------|
| 2.1 | CriarCategoriaTest | Sucesso, validacoes, duplicado | Pendente |
| 2.2 | AtualizarCategoriaTest | Sucesso, nao encontrada | Pendente |
| 2.3 | RemoverCategoriaTest | Sucesso, com produtos vinculados | Pendente |
| 2.4 | CriarProdutoTest | Sucesso, validacoes, categoria invalida | Pendente |
| 2.5 | AtualizarProdutoTest | Sucesso, nao encontrado | Pendente |
| 2.6 | RemoverProdutoTest | Sucesso, em uso | Pendente |
| 2.7 | DefinirPrecoEventoTest | Sucesso, produto/evento invalido | Pendente |

### Actions

| # | Action | Descricao | Status |
|---|--------|-----------|--------|
| 2.8 | Catalogo/Categoria/Criar | Criar categoria | Pendente |
| 2.9 | Catalogo/Categoria/Atualizar | Atualizar categoria | Pendente |
| 2.10 | Catalogo/Categoria/Remover | Remover categoria | Pendente |
| 2.11 | Catalogo/Categoria/Listar | Listar categorias | Pendente |
| 2.12 | Catalogo/Produto/Criar | Criar produto | Pendente |
| 2.13 | Catalogo/Produto/Atualizar | Atualizar produto | Pendente |
| 2.14 | Catalogo/Produto/Remover | Remover produto | Pendente |
| 2.15 | Catalogo/Produto/Listar | Listar produtos | Pendente |
| 2.16 | Catalogo/Produto/DefinirPrecoEvento | Preco por evento | Pendente |

### Controllers

| # | Controller | Metodo | Status |
|---|------------|--------|--------|
| 2.17 | Admin/Catalogo/Categoria/Index | GET | Pendente |
| 2.18 | Admin/Catalogo/Categoria/Store | POST | Pendente |
| 2.19 | Admin/Catalogo/Categoria/Update | PUT | Pendente |
| 2.20 | Admin/Catalogo/Categoria/Destroy | DELETE | Pendente |
| 2.21 | Admin/Catalogo/Produto/Index | GET | Pendente |
| 2.22 | Admin/Catalogo/Produto/Store | POST | Pendente |
| 2.23 | Admin/Catalogo/Produto/Update | PUT | Pendente |
| 2.24 | Admin/Catalogo/Produto/Destroy | DELETE | Pendente |
| 2.25 | Admin/Catalogo/Produto/PrecoEvento | POST | Pendente |

---

## Fase 3: Sistema de Faturas

### Testes (TDD)

| # | Teste | Cenarios | Status |
|---|-------|----------|--------|
| 3.1 | CriarFaturaTest | Sucesso, cliente invalido | Pendente |
| 3.2 | AdicionarItemTest | Sucesso, fatura nao rascunho, produto invalido | Pendente |
| 3.3 | RemoverItemTest | Sucesso, item nao encontrado | Pendente |
| 3.4 | AplicarDescontoTest | Sucesso, desconto > total | Pendente |
| 3.5 | FinalizarFaturaTest | Sucesso, sem itens, ja finalizada | Pendente |
| 3.6 | CancelarFaturaTest | Sucesso, ja paga | Pendente |
| 3.7 | GerarNumeroFaturaTest | Formato correto, sequencial | Pendente |

### Actions

| # | Action | Descricao | Status |
|---|--------|-----------|--------|
| 3.8 | Fatura/Criar | Criar fatura em rascunho | Pendente |
| 3.9 | Fatura/AdicionarItem | Adicionar item | Pendente |
| 3.10 | Fatura/RemoverItem | Remover item | Pendente |
| 3.11 | Fatura/AplicarDesconto | Aplicar desconto | Pendente |
| 3.12 | Fatura/Finalizar | Rascunho → Pendente | Pendente |
| 3.13 | Fatura/Cancelar | Cancelar fatura | Pendente |
| 3.14 | Fatura/Listar | Listar faturas | Pendente |
| 3.15 | Fatura/GerarNumero | Gerar numero sequencial | Pendente |

### Controllers

| # | Controller | Metodo | Status |
|---|------------|--------|--------|
| 3.16 | Admin/Fatura/Index | GET | Pendente |
| 3.17 | Admin/Fatura/Store | POST | Pendente |
| 3.18 | Admin/Fatura/Show | GET | Pendente |
| 3.19 | Admin/Fatura/Item/Store | POST | Pendente |
| 3.20 | Admin/Fatura/Item/Destroy | DELETE | Pendente |
| 3.21 | Admin/Fatura/Desconto | POST | Pendente |
| 3.22 | Admin/Fatura/Finalizar | POST | Pendente |
| 3.23 | Admin/Fatura/Cancelar | POST | Pendente |
| 3.24 | Fatura/Index | GET (cliente) | Pendente |
| 3.25 | Fatura/Show | GET (cliente) | Pendente |

---

## Fase 4: Integracao Pagar.me

### Configuracao

| # | Tarefa | Status |
|---|--------|--------|
| 4.1 | Criar config/pagarme.php | Pendente |
| 4.2 | Adicionar variaveis .env | Pendente |
| 4.3 | Instalar SDK Pagar.me (se disponivel) ou usar HTTP | Pendente |

### Testes (TDD)

| # | Teste | Cenarios | Status |
|---|-------|----------|--------|
| 4.4 | ProcessarPagamentoCartaoTest | Sucesso, recusado, dados invalidos | Pendente |
| 4.5 | ProcessarPagamentoPixTest | Gerar QR, expiracao | Pendente |
| 4.6 | ProcessarWebhookTest | Assinatura valida/invalida, eventos | Pendente |
| 4.7 | CalcularParcelamentoTest | 1x a 12x, juros | Pendente |

### Services

| # | Service | Descricao | Status |
|---|---------|-----------|--------|
| 4.8 | Contracts/PaymentGateway | Interface | Pendente |
| 4.9 | Pagarme/Client | Cliente HTTP | Pendente |
| 4.10 | Pagarme/Service | Implementacao gateway | Pendente |

### Actions

| # | Action | Descricao | Status |
|---|--------|-----------|--------|
| 4.11 | Pagamento/ProcessarCartao | Pagamento cartao | Pendente |
| 4.12 | Pagamento/GerarPix | Gerar QR PIX | Pendente |
| 4.13 | Pagamento/ProcessarWebhook | Tratar webhook | Pendente |
| 4.14 | Pagamento/CalcularParcelas | Calcular parcelamento | Pendente |
| 4.15 | Pagamento/ConsultarStatus | Consultar gateway | Pendente |

### Controllers

| # | Controller | Metodo | Status |
|---|------------|--------|--------|
| 4.16 | Pagamento/Cartao | POST | Pendente |
| 4.17 | Pagamento/Pix | POST | Pendente |
| 4.18 | Pagamento/Status | GET | Pendente |
| 4.19 | Webhook/Pagarme | POST (publico) | Pendente |

---

## Fase 5: Events e Listeners

### Events

| # | Event | Descricao | Status |
|---|-------|-----------|--------|
| 5.1 | FaturaCriada | Fatura criada | Pendente |
| 5.2 | FaturaPaga | Fatura paga | Pendente |
| 5.3 | FaturaCancelada | Fatura cancelada | Pendente |
| 5.4 | PagamentoConfirmado | Pagamento confirmado | Pendente |
| 5.5 | PagamentoFalhou | Pagamento falhou | Pendente |

### Listeners

| # | Listener | Evento | Descricao | Status |
|---|----------|--------|-----------|--------|
| 5.6 | AtualizarStatusFatura | PagamentoConfirmado | Marca fatura como paga | Pendente |
| 5.7 | NotificarClientePagamento | PagamentoConfirmado | Email de confirmacao | Pendente |
| 5.8 | NotificarClienteFalha | PagamentoFalhou | Email de falha | Pendente |
| 5.9 | AtualizarStatusEvento | FaturaPaga | Marca evento como pago | Pendente |
| 5.10 | RegistrarAuditoria | Todos | Log de auditoria | Pendente |

---

## Fase 6: Frontend (Vue 3)

### Stores

| # | Store | Responsabilidade | Status |
|---|-------|------------------|--------|
| 6.1 | catalogo | Gestao de produtos/categorias | Pendente |
| 6.2 | faturas | Gestao de faturas | Pendente |
| 6.3 | pagamento | Processamento de pagamentos | Pendente |

### Views Admin

| # | View | Descricao | Status |
|---|------|-----------|--------|
| 6.4 | CatalogoView | Lista de produtos | Pendente |
| 6.5 | ProdutoFormView | Criar/editar produto | Pendente |
| 6.6 | FaturasAdminView | Lista de faturas | Pendente |
| 6.7 | FaturaDetailAdminView | Detalhes da fatura | Pendente |

### Views Cliente

| # | View | Descricao | Status |
|---|------|-----------|--------|
| 6.8 | MinhasFaturasView | Lista de faturas do cliente | Pendente |
| 6.9 | FaturaDetailView | Visualizar fatura | Pendente |
| 6.10 | PagamentoView | Tela de pagamento | Pendente |
| 6.11 | PagamentoConfirmacaoView | Confirmacao pos-pagamento | Pendente |

### Componentes

| # | Componente | Responsabilidade | Status |
|---|------------|------------------|--------|
| 6.12 | CategoriaSelect | Seletor de categoria | Pendente |
| 6.13 | ProdutoCard | Card de produto | Pendente |
| 6.14 | ProdutoForm | Formulario de produto | Pendente |
| 6.15 | FaturaTable | Tabela de faturas | Pendente |
| 6.16 | FaturaItemList | Lista de itens da fatura | Pendente |
| 6.17 | AdicionarItemForm | Adicionar item a fatura | Pendente |
| 6.18 | CartaoForm | Campos do cartao | Pendente |
| 6.19 | ParcelamentoSelector | Seletor de parcelas | Pendente |
| 6.20 | PixQrCode | QR Code PIX | Pendente |
| 6.21 | StatusPagamento | Status do pagamento | Pendente |

---

## Decisoes Tomadas

### 2026-03-19 - Model Pagamento Unificado

**Contexto:** Decidir entre criar novo model Transacao ou expandir Pagamento existente.

**Opcoes Consideradas:**
1. Criar Transacao separado - mais limpo, quebra compatibilidade
2. Manter ambos - redundancia, complexidade
3. Unificar em Pagamento - compatibilidade, menos models

**Decisao:** Unificar em Pagamento, adicionando campos fatura_id, parcelas, valor_parcela, juros, pix_qrcode, pix_expira_em.

**Consequencias:**
- Retrocompatibilidade mantida
- evento_id e fatura_id sao mutuamente exclusivos (nullable)
- Pagamentos manuais continuam funcionando

### 2026-03-19 - Formas de Pagamento

**Contexto:** Definir quais formas de pagamento aceitar.

**Decisao:** Cartao de credito, cartao de debito e PIX. Boleto nao sera aceito.

**Consequencias:**
- Parcelamento disponivel apenas para credito
- PIX com QR Code e expiracao de 30 minutos

### 2026-03-19 - Parcelamento

**Contexto:** Definir politica de parcelamento.

**Decisao:** Ate 12x com juros repassados ao cliente.

**Consequencias:**
- Taxa de juros configuravel em config/pagarme.php
- Valor das parcelas calculado e exibido antes da confirmacao

---

## Dependencias

### Pagar.me

| Recurso | Status | Acao |
|---------|--------|------|
| Conta Pagar.me | Pendente | Criar/configurar |
| API Key (sandbox) | Pendente | Gerar |
| API Key (producao) | Pendente | Gerar apos homologacao |
| Webhook URL | Pendente | Configurar ngrok (dev) |

### Ambiente

| Recurso | Status | Acao |
|---------|--------|------|
| ngrok ou similar | Pendente | Instalar para teste webhook |
| Variaveis .env | Pendente | Adicionar credenciais |

---

## Artefatos Produzidos

### Documentacao

| Tipo | Caminho | Descricao |
|------|---------|-----------|
| Analise Feature | [docs/analises/features/integracao-pagarme-catalogo.md](../analises/features/integracao-pagarme-catalogo.md) | Especificacao completa |

### Codigo (a produzir)

| Tipo | Caminho | Descricao |
|------|---------|-----------|
| Enums | api/app/Enums/TipoProduto.php | Tipos de produto |
| Enums | api/app/Enums/StatusFatura.php | Status de fatura |
| Enums | api/app/Enums/StatusTransacao.php | Status de transacao |
| Enums | api/app/Enums/MetodoPagamento.php | Metodos de pagamento |
| Models | api/app/Models/CategoriaProduto.php | Categoria de produto |
| Models | api/app/Models/Produto.php | Produto |
| Models | api/app/Models/ProdutoEvento.php | Preco por evento |
| Models | api/app/Models/Fatura.php | Fatura |
| Models | api/app/Models/ItemFatura.php | Item de fatura |
| Service | api/app/Services/Pagarme/Service.php | Integracao Pagar.me |
| Config | api/config/pagarme.php | Configuracoes |

---

## Impedimentos e Riscos

| ID | Descricao | Impacto | Mitigacao | Status |
|----|-----------|---------|-----------|--------|
| R01 | Conta Pagar.me nao configurada | Alto | Criar conta antes de iniciar Fase 4 | Aberto |
| R02 | Webhook nao acessivel em dev | Medio | Usar ngrok ou similar | Aberto |
| R03 | Taxa de parcelamento pode mudar | Baixo | Configurar via .env | Aberto |

---

## Metricas

| Metrica | Planejado | Realizado |
|---------|-----------|-----------|
| Migrations | 6 | - |
| Models | 5 (novos) + 1 (alterado) | - |
| Actions | ~25 | - |
| Controllers | ~25 | - |
| Testes | ~40 | - |
| Componentes Vue | ~15 | - |

---

**Criado em:** 2026-03-19
**Ultima atualizacao:** 2026-03-19
