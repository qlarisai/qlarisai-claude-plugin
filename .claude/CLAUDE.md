# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Claude Code plugin that registers the hosted Qlaris MCP server on its Claude profile
(`https://app.qlaris.ai/api/mcp/claude`) and ships the `help-with-qlaris` skill. No source and no
runtime: two manifests, the server entry, one skill, docs. Every capability users see (surveys,
user tests, interview studies, focus groups, personas, the research repository) is served by the
remote server. A request that sounds like "add a feature to Qlaris" belongs in the Qlaris backend,
not here.

**The bundle files are generated; do not edit them here.** Their source is the `qlaris-app`
repository: `integrations/claude-plugin/` (plugin.json, marketplace.json, mcp.json, README.md,
LICENSE, assets/icon.png) and the skill text through `scripts/claude-plugin/build-plugin.ts`. From a `qlaris-app`
checkout:

```bash
./node_modules/.bin/tsx scripts/claude-plugin/build-plugin.ts --out <this clone>
./node_modules/.bin/tsx scripts/claude-plugin/validate-plugin.ts --release <this clone>
```

The build replaces exactly the bundle files and keeps this file (`.claude/CLAUDE.md`) and `.gitignore`.
Maintainer files stay out of the repository root: the root is the plugin root, and the directory
portal and `claude plugin validate` read every file there as part of the plugin.

| Path | Role |
| --- | --- |
| `.claude-plugin/plugin.json` | Manifest. `name` must stay `qlaris`: existing installs are `qlaris@qlarisai`. |
| `.claude-plugin/marketplace.json` | Makes the repo self-installable as marketplace `qlarisai` (name must stay). One plugin, source `./`; its description equals `plugin.json`'s. |
| `.mcp.json` | The `qlaris` HTTP server at `/api/mcp/claude`. Auto-discovered at the plugin root, not referenced from `plugin.json`. |
| `skills/help-with-qlaris/SKILL.md` | The "with qlaris" routing skill, rewritten for the Claude profile by the build. |
| `README.md`, `LICENSE` | Public docs (install lines, data disclosure) and MIT. |
| `assets/icon.png` | The 512 px directory icon, named by `plugin.json`'s `icon`. `plugin.json` also carries the four listing URLs (docs, support, privacy, terms) the directory reads. |

## Verify

`validate-plugin.ts --release` (above) runs the bundle checks, `claude plugin validate --strict`
on a copy holding exactly the bundle files, and `claude plugin validate .` here. By hand:

```bash
claude plugin validate .            # marketplace + plugin; expect no warning
```

The repository root is the plugin root (marketplace source `./`). This file lives in `.claude/`, so
the validator's "CLAUDE.md at the plugin root is not loaded" warning does not fire; any warning is
a real finding.

Validation never dials the server; confirm connection changes by installing and running `/mcp`.

## Release order

Push only after `/api/mcp/claude` answers on prod: an installed plugin updates to whatever `main`
holds. Existing users move from `/api/mcp` to `/api/mcp/claude` with the update and sign in once
more through `/mcp`. After committing, write the release zip from the committed tree (`dist/` is not
committed):

```bash
v=$(sed -n 's/.*"version": "\(.*\)".*/\1/p' .claude-plugin/plugin.json)
mkdir -p dist && git archive --format=zip -o "dist/qlaris-$v.zip" HEAD && shasum -a 256 "dist/qlaris-$v.zip"
```

## MCP constraints

- OAuth-authenticated. Never add an `Authorization` header or `${TOKEN}`
  placeholder to `.mcp.json` — users authenticate via `/mcp` after install.
- `type` is `http` (streamable HTTP), not `sse` or `stdio`.
- The server key `qlaris` becomes part of every tool name (`mcp__qlaris__*`).
  Renaming it breaks saved permission rules and any prompt naming a tool.
