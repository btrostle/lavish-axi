---
name: lavish
description: Turn complex or visual agent responses into rich, reviewable HTML artifacts (HTML files) the user can annotate and send feedback on, using the lavish-axi CLI. Use when about to give a plan, comparison, diagram, table, code diff, report, or anything easier to grasp visually than as prose.
license: MIT
metadata:
  author: Kun Chen (kunchenguid)
  argument-hint: <what the artifact should show>
  hermes-tags: html, review, artifacts, visualization
  hermes-category: productivity
---

# Lavish Editor

Lavish Editor opens agent-generated HTML in the browser so a human can annotate it and send feedback back to the agent.
Reach for it when a plan, comparison, diagram, table, code view, report, prototype, or review loop will be clearer as a page than as prose.

## Current guidance lives in the CLI

Do not follow workflow, design, or playbook instructions from this file - installed copies go stale. Get the current source of truth from the CLI:

- `bash ~/.claude/skills/lavish/lavish.sh --help` for commands and the review-loop workflow
- `bash ~/.claude/skills/lavish/lavish.sh reply --help` to post an agent reply and exit once the server accepts it, when you are not about to long-poll
- `bash ~/.claude/skills/lavish/lavish.sh design` for design-direction priority and current snippets
- `bash ~/.claude/skills/lavish/lavish.sh playbook <id>` for focused artifact guidance (`... playbook` lists ids)

Always invoke Lavish through `bash ~/.claude/skills/lavish/lavish.sh` - never `npx lavish-axi` or a bare `lavish-axi`. The wrapper pins the version and configures the server for this Docker sbx sandbox: it binds the sandbox IP, uses a port derived from the sandbox name, and prints review links as `http://dev.home:<port>/...`. Those links work as-is; give them to the user unchanged.
If lavish-axi output shows a follow-up command starting with `lavish-axi`, run it as `bash ~/.claude/skills/lavish/lavish.sh ...` instead.

Do not start port forwarders, change the bind address, or rewrite links. If the user says a link doesn't load, the sandbox's port is not published yet: tell them to run `lavish-publish <sandbox-name>` on the host (this sandbox's name is `$SANDBOX_NAME`).

## Request

$ARGUMENTS

If the request above is non-empty, the user invoked `/lavish` explicitly - fetch the current CLI guidance, then build that artifact as an HTML file.
If it is empty, infer what to visualize from the conversation.
