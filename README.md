# Qlaris for Claude

Qlaris runs synthetic market research on digital-twin panels for the US and 39 European countries. This plugin connects Claude to your Qlaris account, so you can draft, run and read surveys, 1:1 interview studies, focus groups and user tests of a website or prototype, and ask questions of your team's research repository, without leaving the conversation.

## Install

In Claude Code, add the `qlarisai` marketplace and install the plugin:

```
/plugin marketplace add qlarisai/qlarisai-claude-plugin
/plugin install qlaris@qlarisai
```

Or from a terminal:

```bash
claude plugin marketplace add qlarisai/qlarisai-claude-plugin
claude plugin install qlaris@qlarisai
```

Restart Claude Code, run `/mcp` and sign in with your Qlaris account. The connector uses OAuth: there is no API key or environment variable to set.

**Updating from an earlier version.** Version 1.0.0 moves the plugin to the Claude connector at `https://app.qlaris.ai/api/mcp/claude` and adds the `help-with-qlaris` skill. Update with `claude plugin marketplace update qlarisai` and `claude plugin update qlaris@qlarisai` (or `/plugin`), restart Claude Code, and sign in once more through `/mcp`.

In claude.ai or the Claude desktop app, add Qlaris from the connector directory, or as a custom connector with the URL `https://app.qlaris.ai/api/mcp/claude`. Setup guide: https://qlaris.ai/docs/claude

## What the plugin contains

- **The Qlaris connector**: an MCP server at `https://app.qlaris.ai/api/mcp/claude`. You sign in with your Qlaris account the first time Claude uses it (OAuth). Studies spend validation units your Qlaris account already holds; nothing can be bought through Claude.
- **The `help-with-qlaris` skill**: say `with qlaris:` followed by what you want ("with qlaris: run a survey on …", "with qlaris: how do I test a prototype?"), or `with qlaris:` on its own for the command menu.

## What is sent to Qlaris

When Claude uses a Qlaris tool, the tool's arguments are sent to `https://app.qlaris.ai/api/mcp/claude` and stored in your Qlaris account: your questions, study content (survey questions, discussion guides, tasks), audience criteria and personas, the URLs you ask Qlaris to test or capture, and the files you upload (prototypes, research documents). Qlaris uses them to run the studies you ask for and shows the results in your account. Nothing else from your conversation is sent.

- Privacy policy: https://qlaris.ai/privacy
- Connector documentation: https://qlaris.ai/docs/claude
- Terms: https://qlaris.ai/terms
- Support: https://qlaris.ai/contact

## Respondents are synthetic

Qlaris's panel members are digital twins: AI respondents generated from aggregate population statistics. No real person answers, and qlaris studies are labelled as synthetic evidence, not human research. A free validity check rates how far each question or finished study can be trusted.

## Packaging a zip

For hosting the plugin as an `archive` source in a marketplace, or for an organization plugin directory, `./build.sh` writes `dist/qlaris-<version>.zip` from the committed files and prints its SHA-256.

## License

MIT. See `LICENSE`.
