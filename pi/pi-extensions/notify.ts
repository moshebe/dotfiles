/**
 * notify.ts — desktop notifications when agent finishes
 *
 * Uses OSC 9 escape sequences, which Ghostty supports natively.
 * Fires on every `agent_end` event (i.e., when the LLM finishes a turn).
 *
 * OSC 9 format: ESC ] 9 ; <message> BEL
 * Only notifies if pi is not the focused window (terminal handles this).
 *
 * Learning note: `pi.on(event, handler)` is how extensions hook into the
 * agent lifecycle. The second arg `ctx` gives access to ui, session, etc.
 */
import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

export default function notify(pi: ExtensionAPI) {
  pi.on("agent_end", async (_event, _ctx) => {
    process.stdout.write("\x1b]9;Pi: task complete\x07");
  });
}
