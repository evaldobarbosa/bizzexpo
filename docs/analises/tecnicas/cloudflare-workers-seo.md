# Cloudflare Workers para SEO

> **Relacionado a:** US-6.5 (Cloudflare Workers para SEO)
> **Sprint:** 04
> **Criado em:** 2026-03-16
> **Status:** Planejado

## Contexto

SPAs (Single Page Applications) como Vue.js apresentam desafios para SEO e compartilhamento em redes sociais:

- Crawlers do Google, Facebook, Twitter e LinkedIn nem sempre executam JavaScript
- Meta tags dinamicas nao sao renderizadas no HTML inicial
- Compartilhamentos em redes sociais mostram informacoes genericas

## Solucao

Utilizar Cloudflare Workers para interceptar requisicoes de crawlers e injetar meta tags dinamicas no HTML antes de servir a pagina.

## Arquitetura

### Fluxo de Requisicao

```
┌─────────────────┐
│    Visitante    │
│   ou Crawler    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Cloudflare    │
│      Edge       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐     ┌─────────────────┐
│    Worker       │────▶│  Detectar       │
│  /evento/*      │     │  User-Agent     │
└────────┬────────┘     └────────┬────────┘
         │                       │
         │         ┌─────────────┴─────────────┐
         │         │                           │
         │   ┌─────▼─────┐               ┌─────▼─────┐
         │   │  Crawler  │               │  Humano   │
         │   │   (Bot)   │               │ (Browser) │
         │   └─────┬─────┘               └─────┬─────┘
         │         │                           │
         │   ┌─────▼──────────┐          ┌─────▼─────┐
         │   │ Fetch API      │          │ Passthru  │
         │   │ /api/evento/   │          │ Origin    │
         │   │ {slug}         │          │ (Vue SPA) │
         │   └─────┬──────────┘          └───────────┘
         │         │
         │   ┌─────▼──────────┐
         │   │ Fetch Origin   │
         │   │ HTML (SPA)     │
         │   └─────┬──────────┘
         │         │
         │   ┌─────▼──────────┐
         │   │ Injetar <head> │
         │   │ com meta tags  │
         │   └─────┬──────────┘
         │         │
         │   ┌─────▼──────────┐
         │   │ Return HTML    │
         │   │ modificado     │
         └───┴────────────────┘
```

### Diagrama de Sequencia

```
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│ Crawler  │     │  Worker  │     │   API    │     │  Origin  │
└────┬─────┘     └────┬─────┘     └────┬─────┘     └────┬─────┘
     │                │                │                │
     │ GET /evento/   │                │                │
     │ tech-summit    │                │                │
     │───────────────▶│                │                │
     │                │                │                │
     │                │ GET /api/evento│                │
     │                │ /tech-summit   │                │
     │                │───────────────▶│                │
     │                │                │                │
     │                │ {nome, desc,   │                │
     │                │  banner, ...}  │                │
     │                │◀───────────────│                │
     │                │                │                │
     │                │ GET /evento/   │                │
     │                │ tech-summit    │                │
     │                │───────────────────────────────▶│
     │                │                │                │
     │                │ HTML (index.html)              │
     │                │◀───────────────────────────────│
     │                │                │                │
     │                │ Substituir     │                │
     │                │ <head> com     │                │
     │                │ meta tags      │                │
     │                │                │                │
     │ HTML com       │                │                │
     │ meta tags      │                │                │
     │◀───────────────│                │                │
     │                │                │                │
```

## Deteccao de Crawlers

### User-Agents Identificados

```typescript
const CRAWLER_USER_AGENTS = [
  // Google
  'googlebot',
  'google-inspectiontool',
  'googleweblight',

  // Facebook
  'facebookexternalhit',
  'facebookcatalog',

  // Twitter
  'twitterbot',

  // LinkedIn
  'linkedinbot',

  // WhatsApp
  'whatsapp',

  // Telegram
  'telegrambot',

  // Discord
  'discordbot',

  // Slack
  'slackbot',

  // Outros
  'bingbot',
  'yandexbot',
  'duckduckbot',
  'baiduspider',
  'applebot',
];
```

### Funcao de Deteccao

```typescript
function isCrawler(userAgent: string): boolean {
  const ua = userAgent.toLowerCase();
  return CRAWLER_USER_AGENTS.some(crawler => ua.includes(crawler));
}
```

## Meta Tags Injetadas

### Template HTML

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- SEO Basico -->
  <title>{{evento.nome}} | duevento</title>
  <meta name="description" content="{{evento.descricao_curta}}">
  <link rel="canonical" href="{{url}}">

  <!-- Open Graph (Facebook, LinkedIn, WhatsApp) -->
  <meta property="og:type" content="website">
  <meta property="og:title" content="{{evento.nome}}">
  <meta property="og:description" content="{{evento.descricao_curta}}">
  <meta property="og:image" content="{{evento.banner}}">
  <meta property="og:image:width" content="1200">
  <meta property="og:image:height" content="630">
  <meta property="og:url" content="{{url}}">
  <meta property="og:site_name" content="duevento">
  <meta property="og:locale" content="pt_BR">

  <!-- Twitter Cards -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:site" content="@duevento">
  <meta name="twitter:title" content="{{evento.nome}}">
  <meta name="twitter:description" content="{{evento.descricao_curta}}">
  <meta name="twitter:image" content="{{evento.banner}}">

  <!-- Evento (Schema.org JSON-LD) -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "Event",
    "name": "{{evento.nome}}",
    "description": "{{evento.descricao}}",
    "startDate": "{{evento.data_inicio}}",
    "endDate": "{{evento.data_fim}}",
    "location": {
      "@type": "Place",
      "name": "{{evento.local}}"
    },
    "image": "{{evento.banner}}",
    "organizer": {
      "@type": "Organization",
      "name": "duevento"
    }
  }
  </script>
</head>
<body>
  <!-- Conteudo da SPA sera carregado aqui -->
  <div id="app"></div>
</body>
</html>
```

## Estrutura do Projeto

```
cloudflare-workers/
├── wrangler.toml              # Configuracao Wrangler
├── package.json               # Dependencias
├── tsconfig.json              # TypeScript config
├── src/
│   ├── index.ts               # Entry point do Worker
│   ├── handlers/
│   │   ├── evento.ts          # Handler para /evento/*
│   │   └── types.ts           # Tipos de resposta da API
│   ├── utils/
│   │   ├── crawler.ts         # Deteccao de bots
│   │   ├── meta-tags.ts       # Geracao de meta tags
│   │   └── html-rewriter.ts   # Manipulacao de HTML
│   └── templates/
│       └── head.html          # Template do <head>
└── tests/
    ├── crawler.test.ts        # Testes de deteccao
    └── meta-tags.test.ts      # Testes de geracao
```

## Configuracao Wrangler

```toml
# wrangler.toml
name = "duevento-seo"
main = "src/index.ts"
compatibility_date = "2024-01-01"

[env.production]
routes = [
  { pattern = "duevento.com/evento/*", zone_name = "duevento.com" }
]

[env.staging]
routes = [
  { pattern = "staging.duevento.com/evento/*", zone_name = "duevento.com" }
]

# KV para cache (opcional)
[[kv_namespaces]]
binding = "EVENTO_CACHE"
id = "xxx"
preview_id = "yyy"

[vars]
API_BASE_URL = "https://api.duevento.com"
```

## Codigo do Worker

### Entry Point (index.ts)

```typescript
import { handleEventoRequest } from './handlers/evento';
import { isCrawler } from './utils/crawler';

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    const userAgent = request.headers.get('user-agent') || '';

    // Apenas processar rotas de evento
    if (!url.pathname.startsWith('/evento/')) {
      return fetch(request);
    }

    // Se nao for crawler, passar direto para origin
    if (!isCrawler(userAgent)) {
      return fetch(request);
    }

    // Processar para crawlers
    return handleEventoRequest(request, env);
  }
};
```

### Handler de Evento (handlers/evento.ts)

```typescript
import { generateMetaTags } from '../utils/meta-tags';

interface Evento {
  id: string;
  nome: string;
  slug: string;
  descricao: string;
  data_inicio: string;
  data_fim: string;
  local: string;
  banner?: string;
}

export async function handleEventoRequest(
  request: Request,
  env: Env
): Promise<Response> {
  const url = new URL(request.url);
  const slug = url.pathname.replace('/evento/', '');

  try {
    // 1. Buscar dados do evento na API
    const evento = await fetchEvento(slug, env);
    if (!evento) {
      return fetch(request); // Fallback para origin
    }

    // 2. Buscar HTML original
    const originResponse = await fetch(request);
    const html = await originResponse.text();

    // 3. Injetar meta tags
    const modifiedHtml = injectMetaTags(html, evento, url.href);

    return new Response(modifiedHtml, {
      headers: {
        'content-type': 'text/html;charset=UTF-8',
        'cache-control': 'public, max-age=3600',
      },
    });
  } catch (error) {
    console.error('Worker error:', error);
    return fetch(request); // Fallback para origin
  }
}

async function fetchEvento(slug: string, env: Env): Promise<Evento | null> {
  // Tentar cache primeiro
  const cached = await env.EVENTO_CACHE?.get(slug);
  if (cached) {
    return JSON.parse(cached);
  }

  // Buscar na API
  const response = await fetch(`${env.API_BASE_URL}/api/evento/${slug}`);
  if (!response.ok) {
    return null;
  }

  const data = await response.json();
  const evento = data.data;

  // Cachear por 1 hora
  await env.EVENTO_CACHE?.put(slug, JSON.stringify(evento), {
    expirationTtl: 3600,
  });

  return evento;
}

function injectMetaTags(html: string, evento: Evento, url: string): string {
  const metaTags = generateMetaTags(evento, url);

  // Substituir <head> existente
  return html.replace(
    /<head>[\s\S]*?<\/head>/i,
    `<head>${metaTags}</head>`
  );
}
```

## Cache Strategy

### Niveis de Cache

1. **Cloudflare KV** (Worker): Cache de dados do evento (1h TTL)
2. **Cloudflare CDN**: Cache do HTML modificado (1h TTL)
3. **Browser**: Cache do cliente (respeitando headers)

### Invalidacao

- Atualizar evento na API invalida cache KV via webhook
- Purge de CDN via API Cloudflare quando necessario

## Testes e Validacao

### Ferramentas de Debug

| Ferramenta | URL | Uso |
|------------|-----|-----|
| Facebook Debugger | https://developers.facebook.com/tools/debug/ | Validar Open Graph |
| Twitter Card Validator | https://cards-dev.twitter.com/validator | Validar Twitter Cards |
| LinkedIn Inspector | https://www.linkedin.com/post-inspector/ | Validar LinkedIn |
| Google Rich Results | https://search.google.com/test/rich-results | Validar Schema.org |
| Metatags.io | https://metatags.io/ | Preview geral |

### Testes Automatizados

```typescript
// tests/crawler.test.ts
import { isCrawler } from '../src/utils/crawler';

describe('Crawler Detection', () => {
  it('should detect Googlebot', () => {
    expect(isCrawler('Googlebot/2.1')).toBe(true);
  });

  it('should detect Facebook crawler', () => {
    expect(isCrawler('facebookexternalhit/1.1')).toBe(true);
  });

  it('should not detect regular browser', () => {
    expect(isCrawler('Mozilla/5.0 (Windows NT 10.0; Win64; x64)')).toBe(false);
  });
});
```

## Deploy

### CI/CD via GitHub Actions

```yaml
# .github/workflows/deploy-worker.yml
name: Deploy Cloudflare Worker

on:
  push:
    branches: [main]
    paths:
      - 'cloudflare-workers/**'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install dependencies
        run: cd cloudflare-workers && npm ci

      - name: Run tests
        run: cd cloudflare-workers && npm test

      - name: Deploy to Cloudflare
        uses: cloudflare/wrangler-action@v3
        with:
          apiToken: ${{ secrets.CF_API_TOKEN }}
          workingDirectory: cloudflare-workers
```

## Recursos

- [Cloudflare Workers Documentation](https://developers.cloudflare.com/workers/)
- [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/)
- [Open Graph Protocol](https://ogp.me/)
- [Twitter Cards](https://developer.twitter.com/en/docs/twitter-for-websites/cards/overview/abouts-cards)
- [Schema.org Event](https://schema.org/Event)

---

**Ultima atualizacao:** 2026-03-16
