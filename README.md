# AIMochi MCP Server

[AIMochi](https://www.aimochi.ai/) turns voice messages and meeting recordings sent on LINE into transcripts, speaker-labelled notes and AI summaries. The **AIMochi MCP server** lets MCP clients such as Claude Code and Cursor list, search and read those notes directly, so your AI tool can use meeting, interview and lecture notes without you copying and pasting the transcript.

- **Endpoint:** `https://api.aimochi.ai/mcp`
- **Transport:** Streamable HTTP
- **Auth:** personal access token in an `Authorization: Bearer <token>` header (no OAuth)
- **Access:** read-only
- **Official MCP Registry name:** `ai.aimochi/notes`
- **Plans:** available on the free plan too (3,000 free points a month, about 300 minutes of transcription)

[繁體中文](#繁體中文) · [日本語](#日本語) · Full guide: [AIMochi MCP setup (English)](https://www.aimochi.ai/blog_detail/20261107-en/)

## Tools

| Tool | What it does |
|---|---|
| `list_notes` | Lists your notes |
| `search_notes` | Searches your notes by keyword |
| `get_note` | Reads the content of a specific note |

All three tools are read-only. An MCP client cannot create, edit or delete notes.

## Setup

1. Sign in at <https://app.aimochi.ai/settings> on a computer and open **AI Tool Connections (MCP)** (「AI 工具連線（MCP）」 in the Chinese interface). Click **+** to create a personal access token.
2. Copy the token right away. It is shown only once; if you lose it, revoke it and create a new one.
3. Add the endpoint and token to your client.

### Claude Code

```bash
claude mcp add --transport http aimochi https://api.aimochi.ai/mcp --header "Authorization: Bearer <token>"
```

Run `/mcp` inside Claude Code to check the connection. The default local scope stores the token in your own `~/.claude.json`; add `--scope user` to use it in every project. Avoid `--scope project`, which writes the token to `.mcp.json` in the project root where it can be committed to Git. See the [Claude Code MCP docs](https://code.claude.com/docs/en/mcp).

### Cursor

Put this in the user-level `~/.cursor/mcp.json` (not a project folder that is committed to Git), then restart Cursor. See [`examples/cursor-mcp.json`](examples/cursor-mcp.json) and the [Cursor MCP docs](https://cursor.com/docs/mcp).

```json
{
  "mcpServers": {
    "aimochi": {
      "url": "https://api.aimochi.ai/mcp",
      "headers": {
        "Authorization": "Bearer <token>"
      }
    }
  }
}
```

### Other MCP clients

Any client that can connect to a remote MCP server over Streamable HTTP and send a custom `Authorization` header should, in principle, work with the same endpoint and token.

## What you can do with it

- Turn decisions from a recorded requirements meeting into a spec or a feature list.
- Have your coding agent check what was agreed in a product meeting before it implements a feature.
- Read several interview transcripts at once and pull out recurring pain points and quotes.
- Draft an article outline, slides or study notes from a recorded talk or class.

AIMochi detects the language automatically (more than 99 languages, including mixed Chinese–English and Chinese–Japanese recordings), tells apart up to 10 speakers, and returns a one-hour recording in about 10 minutes.

## Token safety

- Treat the token like a password: anyone who has it can read all of your notes. Never paste it into chats or screenshots, and never commit it.
- Create one named token per tool; the settings page shows when each token was last used.
- Revoking a token takes effect immediately. There is a limit on active tokens, so revoke the ones you no longer use.
- Once an AI tool reads a note, the content is handled by that tool and its model provider. Check your organisation's rules for confidential meetings.
- AIMochi does not use your recordings, transcripts or notes to train AI models.

---

## 繁體中文

AIMochi 是在 LINE 上使用的 AI 語音轉文字與會議筆記助理。AIMochi MCP 伺服器讓 Claude Code、Cursor 等 MCP 用戶端直接列出、搜尋、讀取你的 AIMochi 筆記（唯讀）。

- 端點：`https://api.aimochi.ai/mcp`（Streamable HTTP），用個人存取權杖（`Authorization: Bearer <token>`）驗證
- 工具：`list_notes`、`search_notes`、`get_note`，都是唯讀
- 免費版也能用
- 設定：到 <https://app.aimochi.ai/settings> 的「AI 工具連線（MCP）」建立權杖（只顯示一次），再照上面的 Claude Code 指令或 Cursor 設定加入
- 完整教學：[AIMochi 支援 MCP（設定教學）](https://www.aimochi.ai/blog_detail/20261107/)｜[MCP 是什麼？](https://www.aimochi.ai/blog_detail/20261107-2/)

## 日本語

AIMochiは、LINEで使えるAI文字起こし・議事録アシスタントです。AIMochi MCPサーバーを使うと、Claude CodeやCursorなどのMCPクライアントから、AIMochiのノートを一覧・検索・読み取りできます（読み取り専用）。

- エンドポイント：`https://api.aimochi.ai/mcp`（Streamable HTTP）、個人アクセストークン（`Authorization: Bearer <token>`）で認証
- ツール：`list_notes`、`search_notes`、`get_note`（すべて読み取り専用）
- 無料プランでも利用できます
- 設定：<https://app.aimochi.ai/settings> でトークンを作成し（表示は1回のみ）、上記のClaude CodeコマンドまたはCursorの設定に追加します

## Links

- Website: <https://www.aimochi.ai/>
- Add AIMochi on LINE: <https://page.line.me/aimochi>
- Web app: <https://app.aimochi.ai/>
- Developer: [LargitData](https://www.largitdata.com/)

This repository contains documentation and configuration examples only. The MCP server itself is operated by LargitData.
