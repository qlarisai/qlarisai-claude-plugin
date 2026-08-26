# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Claude Code plugin that does one thing: register the hosted Qlaris MCP server
(`https://app.qlaris.ai/api/mcp`). No source, no build, no runtime — three JSON
manifests plus docs. Every capability users see (surveys, user tests, interviews,
claims, decisions, personas) is served by the remote server. A request that sounds
like "add a feature to Qlaris" belongs in the Qlaris backend, not here.

| Path | Role |
| --- | --- |
| `.claude-plugin/plugin.json` | Manifest. `name` must stay `qlaris`. |
| `.mcp.json` | The payload: the `qlaris` HTTP server. Auto-discovered at the plugin root, not referenced from `plugin.json`. |
| `.claude-plugin/marketplace.json` | Makes the repo self-installable as marketplace `qlarisai`. Its name/description must match `plugin.json`. |

## Verify

```bash
claude plugin validate .claude-plugin/plugin.json   # plugin; warns, see below
claude plugin validate . --strict                   # marketplace; must be clean
```

The plugin check emits one known warning: `CLAUDE.md` at the plugin root is not
loaded as plugin context. Expected, not a defect — this file is for maintainers
of this repo, and the repo root happens to equal the plugin root. It exits 0, but
`--strict` turns it into a failure, so don't add `--strict` to that command.
Any *other* warning is a real finding.

Validation never dials the server; confirm connection changes by installing and
running `/mcp`.

## MCP constraints

- OAuth-authenticated. Never add an `Authorization` header or `${TOKEN}`
  placeholder to `.mcp.json` — users authenticate via `/mcp` after install.
- `type` is `http` (streamable HTTP), not `sse` or `stdio`.
- The server key `qlaris` becomes part of every tool name (`mcp__qlaris__*`).
  Renaming it breaks saved permission rules and any prompt naming a tool.
