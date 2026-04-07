# CLAUDE.md

## Purpose

`mathematicaTools` is a very small Wolfram Language paclet. Right now it exists
to expose one notebook-oriented utility: exporting the currently evaluating
notebook to a PDF in the same directory.

This repository is not a general-purpose toolkit yet. It is a minimal paclet
scaffold plus one implemented feature. When working here, assume the project is
closer to a focused personal utility than a polished library.

## Repository Shape

- `mathematicaTools/`
  - Paclet source root.
- `mathematicaTools/PacletInfo.wl`
  - Paclet metadata.
- `mathematicaTools/Kernel/mathematicaTools.wl`
  - Main package entrypoint for the `mathematicaTools`` context.
- `mathematicaTools/Kernel/pdfTools.wl`
  - Subpackage that contains the actual PDF export implementation.
- `mathematicaTools/build/`
  - Generated paclet build output committed into the repo.
- `scripts/paclet_generation_procedure.nb`
  - Manual build/install notebook used as the real packaging workflow.
- `scripts/installPaclet.wl`
  - Script that looks like an attempted automation of the notebook flow, but it
    is currently stale and inconsistent with this repo.
- `scripts/test_script.sh`
  - Not a real test suite. It only calls macOS `say`.
- `.github/workflows/claude.yaml`
  - Shared Claude Code workflow copied from the user's other recent projects.

There is no README, no CI for Wolfram code, and no formal test harness.

## Git Hygiene

`.gitignore` is minimal. It only ignores `.idea/`.

In practice that means repository noise such as `.DS_Store` can appear in
`git status`. At the time this file was written, untracked `.DS_Store` files
were already present in the working tree.

Agents should avoid treating those files as meaningful project assets.

## What The Paclet Exports

The package currently exposes exactly two public symbols:

- `exportCurrentNotebookToPDF`
- `end`

`end` is just an alias for `exportCurrentNotebookToPDF`.

The public symbol list is declared in
`mathematicaTools/Kernel/mathematicaTools.wl` by writing the symbol names in
the package context before loading the subpackage. There are no usage messages,
argument patterns, or option declarations.

## Package Loading Model

The paclet metadata in `mathematicaTools/PacletInfo.wl` declares:

- paclet name: `mathematicaTools`
- version: `0.0.1`
- minimum Wolfram version: `13.2+`
- one extension: a kernel extension rooted at `Kernel` with context
  `mathematicaTools``

The main package file `mathematicaTools/Kernel/mathematicaTools.wl` does four
important things:

1. Prints `loaded paclet: mathematicaTools` when loaded.
2. Begins the `mathematicaTools`` package context.
3. Clears all symbols in both `mathematicaTools`` and
   `mathematicaTools`Private`` and also calls `ClearSystemCache[]`.
4. Loads `mathematicaTools`pdfTools`` with `Get[...]`.

That means package loading is not quiet. Any agent or script that loads the
package should expect a print side effect.

It also means reloading is aggressive. The package intentionally clears its own
symbols and system cache on load.

## The Actual Feature

The implementation lives in `mathematicaTools/Kernel/pdfTools.wl`.

`exportCurrentNotebookToPDF := (...)` does the following:

1. Reads the current front-end notebook with `EvaluationNotebook[]`.
2. Resolves the notebook path with `NotebookFileName[nb]`.
3. Derives a PDF filename by replacing the notebook extension with `.pdf` via
   `FileBaseName[nbPath] <> ".pdf"`.
4. Exports the notebook to that sibling PDF path using
   `Export[..., nb, "PDF"]`.
5. Moves the selection to the evaluation cell, selects it, and deletes it.
6. Moves the front-end cursor to the next cell's contents.

The important consequence is that this is not a pure export helper. It also
mutates the open notebook UI by deleting the cell that invoked it.

The alias:

- `end := exportCurrentNotebookToPDF`

exists as a convenience command for interactive notebook use.

## Behavioral Constraints

This function assumes a live Wolfram front end. It is tied to notebook
evaluation state and will not behave meaningfully in a pure headless kernel
context.

More specifically, the implementation depends on:

- `EvaluationNotebook[]`
- `NotebookFileName[...]`
- `EvaluationCell[]`
- front-end selection movement
- front-end notebook deletion operations

If there is no saved notebook file, `NotebookFileName[nb]` may not produce a
usable path. If there is no currently evaluating cell in a normal notebook
context, the selection/deletion behavior may fail or behave unexpectedly.

## Important Implementation Quirks

There are several details an agent should notice before editing this project.

### 1. The function uses global symbols, not lexical locals

Inside `exportCurrentNotebookToPDF`, the names `nb`, `nbPath`, and `pdfPath`
are assigned directly. They are not wrapped in `Module`.

That means the function leaks intermediate values into the current context
instead of keeping them local. If you refactor the function, decide whether
that behavior should be preserved or cleaned up intentionally.

### 2. `end` is an extremely generic symbol

Using `end` as a public export is convenient in notebooks but risky in a larger
package because it is so short and generic. If more functionality is added
later, name collisions become more likely.

### 3. Loading the subpackage from the subpackage

`mathematicaTools/Kernel/pdfTools.wl` calls:

- `Needs["mathematicaTools`"]`

even though it is itself loaded from the main package. That is slightly
redundant, but it reflects the current package structure and should not be
changed casually without understanding Wolfram package loading order.

### 4. Build artifacts are committed and may be stale

The repo contains checked-in generated output under `mathematicaTools/build/`,
including:

- `mathematicaTools/build/mathematicaTools-0.0.1.paclet`
- `mathematicaTools/build/mathematicaTools/PacletInfo.wl`
- `mathematicaTools/build/mathematicaTools/PacletManifest.wl`
- `mathematicaTools/build/mathematicaTools/Kernel/*.wl`

Do not treat those files as authoritative source.

At the time of writing, the built copy of
`mathematicaTools/build/mathematicaTools/Kernel/mathematicaTools.wl` still
prints `here`, while the source file prints `loaded paclet: mathematicaTools`.
That is direct evidence the committed build output is not perfectly synchronized
with source.

If you change package code, edit files under `mathematicaTools/`, then rebuild.
Do not hand-edit `mathematicaTools/build/` unless the task is explicitly about
generated artifacts.

## Build And Install Workflow

The most trustworthy build workflow in this repo is not a shell script. It is
the notebook `scripts/paclet_generation_procedure.nb`.

That notebook documents the intended manual sequence:

1. Set `name = "mathematicaTools"`.
2. Run `PacletUninstall[name]`.
3. Optionally delete `mathematicaTools/build/`.
4. Load `PacletTools``.
5. Build the paclet with `PacletBuild[dir]`.
6. Install the built archive from
   `mathematicaTools/build/mathematicaTools-0.0.1.paclet` using
   `ForceVersionInstall -> True`.

The notebook also contains an explicit reminder near the top:

- if you add an asset, update `PacletInfo.wl`

That matters because paclet packaging depends on the metadata describing what
should ship.

## Generated Output

The build process creates:

- a build directory at `mathematicaTools/build/mathematicaTools/`
- a paclet archive at `mathematicaTools/build/mathematicaTools-0.0.1.paclet`
- a `PacletManifest.wl` containing hashes for packaged files

Right now the manifest only lists the two kernel source files:

- `Kernel/mathematicaTools.wl`
- `Kernel/pdfTools.wl`

That matches the fact that the paclet currently ships only kernel code.

## Script Caveats

### `scripts/installPaclet.wl` is stale

This script should not be trusted as-is.

It hardcodes:

- `name = "comp"`
- `Get["comp`"]`

Those values do not match this repository, whose paclet name and context are
`mathematicaTools`.

The rest of the script looks like it was copied from another project and only
partially adapted. If an agent is asked to automate installation, it should
start from `scripts/paclet_generation_procedure.nb`, not from this script,
unless fixing the script is itself the task.

### `scripts/test_script.sh` is not a test runner

It only executes:

- `say "test"`
- `say "hello"`
- `say "gnu"`

That is macOS-only behavior and unrelated to paclet correctness.

## Versioning And History

The git history is extremely small. The only obviously meaningful commit message
in the visible history is:

- `add: exportCurrentNotebookToPDF`

That lines up with the current state of the repository: this paclet appears to
have been created specifically to package that helper.

## How To Work Safely In This Repo

If you are an agent modifying this project, follow these rules:

1. Treat `mathematicaTools/` as source of truth.
2. Treat `mathematicaTools/build/` as generated output that may be stale.
3. Assume all meaningful runtime behavior is notebook/front-end dependent.
4. Preserve the `mathematicaTools`` context unless the task explicitly asks for
   a rename.
5. Rebuild the paclet after source changes if the task depends on packaged
   output.
6. Do not rely on `scripts/installPaclet.wl` without first fixing its stale
   project name.
7. Do not claim there is automated test coverage; there is none in this repo.

## If You Need To Extend The Paclet

The natural extension points are:

- adding more kernel source files under `mathematicaTools/Kernel/`
- exporting additional symbols from `mathematicaTools/Kernel/mathematicaTools.wl`
- updating `PacletInfo.wl` if new assets or extensions are introduced
- rebuilding the paclet so `build/` and the `.paclet` archive reflect source

If new functionality is notebook-facing, keep in mind the current style is very
interactive and convenience-oriented, not defensive or library-like.

## Current Bottom Line

This is a minimal Wolfram paclet for one front-end command:

- export the current notebook to a same-directory PDF
- delete the invoking cell afterward
- expose that operation as both `exportCurrentNotebookToPDF` and `end`

Everything else in the repository exists to package, rebuild, or manually
reinstall that behavior.

## Claude Workflow

The repository now includes `.github/workflows/claude.yaml`.

This file is a direct copy of the shared Claude Code workflow used in the
user's other recent PyCharm projects. It is not specific to Wolfram Language
development.

Operationally, it:

- listens for issue comments, PR review comments, issue opens/assignments, and
  PR reviews
- only runs when the relevant text contains `@claude`
- grants write access to contents, pull requests, and issues
- runs `anthropics/claude-code-action@v1`
- passes `--model claude-opus-4-6`
- expects the repository secret `CLAUDE_CODE_OAUTH_TOKEN`

It does not build the paclet, install Wolfram tooling, or run tests. Its role
is purely to enable Claude Code on GitHub events.
