# Integracao Pagar.me e Catalogo de Produtos

> **Status:** Em Analise
> **Sprint:** 06
> **Data de criacao:** 2026-03-19
> **Ultima atualizacao:** 2026-03-19

## Descricao

Implementacao da integracao com o gateway de pagamento Pagar.me para processar cobrancas de organizadores e expositores, juntamente com a criacao de um sistema de catalogo de produtos/servicos e faturas.

## Escopo

### Organizadores
- Pagam taxa unica por evento (uso da plataforma)

### Expositores
- Podem comprar produtos e servicos oferecidos pela DuEvento e parceiros
- Produtos: estandes, marketing, equipamentos, servicos de logistica

## User Stories

### US-F01: Gestao de Catalogo

**Como** admin,
**Quero** gerenciar um catalogo global de produtos e servicos,
**Para** oferecer itens padronizados aos clientes.

### US-F02: Precos por Evento

**Como** admin,
**Quero** definir precos especificos de produtos por evento,
**Para** flexibilizar a precificacao conforme o contexto do evento.

### US-F03: Criacao de Faturas

**Como** sistema/admin,
**Quero** criar faturas com multiplos itens para clientes,
**Para** registrar as cobrancas de forma organizada.

### US-F04: Pagamento com Cartao

**Como** cliente (organizador/expositor),
**Quero** pagar minhas faturas com cartao de credito ou debito,
**Para** ter flexibilidade no pagamento.

### US-F05: Pagamento com PIX

**Como** cliente (organizador/expositor),
**Quero** pagar minhas faturas com PIX,
**Para** ter opcao de pagamento instantaneo.

### US-F06: Parcelamento

**Como** cliente,
**Quero** parcelar meu pagamento em ate 12x no cartao,
**Para** diluir o valor da compra.

## Criterios de Aceitacao

```gherkin
Funcionalidade: Catalogo de Produtos

  Cenario: Admin cria produto no catalogo
    Dado que estou autenticado como admin
    Quando crio um produto com nome, categoria, tipo e preco base
    Entao o produto deve ser salvo e ficar disponivel no catalogo

  Cenario: Admin define preco por evento
    Dado que existe um produto no catalogo
    E existe um evento cadastrado
    Quando defino um preco especifico para esse produto nesse evento
    Entao o preco customizado deve ser utilizado nas faturas desse evento

Funcionalidade: Faturas

  Cenario: Sistema cria fatura para organizador
    Dado que um organizador criou um evento
    Quando o sistema gera a fatura de uso da plataforma
    Entao a fatura deve conter o item de taxa do evento
    E o status deve ser "pendente"

  Cenario: Admin adiciona item a fatura
    Dado que existe uma fatura em rascunho
    Quando adiciono um produto do catalogo
    Entao o item deve ser adicionado com preco e quantidade
    E o total da fatura deve ser recalculado

Funcionalidade: Pagamento Cartao

  Cenario: Cliente paga fatura com cartao de credito a vista
    Dado que tenho uma fatura pendente de R$ 500,00
    Quando seleciono pagamento com cartao de credito
    E informo os dados do cartao
    E escolho pagamento a vista
    Entao a transacao deve ser enviada ao Pagar.me
    E o status da fatura deve mudar para "paga" apos confirmacao

  Cenario: Cliente parcela pagamento em 12x
    Dado que tenho uma fatura pendente de R$ 1.200,00
    Quando seleciono parcelamento em 12x
    Entao os juros devem ser calculados e adicionados
    E o valor de cada parcela deve ser exibido
    E a transacao deve ser processada com os dados de parcelamento

  Cenario: Pagamento falha por cartao recusado
    Dado que tenho uma fatura pendente
    Quando tento pagar com cartao invalido
    Entao a transacao deve falhar
    E o status da fatura deve permanecer "pendente"
    E uma mensagem de erro deve ser exibida

Funcionalidade: Pagamento PIX

  Cenario: Cliente gera QR Code PIX
    Dado que tenho uma fatura pendente de R$ 300,00
    Quando seleciono pagamento com PIX
    Entao um QR Code deve ser gerado pelo Pagar.me
    E o codigo copia-e-cola deve ser exibido
    E a expiracao do PIX deve ser informada (30 minutos)

  Cenario: Webhook confirma pagamento PIX
    Dado que um PIX foi gerado para uma fatura
    Quando o cliente efetua o pagamento
    E o Pagar.me envia webhook de confirmacao
    Entao o pagamento deve ser registrado como "pago"
    E a fatura deve ser marcada como "paga"
    E o cliente deve ser notificado
```

## Modelo de Dados

### Novas Tabelas

```
categorias_produto
├── id (UUID, PK)
├── nome (varchar)
├── descricao (text, nullable)
├── ativo (boolean, default true)
├── created_at
└── updated_at

produtos
├── id (UUID, PK)
├── categoria_id (FK → categorias_produto)
├── nome (varchar)
├── descricao (text, nullable)
├── tipo (enum: ESTANDE, MARKETING, EQUIPAMENTO, SERVICO)
├── preco_base (decimal 10,2)
├── ativo (boolean, default true)
├── created_at
└── updated_at

produtos_evento
├── id (UUID, PK)
├── produto_id (FK → produtos)
├── evento_id (FK → eventos)
├── preco (decimal 10,2)
├── ativo (boolean, default true)
├── created_at
└── updated_at
├── UNIQUE (produto_id, evento_id)

faturas
├── id (UUID, PK)
├── numero (varchar, unique) -- formato: ANO-SEQUENCIAL
├── cliente_type (varchar) -- morph: Organizador ou Expositor
├── cliente_id (UUID)
├── evento_id (FK → eventos, nullable)
├── subtotal (decimal 10,2)
├── desconto (decimal 10,2, default 0)
├── total (decimal 10,2)
├── status (enum: RASCUNHO, PENDENTE, PAGA, CANCELADA, VENCIDA)
├── vencimento (date, nullable)
├── -- campos fiscais (preparacao NF-e)
├── serie (varchar, nullable)
├── numero_nf (varchar, nullable)
├── chave_nf (varchar, nullable)
├── xml_nf (text, nullable)
├── pdf_nf (varchar, nullable)
├── status_fiscal (varchar, nullable)
├── emitida_em (datetime, nullable)
├── created_at
└── updated_at

itens_fatura
├── id (UUID, PK)
├── fatura_id (FK → faturas, CASCADE)
├── produto_id (FK → produtos, nullable)
├── descricao (varchar) -- permite item avulso
├── quantidade (int, default 1)
├── preco_unitario (decimal 10,2)
├── subtotal (decimal 10,2)
├── created_at
└── updated_at
```

### Alteracoes na Tabela Existente

```
pagamentos (adicionar campos)
├── fatura_id (FK → faturas, nullable)
├── parcelas (int, default 1)
├── valor_parcela (decimal 10,2, nullable)
├── juros (decimal 10,2, default 0)
├── pix_qrcode (text, nullable)
├── pix_expira_em (datetime, nullable)
```

## Diagrama de Relacionamentos

```
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│CategoriaProduto │◄─────│     Produto     │─────►│  ProdutoEvento  │
└─────────────────┘      └────────┬────────┘      └────────┬────────┘
                                  │                        │
                                  │                        │
                                  ▼                        ▼
                         ┌─────────────────┐      ┌─────────────────┐
                         │   ItemFatura    │      │     Evento      │
                         └────────┬────────┘      └────────┬────────┘
                                  │                        │
                                  │                        │
                                  ▼                        │
┌─────────────────┐      ┌─────────────────┐              │
│   Organizador   │◄─────│     Fatura      │◄─────────────┘
│   Expositor     │ morph└────────┬────────┘
└─────────────────┘               │
                                  │
                                  ▼
                         ┌─────────────────┐
                         │    Pagamento    │─────► Pagar.me
                         └─────────────────┘
```

## Regras de Negocio

1. **RN01** - Produto deve ter preco_base > 0
2. **RN02** - ProdutoEvento sobrescreve preco_base quando existir
3. **RN03** - Fatura em RASCUNHO pode ter itens adicionados/removidos
4. **RN04** - Fatura PENDENTE nao pode ser alterada
5. **RN05** - Fatura so pode ser PAGA via pagamento confirmado
6. **RN06** - Fatura VENCIDA apos data de vencimento sem pagamento
7. **RN07** - Numero da fatura segue formato ANO-SEQUENCIAL (ex: 2026-00001)
8. **RN08** - Parcelamento disponivel apenas para cartao de credito
9. **RN09** - Parcelamento maximo de 12x com juros repassados
10. **RN10** - PIX tem validade de 30 minutos
11. **RN11** - Boleto nao sera aceito como forma de pagamento
12. **RN12** - Um pagamento pode estar vinculado a evento_id OU fatura_id (nunca ambos vazios)

## Endpoints da API

### Catalogo (Admin)

| Metodo | Endpoint | Descricao |
|--------|----------|-----------|
| GET | /api/admin/catalogo/categorias | Listar categorias |
| POST | /api/admin/catalogo/categorias | Criar categoria |
| PUT | /api/admin/catalogo/categorias/{id} | Atualizar categoria |
| DELETE | /api/admin/catalogo/categorias/{id} | Remover categoria |
| GET | /api/admin/catalogo/produtos | Listar produtos |
| POST | /api/admin/catalogo/produtos | Criar produto |
| PUT | /api/admin/catalogo/produtos/{id} | Atualizar produto |
| DELETE | /api/admin/catalogo/produtos/{id} | Remover produto |
| POST | /api/admin/catalogo/produtos/{id}/evento/{eventoId}/preco | Definir preco por evento |

### Faturas (Admin)

| Metodo | Endpoint | Descricao |
|--------|----------|-----------|
| GET | /api/admin/faturas | Listar todas as faturas |
| POST | /api/admin/faturas | Criar fatura |
| GET | /api/admin/faturas/{id} | Visualizar fatura |
| POST | /api/admin/faturas/{id}/itens | Adicionar item |
| DELETE | /api/admin/faturas/{id}/itens/{itemId} | Remover item |
| POST | /api/admin/faturas/{id}/desconto | Aplicar desconto |
| POST | /api/admin/faturas/{id}/finalizar | Finalizar (RASCUNHO → PENDENTE) |
| POST | /api/admin/faturas/{id}/cancelar | Cancelar fatura |

### Faturas (Cliente)

| Metodo | Endpoint | Descricao |
|--------|----------|-----------|
| GET | /api/faturas | Listar minhas faturas |
| GET | /api/faturas/{id} | Visualizar fatura |

### Pagamentos

| Metodo | Endpoint | Descricao |
|--------|----------|-----------|
| POST | /api/pagamento/cartao | Pagar com cartao |
| POST | /api/pagamento/pix | Gerar PIX |
| GET | /api/pagamento/{id}/status | Consultar status |
| POST | /api/webhook/pagarme | Webhook Pagar.me |

## Integracao Pagar.me

### Configuracao

```php
// config/pagarme.php
return [
    'api_key' => env('PAGARME_API_KEY'),
    'secret_key' => env('PAGARME_SECRET_KEY'),
    'webhook_secret' => env('PAGARME_WEBHOOK_SECRET'),
    'environment' => env('PAGARME_ENV', 'sandbox'),
    'max_installments' => 12,
    'installments_interest_rate' => 2.99, // % ao mes
];
```

### Fluxo Cartao de Credito

1. Cliente envia dados do cartao (criptografados)
2. API cria transacao no Pagar.me
3. Pagar.me retorna status (authorized/refused)
4. Se autorizado, captura automatica
5. Webhook confirma pagamento
6. Fatura marcada como PAGA

### Fluxo PIX

1. Cliente solicita pagamento PIX
2. API cria cobranca PIX no Pagar.me
3. Pagar.me retorna QR Code e codigo copia-cola
4. Cliente paga via app do banco
5. Webhook notifica pagamento
6. Fatura marcada como PAGA

### Webhook

- Endpoint publico: `POST /api/webhook/pagarme`
- Validacao de assinatura do Pagar.me
- Eventos tratados:
  - `charge.paid` - pagamento confirmado
  - `charge.refunded` - estorno realizado
  - `charge.payment_failed` - pagamento falhou

## Componentes Vue

| Componente | Responsabilidade |
|------------|------------------|
| CatalogoList | Lista de produtos do catalogo |
| ProdutoForm | Formulario de criacao/edicao de produto |
| FaturaList | Lista de faturas |
| FaturaDetail | Detalhes da fatura com itens |
| FaturaItemForm | Adicionar item a fatura |
| PagamentoForm | Formulario de pagamento |
| CartaoForm | Campos do cartao de credito |
| PixQrCode | Exibicao do QR Code PIX |
| ParcelamentoSelector | Seletor de parcelas |

## Dependencias

- [ ] Conta Pagar.me configurada (sandbox e producao)
- [ ] API Keys do Pagar.me
- [ ] URL publica para webhook (ngrok em dev)
- [ ] Tabelas de taxas de parcelamento atualizadas

## Observacoes

### Seguranca
- Dados de cartao nunca sao armazenados no backend
- Usar tokenizacao do Pagar.me no frontend
- Webhook validado por assinatura

### Campos Fiscais
- Estrutura preparada para integracao futura com NF-e
- Campos sao nullable e nao obrigatorios nesta fase

### Compatibilidade
- Model Pagamento existente sera expandido (nao substituido)
- Pagamentos manuais continuam funcionando
- evento_id mantido para retrocompatibilidade

---

## Historico de Aprovacoes

| Data | Responsavel | Tipo | Observacao |
|------|-------------|------|------------|
| 2026-03-19 | - | Analise | Rascunho inicial criado |
