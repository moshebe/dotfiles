/**
 * commit.ts — /commit command
 *
 * Delegates to the LLM to stage changes and create a conventional commit.
 * Enforces: never commit to main/master, use conventional commits spec.
 *
 * This is a "prompt command" — it doesn't do the work itself, it sends
 * a structured message to the LLM which then uses bash/edit tools to act.
 * This is idiomatic pi: extensions are thin wrappers around LLM intent.
 */
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function commit(pi: ExtensionAPI) {
  pi.registerCommand("commit", {
    description: "Stage changes and create a conventional commit",
    async handler(ctx) {
      await ctx.sendUserMessage(`Create a git commit. Follow these rules exactly:

1. Run \`git status\` and \`git diff\` to understand the changes
2. If on main/master branch, create a side branch first: \`git checkout -b <descriptive-name>\`
3. Stage relevant changed files (never .env, secrets, or unrelated files)
4. Write a conventional commit message: \`type(scope): description\`
   - Types: feat | fix | refactor | docs | test | chore | ci
   - Message explains WHY, not just WHAT
   - Keep it under 72 characters
5. Run \`git commit -m "..."\`

Do it now.`);
    },
  });
}
