"use client";

import { useState } from "react";
import { Send, Check } from "lucide-react";

interface TicketResponderProps {
  ticketId: string;
  currentStatus: string;
  currentResponse?: string | null;
  onSuccess?: () => void;
}

export default function TicketResponder({
  ticketId,
  currentStatus,
  currentResponse,
  onSuccess,
}: TicketResponderProps) {
  const [response, setResponse] = useState(currentResponse || "");
  const [status, setStatus] = useState(currentStatus);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    setSuccess(false);

    try {
      const res = await fetch(`/api/admin/tickets/${ticketId}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ status, adminResponse: response }),
      });

      const data = await res.json();

      if (!res.ok) {
        throw new Error(data.error || "Failed to update ticket");
      }

      setSuccess(true);
      setTimeout(() => {
        onSuccess?.();
      }, 1000);
    } catch (err: any) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      {error && (
        <div className="rounded-lg bg-red-500/10 border border-red-500/20 p-3">
          <p className="text-sm text-red-400">{error}</p>
        </div>
      )}

      {success && (
        <div className="rounded-lg bg-green-500/10 border border-green-500/20 p-3">
          <p className="text-sm text-green-400 flex items-center gap-2">
            <Check className="h-4 w-4" />
            Response sent successfully!
          </p>
        </div>
      )}

      {/* Status */}
      <div>
        <label className="block text-sm font-medium text-slate-400 mb-2">
          Status
        </label>
        <select
          value={status}
          onChange={(e) => setStatus(e.target.value)}
          className="w-full rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
        >
          <option value="OPEN">Open</option>
          <option value="IN_PROGRESS">In Progress</option>
          <option value="RESOLVED">Resolved</option>
          <option value="CLOSED">Closed</option>
        </select>
      </div>

      {/* Response */}
      <div>
        <label className="block text-sm font-medium text-slate-400 mb-2">
          Admin Response
        </label>
        <textarea
          value={response}
          onChange={(e) => setResponse(e.target.value)}
          rows={6}
          placeholder="Type your response to the customer..."
          className="w-full rounded-lg border border-slate-700 bg-slate-800 px-4 py-2 text-white placeholder:text-slate-500 focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
        />
      </div>

      {/* Submit */}
      <button
        type="submit"
        disabled={loading || !response.trim()}
        className="flex items-center gap-2 rounded-lg bg-blue-600 px-4 py-2 text-white hover:bg-blue-700 transition disabled:opacity-50 disabled:cursor-not-allowed"
      >
        <Send className="h-4 w-4" />
        {loading ? "Sending..." : "Send Response"}
      </button>
    </form>
  );
}
