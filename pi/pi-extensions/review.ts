/**
 * review.ts — /review command
 *
 * Triggers an LLM code review. Auto-detects context:
 *   - If there are uncommitted changes: reviews the diff
 *   - If on a feature branch with a PR: reviews the PR diff
 *   - Otherwise: reviews the last commit
 *
 * Learning note: Commands that delegate to the LLM via sendUserMessage are
 * powerful — you get the LLM's full reasoning + tool access without writing
 * any parsing logic yourself. The extension just sets intent and context.
 */
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function review(pi: ExtensionAPI) {
  pi.registerCommand("review", {
    description: "Code review: uncommitted changes, current PR, or last commit",
    async handler(ctx) {
      await ctx.sendUserMessage(`Perform a focused code review. Steps:

1. Detect context:
   - Run \`git status\` — if there are uncommitted changes, use \`git diff\`
   - If on a feature branch, check \`gh pr view\` — if a PR exists, use \`gh pr diff\`
   - Otherwise, review \`git show HEAD\`

2. Review for:
   - Correctness and logic errors (highest priority)
   - Security vulnerabilities (OWASP top 10: injection, XSS, auth issues, etc.)
   - Missing error handling at system boundaries (user input, external APIs)
   - Edge cases not covered
   - Code quality: readability, naming, unnecessary complexity

3. Output format:
   - Group by severity: HIGH / MEDIUM / LOW
   - Only report issues worth fixing (skip nitpicks unless egregious)
   - For each issue: file:line — what's wrong — how to fix it
   - End with a 1-line summary verdict

Be direct. Skip praise.`);
    },
  });
}
