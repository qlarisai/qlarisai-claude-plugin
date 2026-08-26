# Qlaris AI plugin for Claude Code

Connects Claude Code to the hosted Qlaris MCP server at
`https://app.qlaris.ai/api/mcp`. Qlaris runs synthetic market research — surveys,
UX tests, interviews, discovery — on digital-twin panels, and stores claims,
decisions, and personas in a shared workspace.

That server provides all the tools. This plugin ships no commands, agents, or
skills of its own.

## Install

```bash
claude plugin marketplace add qlarisai/qlarisai-claude-plugin
claude plugin install qlaris@qlarisai
```

Restart Claude Code, then run `/mcp` and sign in with your Qlaris account. The
server uses OAuth — there is no API key or environment variable to set.

## Claude Desktop

The plugin format is for Claude Code and Cowork. In the Claude Desktop app the
shortest path to the same server is a custom connector — no files involved:

**Settings → Connectors → Add custom connector**, name `qlaris`, URL
`https://app.qlaris.ai/api/mcp`.

Desktop has no "upload a plugin zip" button, and `.mcpb` desktop extensions
cannot wrap a remote HTTP server (they require a local node/python/binary entry
point), so the connector route is the one that works.

## Packaging a zip

For hosting the plugin as an `archive` source in a `marketplace.json`, or for
dropping it into an organization plugin directory:

```bash
./build.sh    # writes dist/qlaris-<version>.zip and prints its SHA-256
```

The zip holds the plugin at its root, including `.claude-plugin/plugin.json`, as
the archive-source format requires. The printed digest is the `sha256` an archive
entry needs.

## Usage

Two triggers the server responds to:

- `with qlaris: <request>` — routes through the Qlaris workflow skills.
- `qlaris knowledge: <question>` — queries the workspace knowledge repository.
