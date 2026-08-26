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

## Usage

Two triggers the server responds to:

- `with qlaris: <request>` — routes through the Qlaris workflow skills.
- `qlaris knowledge: <question>` — queries the workspace knowledge repository.
