#!/bin/sh
# Add the AIMochi MCP server to Claude Code (local scope).
# Create a token at https://app.aimochi.ai/settings first, then:
#   AIMOCHI_TOKEN=<token> sh claude-code.sh
claude mcp add --transport http aimochi https://api.aimochi.ai/mcp \
  --header "Authorization: Bearer ${AIMOCHI_TOKEN:?set AIMOCHI_TOKEN first}"
