# Development Templates
Development templates used for simplifying dev workflows.

## GitHub Templates

* Setup GitHub pre-commit/commit templates so as to mandate ISSUE-NUMBER reference in the commit message
* Setup other utility scripts (for e.g, for code-formatting etc)

## Installation
Ensure you are in your repo's base dir.
```
curl -s https://raw.githubusercontent.com/nyrahul/dev-templates/main/install.sh | bash -s
```

## Steps to use
1. Install hooks: `curl -s https://raw.githubusercontent.com/nyrahul/dev-templates/main/install.sh | bash -s` You need to be in the repos base path to install hooks.
2. The hooks use `gh` (GitHub cli-tool) for checking issues and verification. You will be prompted to do `gh auth login`.
3. Next when you make changes to your repo and try to commit, it will verify that the issue number is mentioned and the Signed-off-by tags are present.
