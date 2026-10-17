---
name: help-with-qlaris
description: The qlaris command menu and router. Use when the user writes "with qlaris" (with or without a colon or a goal) or asks how to do something with qlaris — creating personas, running surveys, user tests, interview studies or focus groups, and reading results.
---

# With qlaris

## Behavior — how to handle a request

- **`with qlaris: <a goal>`** → do it. For research, pick the audience, run the study, and deliver
  the findings — asking first when the goal is large or unclear. Use any detail the user added
  (audience, sub-questions, approach, exact output); leave the rest open and decide sensibly.
- **`with qlaris: how do I …`** → explain and point to the right tool or skill — run nothing.
- **`with qlaris:`** (nothing after) → print the **Cheat sheet** below **verbatim**.

Match the user's language, check cost with a `dryRun` before anything large, and only report results
once they are final. For "how do I" questions, don't execute write/action tools; read-only `list_*` /
`get_*` are always fine.

---

## Cheat sheet (print verbatim for a blank `with qlaris:`)

**CHEAT SHEET · COMMANDS**

# with qlaris

Everything starts with **`with qlaris:`** — say what you want and qlaris does it, or points you to
the right skill. Add as much or as little detail as you like: audience, sub-questions, approach,
exact output. Leave things out and qlaris fills the gaps sensibly or asks first.

### the basics — Three ways to ask
| say | what happens |
|---|---|
| `with qlaris: <research goal and specifications>` | qlaris does it. For research it picks the audience, runs the study and delivers the findings — asking first when the goal is large or unclear. You can also add any detail about the audience, research or similar, or leave it open and let qlaris decide. |
| `with qlaris: how do I …` | qlaris explains and points to the right tool or skill — nothing is run. |
| `with qlaris:` | Shows this cheat sheet. |

qlaris matches your language, checks cost with a dry run before anything large, and only reports
results once they are final.

### personas — Build and reuse audiences
| say | what happens |
|---|---|
| `with qlaris: create a persona <description>` | Build a research persona from a short description. |
| `with qlaris: list my personas` | Show existing personas to reuse. |

### research — Say your question, qlaris handles the rest
| say | what happens |
|---|---|
| `with qlaris: <your research question>` | qlaris chooses the audience, runs the study and compiles the findings. |
| `with qlaris: run a survey <survey specifications>` | Quantitative survey on a digital-twin panel. |
| `with qlaris: run a UX test <UX test specifications>` | Twins navigate a URL and report their experience. |
| `with qlaris: run an interview <interview specifications>` | One-to-one interview study: a decision, 2–5 research questions, a discussion guide, one audience (or up to five to compare), 3–50 interviews and a report. Free draft first; you approve before anything is paid. |

Want control? State any preference as text — audience, specific personas, exact questions, method,
sample size — and it is used instead of chosen for you.

Two ways to phrase the same command:
- **Quick:** "with qlaris: Find out if Americans prefer chocolate or vanilla ice cream when going to the cinema."
- **Steered:** "with qlaris: Should a new US cinema chain mainly sell ice cream, and which flavor? Focus on the western USA, under 45. Detailed report, qualitative through quantitative. Ask clarifying questions first."

### tips — Getting good results
- Say the decision, not just a topic. "Should we charge for X?" beats "ask about pricing".
- Be as specific or as hands-off as you like. Name the audience and questions, or leave them to qlaris.
- Personas read best as short narratives. Don't over-define — open traits keep the panel real.

---

## Under the hood (for routing)

- **Personas:** `create_persona({ country, description, directPrompt })` (pass the narrative to both
  `description` and `directPrompt`); reuse via `list_personas` / `get_persona`.
- **Survey:** `run_survey` — target via `personaId` / `filters` / `segmentSlug` / `groups`; question
  types via `list_question_types`; `dryRun` for cost; poll `get_survey_status` → `get_survey_results`.
- **UX test:** `run_user_test` (needs `url` + `task`; host a design first with `serve_prototype`);
  poll `get_user_test_status` → `get_user_test_results`.
- **Interview (1:1 study):** `draft_interview_study` (FREE — ask the decision; omit `researchQuestions`
  and `guide` and qlaris proposes and drafts them; confirm the audience; show `proposals`, `coverage`,
  `validity`, `costBar`; put `questionsForUser[]` to the user; follow `nextSteps[]`; apply edits to
  `draft.study`; follow `draft.procedure`) → `run_interview_study` with `{ study: draft.study, requestId }`
  (`study.pilot: true` when the sample is ≥ 6 and the user wants to read three first) → poll
  `get_interview_study` at `suggestedPollIntervalSeconds` → `report.markdown` rendered as written,
  every finding with its validity label. Transcripts: `get_interview_study` with a `participantId`.
  Cancel / regenerate / launch the remainder: `manage_interview_study` with an `action`.
- **Rule:** for "how do I …" questions, explain and point — don't run write/action tools. For a
  stated research goal, run it. Read-only `list_*` / `get_*` are always fine.
