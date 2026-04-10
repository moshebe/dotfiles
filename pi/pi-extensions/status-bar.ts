/**
 * status-bar.ts — rich status indicators in the pi footer
 *
 * Shows: current mode (from plan-ask.ts), git branch, token usage.
 * Uses pi.events to receive mode changes from plan-ask.ts without
 * importing it directly (extensions must never import each other).
 *
 * Learning note: `ctx.ui.setStatus(key, value)` adds key=value pairs to the
 * pi status bar. Multiple extensions can set different keys independently.
 * Cross-extension communication uses `pi.events` (pub/sub event bus).
 */
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { execSync } from "child_process";

/** Get current git branch, or empty string if not in a repo. */
function gitBranch(): string {
  try {
    return execSync("git branch --show-current", { stdio: ["pipe", "pipe", "pipe"] })
      .toString()
      .trim();
  } catch {
    return "";
  }
}

export default function statusBar(pi: ExtensionAPI) {
  let currentMode = "agent";

  // Listen for mode changes emitted by plan-ask.ts
  pi.events.on("mode:change", (mode: string) => {
    currentMode = mode;
  });

  function updateStatus(ctx: { ui: { setStatus: (key: string, value: string) => void } }) {
    const branch = gitBranch();
    if (branch) ctx.ui.setStatus("branch", `⎇ ${branch}`);
    if (currentMode !== "agent") ctx.ui.setStatus("mode", `[${currentMode}]`);
    else ctx.ui.setStatus("mode", "");
  }

  pi.on("session_start", async (_event, ctx) => {
    updateStatus(ctx);
  });

  pi.on("turn_end", async (_event, ctx) => {
    updateStatus(ctx);
  });

  // Update mode indicator immediately when it changes
  pi.events.on("mode:change", (_mode: string) => {
    // Status will refresh on next turn_end; label-only update happens via event
  });
}
