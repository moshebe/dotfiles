/**
 * plan-ask.ts — three-mode agent system with Shift+Tab rotation
 *
 * Modes:
 *   agent (default) — full tool access, acts autonomously
 *   ask             — read-only; explains, answers, explores (no writes)
 *   plan            — read-only + think-first; produces step-by-step plans
 *
 * Switch with: Shift+Tab to cycle, or /agent /ask /plan commands.
 *
 * Learning note: `before_agent_start` lets you inject into the system prompt
 * before each LLM call. `tool_call` lets you intercept and block tool use.
 * `pi.events.emit` broadcasts to other extensions (like status-bar.ts).
 */
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

type Mode = "agent" | "ask" | "plan";
const MODES: Mode[] = ["agent", "ask", "plan"];

/** Tools that write to the filesystem or run shell commands. */
const WRITE_TOOLS = new Set(["write", "edit", "bash", "patch"]);

const MODE_PROMPTS: Record<Mode, string> = {
  agent: "",
  ask: "\n\n[ASK MODE] You are in read-only mode. Answer questions, explain code, explore the codebase. Do NOT make any changes or run write operations.",
  plan: "\n\n[PLAN MODE] You are in planning mode. Think through the problem thoroughly. Produce a detailed step-by-step implementation plan. Do NOT write any code or make any changes yet.",
};

export default function planAsk(pi: ExtensionAPI) {
  let mode: Mode = "agent";

  function setMode(newMode: Mode, ctx?: { ui: { notify: (msg: string, severity: string) => void } }) {
    mode = newMode;
    pi.events.emit("mode:change", mode);
    ctx?.ui.notify(`Mode: ${mode}`, "info");
  }

  // Inject mode-specific instructions into the system prompt before each LLM call
  pi.on("before_agent_start", async (event: { system?: string }, _ctx) => {
    if (MODE_PROMPTS[mode]) {
      event.system = (event.system ?? "") + MODE_PROMPTS[mode];
    }
  });

  // Block write tools in ask/plan modes
  pi.on("tool_call", async (event: { tool?: { name?: string } }, ctx) => {
    if (mode !== "agent" && event.tool?.name && WRITE_TOOLS.has(event.tool.name)) {
      ctx.ui.notify(`Blocked: ${event.tool.name} is disabled in ${mode} mode`, "warning");
      return { block: true, message: `${mode} mode: write operations are disabled` };
    }
  });

  // Shift+Tab cycles through modes
  pi.registerShortcut("shift+tab", {
    description: "Cycle agent mode: agent → ask → plan → agent",
    async handler(ctx) {
      const next = MODES[(MODES.indexOf(mode) + 1) % MODES.length];
      setMode(next, ctx);
    },
  });

  pi.registerCommand("agent", {
    description: "Switch to agent mode (full tool access)",
    async handler(ctx) { setMode("agent", ctx); },
  });

  pi.registerCommand("ask", {
    description: "Switch to ask mode (read-only, answers questions)",
    async handler(ctx) { setMode("ask", ctx); },
  });

  pi.registerCommand("plan", {
    description: "Switch to plan mode (read-only, produces step-by-step plans)",
    async handler(ctx) { setMode("plan", ctx); },
  });
}
