# Auto-commit

A minimal GitHub Actions workflow that automatically generates and pushes commit entries **4 times a day** (every 6 hours) into a lightweight, append-only activity log in your repository — instead of silently overwriting a single timestamp file.

## How it's different from a plain "green square" bot

- **Append, don't overwrite.** Every run adds one new line to `COMMIT_LOG.md`
  instead of rewriting the same file in place. Over time this becomes a
  readable diary of activity rather than a meaningless timestamp diff.
- **Deterministic rotation, not pure randomness.** The dev-note shown on eachrun is selected by a
  running commit counter (`.commit-state`), so the sequence is reproducible and easy to reason about or extend.
- **No emoji-roulette commit messages.** Commit messages are plain and
  descriptive (`commit: entry for YYYY-MM-DD`).
- **Skips empty commits.** If nothing changed, the workflow exits quietly
  instead of forcing a commit.
- **Automated Schedule.** Configured to run automatically **4 times a day** (every 6 hours via cron `0 */6 * * *`) using the official `github-actions[bot]` identity.

## Setup

1. Use this repository as a template, or copy `.github/workflows/commit.yml`
   and `scripts/generate-entry.sh` into your own repo.
2. In your repo, go to **Settings → Actions → General → Workflow permissions**
   and select **Read and write permissions**.
3. Make sure the branch name in `commit.yml` matches your repository's
   **default branch**. For example, use `main` if `main` is your default branch.
   This repository uses `0xbabyalien` as its default branch.
4. The schedule in `commit.yml` is preset to run **4 times a day** (`0 */6 * * *`), but you can adjust it to whatever cadence you want using [crontab.guru](https://crontab.guru/) for syntax help.
5. Optionally edit the `NOTES` array in `scripts/generate-entry.sh` to write
   your own rotating notes instead of the defaults.
6. Push to your default branch or trigger the workflow manually from the
   Actions tab to see the first entry appear in `COMMIT_LOG.md`.


## Files
| File | Purpose |
|---|---|
| `.github/workflows/commit.yml` | Workflow definition: trigger, schedule (4x daily), checkout, run script, and push using the official bot. |
| `scripts/generate-entry.sh` | Generates one log entry and updates the day counter. |
| `COMMIT_LOG.md` | The growing activity log itself. |
| `.commit-state` | Internal commit/execution counter (tracks total successful runs). |

<pre>
auto-commit-root/
├── .github/
│   └── workflows/
│       └── commit.yml      ← GitHub Actions workflow for automated commits (4x daily)
├── scripts/
│   └── generate-entry.sh   ← Script that generates content for each automated commit
├── .gitignore              ← Specifies files and directories ignored by Git
├── .commit-state           ← Stores the automation's current state
├── LICENSE                 ← Defines the project's usage and distribution terms
├── COMMIT_LOG.md           ← Records the history of automated activities
└── README.md               ← Project documentation and usage instructions
</pre>

## License

[![License: MIT](https://img.shields.io/badge/License-MIT-ffff00.svg?labelColor=2E7D32&color=%23AD1457&style=for-the-badge)](./LICENSE)
