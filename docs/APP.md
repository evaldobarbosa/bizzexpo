# BizzExpo

**BizzExpo** é uma plataforma SaaS de credenciamento e check-in para feiras de negócios, exposições e eventos corporativos, com foco em geração de dados estratégicos e inteligência comercial.

## Visão Geral

A plataforma transforma o credenciamento tradicional em uma ferramenta de inteligência comercial, conectando organizadores, expositores e participantes de forma integrada.

### Conceito-chave

> "Transformar credenciamento em inteligência comercial"

## Problemas que Resolve

1. Filas e grande espera por atendimento no credenciamento
2. Falta de dados estratégicos do público para pós-vendas
3. Dificuldade de comprovar ROI para patrocinadores e expositores
4. Processos manuais ou em planilhas sem regras de negócios
5. Baixa integração entre organização, expositores e participantes

## Público-alvo

- Organizadores de feiras
- Produtoras de eventos
- Associações empresariais
- Centros de convenções
- Agências de eventos corporativos
- Câmaras de comércio
- Eventos setoriais e industriais
- Eventos religiosos

---

## Perfis de Usuário

| Perfil | Cadastro | Autenticação | Escopo |
|--------|----------|--------------|--------|
| Admin | Por sistema | Email/senha | Plataforma |
| Organizador | Self-service | Email/senha, OAuth2 | Multi-eventos |
| Expositor | Por organizador | Email/senha, OAuth2 | Por evento |
| Participante | Self-service | Email/senha, OAuth2 | Por evento |
| Staff | Por organizador | Email/senha, OAuth2 | Por evento |

### Admin

Usuário administrativo da plataforma (SIM Soluções/Code2). Gerencia aspectos globais do sistema.

**Capacidades:**
- Visualizar todos os eventos da plataforma
- Marcar eventos como pagos (rascunho → pago)
- Visualizar auditoria de alterações
- Gerenciar organizadores

### Organizador

Responsável por criar e gerenciar eventos na plataforma. Pode ter múltiplos eventos simultâneos.

**Campos de cadastro:**
| Campo | Obrigatório |
|-------|-------------|
| Nome | Sim |
| Email | Sim |
| Telefone | Sim |
| Empresa/Razão Social | Sim |
| CNPJ | Sim |
| Cargo | Não |

**Capacidades:**
- Criar e configurar eventos
- Cadastrar expositores e estandes
- Cadastrar staff
- Definir categorias de participantes
- Visualizar dashboard analítico completo
- Realizar pagamento para publicar evento

### Expositor

Empresa que participa do evento com estande(s). Cadastrado pelo organizador.

**Campos de cadastro:**
| Campo | Obrigatório |
|-------|-------------|
| Nome da empresa | Sim |
| CNPJ | Não |
| Nome do contato | Sim |
| Email do contato | Sim |
| Telefone | Sim |
| Site | Não |
| Redes sociais | Não |
| Logo | Não |
| Descrição | Não |

**Capacidades:**
- Acessar dashboard próprio
- Gerenciar dados dos estandes
- Gerar QR Codes dos estandes
- Visualizar leads capturados (nome, email, nível de interesse)

### Participante

Pessoa que se inscreve e participa do evento.

**Campos de cadastro:**
| Campo | Obrigatório |
|-------|-------------|
| Nome completo | Sim |
| Email | Sim |
| Telefone | Sim |
| Empresa | Não |
| Cargo | Não |
| Cidade/UF | Não |

**Capacidades:**
- Inscrever-se em eventos
- Receber QR Code de acesso por email
- Realizar check-in (autoatendimento)
- Escanear QR Codes de estandes (captura de leads)
- Consultar lista de expositores de interesse

### Staff

Equipe de apoio do evento. Cadastrado pelo organizador, vinculado a evento específico.

**Capacidades:**
- Realizar check-in de participantes
- Cadastrar participantes no local (walk-in)
- Buscar participante por nome

---

## Módulos do MVP

### 1. Gestão de Eventos

- Criação de eventos (CRUD)
- Configuração de categorias de participantes
- Controle de datas (início/fim)
- Gestão de múltiplos eventos por organizador
- Landing page pública do evento

**Campos do evento:**
| Campo | Obrigatório |
|-------|-------------|
| Nome | Sim |
| Descrição | Sim |
| Data início | Sim |
| Data fim | Sim |
| Local | Sim |
| Logo | Não |
| Banner | Não |

**Status do evento:**
- Rascunho (criado, não pago)
- Pago (aguardando publicação)
- Publicado (landing page ativa, inscrições abertas)
- Encerrado

### 2. Gestão de Expositores

- CRUD de expositores por evento
- CRUD de estandes por expositor
- Geração de QR Code único por estande
- Expositor pode ter múltiplos estandes no mesmo evento

**Estrutura:**
```
Evento
  └── Expositor (empresa)
        └── Estande 1 (QR Code único)
        └── Estande 2 (QR Code único)
```

### 3. Sistema de Inscrição

- Formulário com campos fixos (sem personalização no MVP)
- Participante cria conta (email/senha ou OAuth2)
- Seleção de categoria de participante
- Confirmação automática por email
- QR Code individual enviado por email

**Categorias de participantes:**
- Configuradas pelo organizador por evento
- Exemplos: Visitante, Comprador, Imprensa, Estudante, VIP
- Usadas para analytics (não alteram funcionalidade)

### 4. Check-in Inteligente

- Leitura de QR Code do participante
- Busca por nome
- Duas modalidades:
  - Autoatendimento (participante escaneia próprio QR Code)
  - Via Staff (staff escaneia QR Code do participante)
- Registro de data/hora do check-in
- Sincronização em tempo real

**Fora do MVP:**
- Funcionamento offline

### 5. Captura de Leads para Expositores

Fluxo invertido: participante escaneia QR Code do estande (não o contrário).

**Fluxo:**
```
1. Expositor gera QR Code do estande no dashboard
2. Expositor exibe QR Code no estande físico
3. Participante abre PWA e escaneia QR Code
4. Sistema exibe tela de consentimento:
   "Deseja compartilhar seu email com [Expositor]?"
   [x] Concordo em compartilhar meu email para contato
5. Participante seleciona nível de interesse
6. Lead registrado para ambos os lados
```

**Níveis de interesse:**
- Quero orçamento
- Sou profissional da área
- Sou entusiasta
- Apenas conhecendo

**Dados compartilhados com expositor:**
- Nome do participante
- Email do participante
- Nível de interesse
- Data/hora do registro

**Dados visíveis para participante:**
- Nome do expositor
- Site
- Redes sociais
- Descrição

**Regras:**
- Consentimento obrigatório (LGPD)
- Se participante escanear mesmo expositor novamente: avisa e ignora duplicata
- Participante pode consultar "Meus interesses" posteriormente

### 6. Dashboard Analítico

**Dashboard do Organizador:**
| Métrica | Descrição |
|---------|-----------|
| Inscritos vs Check-ins | Total e percentual de conversão |
| Categorias de participantes | Distribuição por tipo |
| Leads por expositor | Ranking de interesse gerado |
| Expositores mais visitados | Ranking de scans recebidos |
| Horários de pico | Fluxo de check-ins por hora |

**Dashboard do Expositor:**
| Métrica | Descrição |
|---------|-----------|
| Total de leads | Quantidade de interessados |
| Leads por estande | Distribuição por ponto de contato |
| Leads por nível | Distribuição por interesse |
| Lista de leads | Nome, email, interesse, data/hora |

### 7. Pagamento

Integração com Pagar.me para cobrança do organizador.

**Modelo de cobrança:**
- Baseado em capacidade esperada do evento
- Evento só pode ser publicado após pagamento

**Formas de pagamento:**
- Cartão de crédito
- Cartão de débito
- PIX

**Fluxo:**
```
1. Organizador cria evento (status: rascunho)
2. Configura evento completamente
3. Seleciona faixa de capacidade
4. Realiza pagamento via Pagar.me
5. Evento liberado para publicação
```

---

## Fluxos Principais

### Fluxo do Organizador
```
Cadastro → Cria evento → Configura (categorias, expositores, staff)
→ Paga → Publica → Acompanha dashboard
```

### Fluxo do Participante
```
Acessa landing page → Cria conta → Inscreve-se → Seleciona categoria
→ Recebe QR Code por email → Check-in no evento
→ Escaneia estandes → Consulta "Meus interesses"
```

### Fluxo do Expositor
```
Recebe convite por email → Cria conta → Acessa dashboard
→ Cadastra estandes → Gera QR Codes → Exibe no estande físico
→ Visualiza leads capturados
```

### Fluxo do Staff
```
Recebe convite por email → Cria conta → Acessa app de check-in
→ Realiza check-ins → Cadastra walk-ins
```

---

## Arquitetura Técnica

### Stack
- **Frontend (PWA):** Vue 3 + TypeScript + Tailwind v4 + Pinia + Reka-UI
- **Backend:** Laravel 12 + Breeze (API Sanctum)
- **Banco de dados:** PostgreSQL
- **Pagamentos:** Pagar.me

### Domínios

| Ambiente | Domínio |
|----------|---------|
| Produção | `duevento.com.br` |
| Desenvolvimento | `duevento.code2.dev` |

### Características
- Plataforma Web com painel administrativo
- PWA para check-in e captura de leads
- Infraestrutura em nuvem
- API RESTful
- Multi-tenant (por organizador)

---

## Fora do MVP

Funcionalidades planejadas para versões futuras:

1. **Impressão de credenciais** - Integração com impressoras térmicas
2. **Funcionamento offline** - Service workers, sincronização
3. **Backoffice admin avançado** - Dashboards, relatórios globais, gestão de usuários (base implementada: roles, permissões, marcar pago)
4. **Campos personalizáveis** - Formulários dinâmicos de inscrição
5. **App nativo do evento**
6. **Networking inteligente**
7. **Análise de comportamento do público**
8. **Heatmaps de circulação**
9. **Integração com CRM**
10. **Rede de display/anúncios**

---

## Modelo de Negócio

### Cobrança por Capacidade

O organizador paga com base na capacidade esperada do evento:

| Faixa | Capacidade |
|-------|------------|
| Pequeno | Até 500 participantes |
| Médio | 501 a 1.000 participantes |
| Regional | 1.001 a 5.000 participantes |
| Grande | Acima de 5.000 participantes |

*Valores a definir*

### Estratégia de Entrada

- Foco inicial em organizadores médios
- Eventos de 1.000 a 5.000 participantes
- Segmento com dor clara e orçamento disponível
