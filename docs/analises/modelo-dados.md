# Modelo de Dados - BizzExpo

**Versão:** MVP (Milestone 1)
**Última atualização:** 2026-03-07

---

## Diagrama de Classes

```mermaid
classDiagram
    direction TB

    %% ==========================================
    %% AUTENTICAÇÃO E USUÁRIOS
    %% ==========================================

    class User {
        +uuid id
        +string name
        +string email
        +string password
        +datetime email_verified_at
        +string remember_token
        +datetime created_at
        +datetime updated_at
    }

    class Organizador {
        +uuid id
        +uuid user_id
        +string telefone
        +string empresa
        +string cnpj
        +string cargo
        +datetime created_at
        +datetime updated_at
    }

    class Participante {
        +uuid id
        +uuid user_id
        +string telefone
        +string empresa
        +string cargo
        +string cidade_uf
        +datetime created_at
        +datetime updated_at
    }

    %% ==========================================
    %% EVENTO E CONFIGURAÇÕES
    %% ==========================================

    class Evento {
        +uuid id
        +uuid organizador_id
        +string nome
        +string slug
        +text descricao
        +datetime data_inicio
        +datetime data_fim
        +string local
        +string logo
        +string banner
        +string status
        +datetime created_at
        +datetime updated_at
    }

    class Categoria {
        +uuid id
        +uuid evento_id
        +string nome
        +string descricao
        +datetime created_at
        +datetime updated_at
    }

    class Staff {
        +uuid id
        +uuid evento_id
        +uuid user_id
        +datetime created_at
        +datetime updated_at
    }

    %% ==========================================
    %% EXPOSITORES E ESTANDES
    %% ==========================================

    class Expositor {
        +uuid id
        +uuid evento_id
        +uuid user_id
        +string nome_empresa
        +string cnpj
        +string nome_contato
        +string email_contato
        +string telefone
        +string site
        +json redes_sociais
        +string logo
        +text descricao
        +datetime created_at
        +datetime updated_at
    }

    class Estande {
        +uuid id
        +uuid expositor_id
        +string nome
        +string localizacao
        +string qrcode
        +datetime created_at
        +datetime updated_at
    }

    %% ==========================================
    %% INSCRIÇÕES E LEADS
    %% ==========================================

    class Inscricao {
        +uuid id
        +uuid evento_id
        +uuid participante_id
        +uuid categoria_id
        +string qrcode
        +datetime checkin_at
        +datetime created_at
        +datetime updated_at
    }

    class Lead {
        +uuid id
        +uuid estande_id
        +uuid participante_id
        +string nivel_interesse
        +datetime created_at
        +datetime updated_at
    }

    %% ==========================================
    %% PAGAMENTOS
    %% ==========================================

    class Pagamento {
        +uuid id
        +uuid evento_id
        +string gateway_id
        +string gateway
        +decimal valor
        +string status
        +string metodo
        +json metadata
        +datetime paid_at
        +datetime created_at
        +datetime updated_at
    }

    %% ==========================================
    %% RELACIONAMENTOS
    %% ==========================================

    User "1" -- "0..1" Organizador : tem
    User "1" -- "0..1" Participante : tem
    User "1" -- "*" Staff : é
    User "1" -- "*" Expositor : gerencia

    Organizador "1" -- "*" Evento : organiza

    Evento "1" -- "*" Categoria : possui
    Evento "1" -- "*" Staff : tem
    Evento "1" -- "*" Expositor : participa
    Evento "1" -- "*" Inscricao : recebe
    Evento "1" -- "*" Pagamento : tem

    Expositor "1" -- "*" Estande : possui

    Categoria "1" -- "*" Inscricao : classifica

    Participante "1" -- "*" Inscricao : faz
    Participante "1" -- "*" Lead : demonstra

    Estande "1" -- "*" Lead : recebe

    Inscricao "1" -- "0..1" Inscricao : checkin
```

---

## Descrição das Entidades

### User
Entidade base de autenticação. Todos os perfis (organizador, participante, staff, expositor) são vinculados a um User.

### Organizador
Pessoa ou empresa que contrata a plataforma e cria eventos. Relacionado 1:1 com User.

### Participante
Pessoa que se inscreve em eventos. Relacionado 1:1 com User. Pode se inscrever em múltiplos eventos.

### Evento
Feira, exposição ou congresso criado por um organizador. Possui status: `rascunho`, `pago`, `publicado`, `encerrado`.

### Categoria
Segmentação de participantes dentro de um evento (ex: Visitante, Comprador, Imprensa, VIP).

### Staff
Equipe de apoio vinculada a um evento específico. Realiza check-in e cadastro walk-in.

### Expositor
Empresa que participa de um evento com estandes. Vinculado a um evento específico e gerenciado por um User.

### Estande
Ponto de presença física do expositor no evento. Possui QR Code único para captura de leads.

### Inscricao
Registro de participante em evento. Possui QR Code para check-in e registro de data/hora do check-in.

### Lead
Registro de interesse de participante em expositor. Criado quando participante escaneia QR Code do estande.

### Pagamento
Registro de pagamento do organizador para publicar evento. Integração com Pagar.me.

---

## Enums

### EventoStatus
- `rascunho` - Evento criado, não pago
- `pago` - Pagamento confirmado
- `publicado` - Landing page ativa, inscrições abertas
- `encerrado` - Evento finalizado

### NivelInteresse
- `orcamento` - Quero orçamento
- `profissional` - Sou profissional da área
- `entusiasta` - Sou entusiasta
- `conhecendo` - Apenas conhecendo

### PagamentoStatus
- `pendente` - Aguardando pagamento
- `processando` - Em processamento
- `pago` - Confirmado
- `falhou` - Falha no pagamento
- `estornado` - Estornado

### PagamentoMetodo
- `credit_card` - Cartão de crédito
- `debit_card` - Cartão de débito
- `pix` - PIX

---

## Índices Recomendados

| Tabela | Colunas | Tipo |
|--------|---------|------|
| eventos | organizador_id | INDEX |
| eventos | slug | UNIQUE |
| eventos | status | INDEX |
| categorias | evento_id | INDEX |
| expositores | evento_id | INDEX |
| expositores | user_id | INDEX |
| estandes | expositor_id | INDEX |
| estandes | qrcode | UNIQUE |
| inscricoes | evento_id, participante_id | UNIQUE |
| inscricoes | qrcode | UNIQUE |
| inscricoes | categoria_id | INDEX |
| leads | estande_id, participante_id | UNIQUE |
| staff | evento_id, user_id | UNIQUE |
| pagamentos | evento_id | INDEX |

---

## Considerações

### Multi-tenancy
- Implementado via coluna `organizador_id` nas tabelas relacionadas
- Scope global aplicado automaticamente via trait `HasOrganizador`

### Soft Deletes
Aplicar soft delete em:
- Evento
- Expositor
- Estande
- Inscricao

### UUIDs
Todas as tabelas usam UUID como chave primária para:
- Evitar exposição de IDs sequenciais
- Facilitar sincronização futura (offline)
- Maior segurança

### Auditoria
Considerar implementação de audit log para:
- Alterações em Evento
- Alterações de status
- Ações de pagamento
