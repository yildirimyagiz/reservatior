export class AutoPayoutDispatcher {
  public static async executeNightlyPayouts() {
    // FAIL-CLOSED (audit §3.3 / §6.A.1): the previous implementation flipped
    // commissions to PAID using a `Math.random()` success simulation, recording
    // "phantom payments" that never left any account. No real PSP transfer is
    // wired, so this sweep must not touch commission status. Re-enable only after
    // wiring a real payout provider (e.g. Stripe Connect transferToConnectedAccount).
    console.warn(
      "[AutoPayoutDispatcher] Auto-payout sweep is DISABLED (fail-closed). " +
        "Simulated payouts were removed: no commission status will be changed until a " +
        "real payout provider is wired (audit §6.A.1)."
    );
    return;
  }
}
