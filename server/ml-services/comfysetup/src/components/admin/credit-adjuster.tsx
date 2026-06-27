"use client";

import { useState } from "react";
import { CreditCard, Plus, Minus, Edit } from "lucide-react";

interface CreditAdjusterProps {
  userId: string;
  currentCredits: number;
  userName: string;
  onSuccess?: () => void;
}

export default function CreditAdjuster({
  userId,
  currentCredits,
  userName,
  onSuccess,
}: CreditAdjusterProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [amount, setAmount] = useState<number>(0);
  const [operation, setOperation] = useState<"add" | "subtract" | "set">("add");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleAdjust = async () => {
    if (amount <= 0 && operation !== "set") {
      setError("Amount must be greater than 0");
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await fetch("/api/admin/credits/adjust", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ userId, amount, operation }),
      });

      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.error || "Failed to adjust credits");
      }

      setIsOpen(false);
      setAmount(0);
      onSuccess?.();
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const previewCredits = () => {
    switch (operation) {
      case "add":
        return currentCredits + amount;
      case "subtract":
        return Math.max(0, currentCredits - amount);
      case "set":
        return amount;
      default:
        return currentCredits;
    }
  };

  return (
    <>
      <button
        onClick={() => setIsOpen(true)}
        className="inline-flex items-center gap-2 rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-sm text-white hover:bg-slate-700 transition"
      >
        <CreditCard className="h-4 w-4" />
        Adjust Credits
      </button>

      {isOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">
          <div className="w-full max-w-md rounded-xl border border-slate-800 bg-slate-900 p-6">
            <h2 className="text-xl font-bold text-white mb-4">Adjust Credits</h2>
            <p className="text-sm text-slate-400 mb-4">
              Adjust credits for <span className="font-semibold text-white">{userName}</span>
            </p>

            {error && (
              <div className="mb-4 rounded-lg bg-red-500/10 border border-red-500/20 p-3">
                <p className="text-sm text-red-400">{error}</p>
              </div>
            )}

            <div className="space-y-4">
              {/* Operation Type */}
              <div>
                <label className="block text-sm font-medium text-slate-400 mb-2">
                  Operation
                </label>
                <div className="grid grid-cols-3 gap-2">
                  <button
                    onClick={() => setOperation("add")}
                    className={`flex items-center justify-center gap-2 rounded-lg border px-4 py-2 text-sm font-medium transition ${
                      operation === "add"
                        ? "border-green-500 bg-green-500/10 text-green-400"
                        : "border-slate-700 bg-slate-800 text-slate-400 hover:bg-slate-700"
                    }`}
                  >
                    <Plus className="h-4 w-4" />
                    Add
                  </button>
                  <button
                    onClick={() => setOperation("subtract")}
                    className={`flex items-center justify-center gap-2 rounded-lg border px-4 py-2 text-sm font-medium transition ${
                      operation === "subtract"
                        ? "border-red-500 bg-red-500/10 text-red-400"
                        : "border-slate-700 bg-slate-800 text-slate-400 hover:bg-slate-700"
                    }`}
                  >
                    <Minus className="h-4 w-4" />
                    Subtract
                  </button>
                  <button
                    onClick={() => setOperation("set")}
                    className={`flex items-center justify-center gap-2 rounded-lg border px-4 py-2 text-sm font-medium transition ${
                      operation === "set"
                        ? "border-blue-500 bg-blue-500/10 text-blue-400"
                        : "border-slate-700 bg-slate-800 text-slate-400 hover:bg-slate-700"
                    }`}
                  >
                    <Edit className="h-4 w-4" />
                    Set
                  </button>
                </div>
              </div>

              {/* Amount */}
              <div>
                <label className="block text-sm font-medium text-slate-400 mb-2">
                  Amount
                </label>
                <input
                  type="number"
                  min="0"
                  value={amount}
                  onChange={(e) => setAmount(parseInt(e.target.value) || 0)}
                  className="w-full rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
                  placeholder="Enter amount"
                />
              </div>

              {/* Preview */}
              <div className="rounded-lg border border-slate-700 bg-slate-800/50 p-4">
                <div className="flex items-center justify-between text-sm">
                  <span className="text-slate-400">Current Credits:</span>
                  <span className="font-bold text-white">{currentCredits}</span>
                </div>
                <div className="mt-2 flex items-center justify-between text-sm">
                  <span className="text-slate-400">New Credits:</span>
                  <span className="font-bold text-blue-400">{previewCredits()}</span>
                </div>
              </div>

              {/* Actions */}
              <div className="flex gap-3">
                <button
                  onClick={() => setIsOpen(false)}
                  className="flex-1 rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white hover:bg-slate-700 transition"
                  disabled={loading}
                >
                  Cancel
                </button>
                <button
                  onClick={handleAdjust}
                  disabled={loading || amount === 0}
                  className="flex-1 rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700 transition disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {loading ? "Adjusting..." : "Confirm"}
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
