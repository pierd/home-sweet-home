# AGENTS.md

Context for AI agents working on this repo. Read this before touching anything.

## What this is

Kuba's personal home-directory config and scripts (dotfiles), for macOS (Apple
Silicon, Homebrew in `/opt/homebrew`) with zsh + oh-my-zsh. Remote:
`git@github.com:pierd/home-sweet-home.git`, branch `master`.

## How the repo is wired (important)

This is **not** a normal checkout. The git dir lives in `~/.home-sweet-home/.git`
but the work tree is the home directory itself:

- `core.worktree = /Users/kuba` (set in `.git/config`)
- `.git/info/exclude` contains `*`, so **every file in `~` is ignored by
  default**. Only files explicitly added are tracked.
- `init.sh` (sourced from `.zshrc`) defines the `home` alias:
  `git --work-tree=$HOME --git-dir=$HOME_SWEET_HOME/.git`.

Consequences:

- Edit the **real files in `~`** (e.g. `~/.zshrc`, `~/bin/funssh`), never copies
  under `~/.home-sweet-home/`.
- The only files inside `~/.home-sweet-home/` are this repo's meta files:
  `README.md`, `LICENSE`, `init.sh`, `AGENTS.md`, `CLAUDE.md` (tracked as
  `.home-sweet-home/<name>`). Don't put copies of dotfiles there.
- Because of the `*` exclude, plain `git add <path>` fails even for files that
  are already tracked. Use `git add -u <path>` (or `git commit -a`) to stage
  changes to tracked files, and `git add -f <path>` to add new ones. Untracked
  files never show up in `git status`.
- The `home` alias isn't available in a non-interactive agent shell. Plain `git`
  works from inside `~/.home-sweet-home` (thanks to `core.worktree`), but paths
  are relative to the cwd, so `~/.zshrc` is `../.zshrc`. Alternatively:
  `git --git-dir=$HOME/.home-sweet-home/.git -C ~ <cmd>` gives paths relative to `~`.
- `git status --ignored` or anything that walks the whole of `~` is slow and
  noisy (macOS privacy errors under `~/Library`). Don't do it.

## Tracked files

List them with `git --git-dir=$HOME/.home-sweet-home/.git -C ~ ls-files`. At the
time of writing:

| Path (relative to `~`) | Purpose |
| --- | --- |
| `.gitignore` | Ignore rules for the repo (in `~`, so it applies to the whole work tree) |
| `.zshrc` | Main shell config: oh-my-zsh, vi keybindings, aliases, PATH setup |
| `.oh-my-zsh/custom/themes/pierd.zsh-theme` | Custom prompt theme |
| `.vimrc`, `.vim/colors/wombat256mod.vim` | Vim config and color scheme |
| `bin/funssh` | fzf picker over `~/.ssh/known_hosts`, then ssh without host-key checks |
| `bin/git-open` | Open the GitHub page for the current repo's `origin` |
| `bin/pi` | SSH to a Raspberry Pi, picking internal or external address |
| `bin/setup-github-workload-identity` | Set up GitHub Actions to Google Cloud Workload Identity Federation |
| `.home-sweet-home/{README.md,LICENSE,init.sh}` | Repo meta, `home` alias |

`~/bin` has other files that are deliberately **not** tracked (work-specific
wrappers, binaries such as `tshark`). Don't add them unless asked.

## Conventions

- **No secrets in the repo.** Secrets and machine-specific values live in
  untracked files that the config reads when present, such as
  `~/.homebrew_github_api_token`, `~/.pi_external_ip` and `~/.zshrc.local`
  (sourced last, for per-machine overrides). Follow that pattern.
- **`.zshrc` should be portable and safe to source anywhere.** Wrap each tool's
  setup in an existence guard so a missing tool never breaks the shell:
  ```zsh
  if [[ -d ~/.cargo/bin ]]; then
      export PATH=~/.cargo/bin:$PATH
  fi
  ```
  Use `which foo > /dev/null` for commands. Order matters: `~/bin` is prepended
  last so it wins, `compinit` runs after `fpath` changes, and `~/.zshrc.local`
  is sourced at the very end.
- Indent with 4 spaces (the `.vimrc` sets this too).
- Scripts in `bin/` start with `#!/bin/bash`, are executable, and are small and
  single-purpose.
- Commit messages are short and imperative, with no body needed: "Add nvm",
  "Update gitignore", "Handle SSH git origin in git-open".
- No AI co-author trailers or "generated with" lines in commits.

## Testing changes

There's no test suite. To check shell config changes:

- `zsh -n ~/.zshrc` for syntax.
- `zsh -i -c exit` to confirm an interactive shell starts without errors.
- `bash -n ~/bin/<script>` for scripts; use `shellcheck` if it's installed.

Changes take effect in new shells. Don't commit or push unless asked.
