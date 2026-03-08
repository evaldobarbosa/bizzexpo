# Milestones - Grapo

Marcos do projeto que agrupam funcionalidades relacionadas.

**Convencao:** Milestones sao reativos - novos marcos podem ser inseridos antes de outros na fila conforme necessidade do negocio.

---

## Indice de Milestones

| ID | Nome | Status | Sprints | Versao Docs |
|----|------|--------|---------|-------------|
| M0 | Landing Page | Concluido | Sprint 01 | v0.1.0 |

---

## M0 - Landing Page

**Status:** Concluido
**Versao:** v0.1.0
**Tag Git:** `docs-v0.1.0` (a criar)

### Escopo
- Landing page institucional do Grapo
- Apresentacao do produto e planos

### Funcionalidades
- [x] Landing Page (`docs/analises/features/landing-page.md`)

### Modelo de Dados
- Nenhuma entidade de negocio (apenas frontend)

### Artefatos
- Sprint: `docs/sprints/sprint-01.md`
- Modelo arquivado: `docs/analises/arquivo/modelo-dados.m0.md`

---

...

---

## Regras de Versionamento

### Documentacao
- Ao iniciar um milestone, criar tag git: `docs-vX.Y.Z`
- Ao concluir, arquivar modelo de dados: `arquivo/modelo-dados.mN.md`
- Atualizar CHANGELOG.md com alteracoes

### Codigo
- Tags de release seguem semver: `vX.Y.Z`
- Cada milestone pode ter multiplas releases

### Convencoes de Versao
- **Major (X):** Mudancas estruturais no modelo de dados
- **Minor (Y):** Novas entidades ou funcionalidades
- **Patch (Z):** Correcoes e ajustes

---

**Ultima atualizacao:** 2025-02-14
