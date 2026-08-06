"use client";

import { useState } from "react";
import { Mail, Copy, CheckCircle, Clock, X, Send, Sparkles, Shield, Users, Building2 } from "lucide-react";

interface MagicLinkInvitationProps {
  corporateAccountId: string;
  onInvitationSent?: (invitation: any) => void;
}

export default function MagicLinkInvitation({ corporateAccountId, onInvitationSent }: MagicLinkInvitationProps) {
  const [email, setEmail] = useState("");
  const [name, setName] = useState("");
  const [role, setRole] = useState<"property_manager" | "admin" | "viewer">("property_manager");
  const [customMessage, setCustomMessage] = useState("");
  const [priorityAccess, setPriorityAccess] = useState(false);
  const [seattlePilot, setSeattlePilot] = useState(false);
  
  const [sending, setSending] = useState(false);
  const [sent, setSent] = useState(false);
  const [magicLink, setMagicLink] = useState("");
  const [copied, setCopied] = useState(false);

  const handleSendInvitation = async () => {
    if (!email || !name) return;

    setSending(true);
    
    try {
      const response = await fetch('/api/v1/b2b/bulk-invitations', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          corporateAccountId,
          invitedEmail: email,
          invitedName: name,
          role,
          invitationMessage: customMessage,
          priorityAccess,
          seattlePilotCampaign: seattlePilot,
        }),
      });

      if (!response.ok) {
        throw new Error('Failed to send invitation');
      }

      const invitation = await response.json();
      setMagicLink(invitation.magicLink);
      setSent(true);
      
      if (onInvitationSent) {
        onInvitationSent(invitation);
      }
    } catch (error) {
      console.error('Failed to send invitation:', error);
    } finally {
      setSending(false);
    }
  };

  const copyMagicLink = () => {
    navigator.clipboard.writeText(magicLink);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  const resetForm = () => {
    setEmail("");
    setName("");
    setCustomMessage("");
    setPriorityAccess(false);
    setSeattlePilot(false);
    setSent(false);
    setMagicLink("");
  };

  const seattlePilotTemplate = `Welcome to Reservatior! We're excited to partner with your organization for our Seattle/Bellevue pilot program. Your portfolio will receive priority access to our AI-powered yield optimization and corporate tenant matching engine.`;

  return (
    <div className="space-y-6">
      {!sent ? (
        <>
          {/* Invitation Form */}
          <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <div className="flex items-center gap-3 mb-6">
              <div className="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-lg flex items-center justify-center">
                <Mail className="w-6 h-6 text-white" />
              </div>
              <div>
                <h3 className="text-lg font-semibold text-gray-900">Send Magic Link Invitation</h3>
                <p className="text-sm text-gray-600">Send a passwordless invitation to access the platform</p>
              </div>
            </div>

            <div className="space-y-4">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Recipient Name</label>
                  <input
                    type="text"
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    placeholder="John Smith"
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
                  <input
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    placeholder="john@company.com"
                    className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                  />
                </div>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Role</label>
                <select
                  value={role}
                  onChange={(e) => setRole(e.target.value as any)}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                >
                  <option value="property_manager">Property Manager</option>
                  <option value="admin">Admin</option>
                  <option value="viewer">Viewer</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Custom Message (Optional)</label>
                <textarea
                  value={customMessage}
                  onChange={(e) => setCustomMessage(e.target.value)}
                  placeholder="Add a personalized message..."
                  rows={3}
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent"
                />
              </div>

              {/* Special Options */}
              <div className="space-y-3 pt-4 border-t border-gray-200">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <Shield className="w-5 h-5 text-purple-600" />
                    <div>
                      <p className="font-medium text-gray-900">Priority Access</p>
                      <p className="text-sm text-gray-600">Bypass queue and get instant access</p>
                    </div>
                  </div>
                  <button
                    onClick={() => setPriorityAccess(!priorityAccess)}
                    className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors ${
                      priorityAccess ? 'bg-purple-600' : 'bg-gray-200'
                    }`}
                  >
                    <span
                      className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                        priorityAccess ? 'translate-x-6' : 'translate-x-1'
                      }`}
                    />
                  </button>
                </div>

                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <Building2 className="w-5 h-5 text-blue-600" />
                    <div>
                      <p className="font-medium text-gray-900">Seattle Pilot Campaign</p>
                      <p className="text-sm text-gray-600">Include in Seattle/Bellevue pilot program</p>
                    </div>
                  </div>
                  <button
                    onClick={() => {
                      setSeattlePilot(!seattlePilot);
                      if (!seattlePilot) {
                        setCustomMessage(seattlePilotTemplate);
                      }
                    }}
                    className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors ${
                      seattlePilot ? 'bg-blue-600' : 'bg-gray-200'
                    }`}
                  >
                    <span
                      className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${
                        seattlePilot ? 'translate-x-6' : 'translate-x-1'
                      }`}
                    />
                  </button>
                </div>
              </div>

              <button
                onClick={handleSendInvitation}
                disabled={!email || !name || sending}
                className="w-full px-4 py-3 bg-gradient-to-r from-purple-600 to-pink-600 text-white rounded-lg hover:from-purple-700 hover:to-pink-700 transition disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
              >
                {sending ? (
                  <>
                    <Clock className="w-4 h-4 animate-spin" />
                    Sending...
                  </>
                ) : (
                  <>
                    <Send className="w-4 h-4" />
                    Send Magic Link Invitation
                  </>
                )}
              </button>
            </div>
          </div>

          {/* Quick Templates */}
          <div className="bg-gradient-to-r from-purple-50 to-pink-50 rounded-xl p-6 border border-purple-200">
            <h4 className="font-semibold text-gray-900 mb-4 flex items-center gap-2">
              <Sparkles className="w-5 h-5 text-purple-600" />
              Quick Templates
            </h4>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
              <button
                onClick={() => setCustomMessage("Welcome to Reservatior! We're excited to have you onboard your portfolio with us.")}
                className="p-3 bg-white rounded-lg border border-purple-200 hover:border-purple-400 transition text-left"
              >
                <p className="font-medium text-gray-900">Standard Welcome</p>
                <p className="text-sm text-gray-600">Basic onboarding message</p>
              </button>
              <button
                onClick={() => setCustomMessage(seattlePilotTemplate)}
                className="p-3 bg-white rounded-lg border border-blue-200 hover:border-blue-400 transition text-left"
              >
                <p className="font-medium text-gray-900">Seattle Pilot</p>
                <p className="text-sm text-gray-600">Seattle/Bellevue specific</p>
              </button>
              <button
                onClick={() => setCustomMessage("Your portfolio has been analyzed by our AI. We've identified significant yield optimization opportunities.")}
                className="p-3 bg-white rounded-lg border border-blue-200 hover:border-blue-400 transition text-left"
              >
                <p className="font-medium text-gray-900">AI Insights</p>
                <p className="text-sm text-gray-600">Highlight AI analysis</p>
              </button>
              <button
                onClick={() => setCustomMessage("Priority access granted. Your portfolio will receive expedited processing and premium support.")}
                className="p-3 bg-white rounded-lg border border-yellow-200 hover:border-yellow-400 transition text-left"
              >
                <p className="font-medium text-gray-900">VIP Access</p>
                <p className="text-sm text-gray-600">Premium onboarding</p>
              </button>
            </div>
          </div>
        </>
      ) : (
        <>
          {/* Success State */}
          <div className="bg-blue-50 rounded-xl p-6 border border-blue-200">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
                <CheckCircle className="w-6 h-6 text-blue-600" />
              </div>
              <div>
                <h3 className="text-lg font-semibold text-blue-900">Invitation Sent Successfully</h3>
                <p className="text-sm text-blue-700">Magic link has been generated and sent to {email}</p>
              </div>
            </div>

            <div className="bg-white rounded-lg p-4 border border-blue-200 mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">Magic Link</label>
              <div className="flex gap-2">
                <input
                  type="text"
                  value={magicLink}
                  readOnly
                  className="flex-1 px-4 py-2 bg-gray-50 border border-gray-300 rounded-lg text-sm"
                />
                <button
                  onClick={copyMagicLink}
                  className="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center gap-2"
                >
                  {copied ? <CheckCircle className="w-4 h-4" /> : <Copy className="w-4 h-4" />}
                  {copied ? 'Copied!' : 'Copy'}
                </button>
              </div>
            </div>

            <div className="flex gap-3">
              <button
                onClick={resetForm}
                className="flex-1 px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition flex items-center justify-center gap-2"
              >
                <Mail className="w-4 h-4" />
                Send Another
              </button>
              <button
                onClick={() => window.open(magicLink, '_blank')}
                className="flex-1 px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition flex items-center justify-center gap-2"
              >
                <Users className="w-4 h-4" />
                Test Link
              </button>
            </div>
          </div>

          {/* Invitation Details */}
          <div className="bg-white rounded-xl shadow-sm p-6 border border-gray-100">
            <h4 className="font-semibold text-gray-900 mb-4">Invitation Details</h4>
            <div className="space-y-3">
              <div className="flex justify-between">
                <span className="text-gray-600">Recipient</span>
                <span className="font-medium text-gray-900">{name} ({email})</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-600">Role</span>
                <span className="font-medium text-gray-900 capitalize">{role.replace('_', ' ')}</span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-600">Priority Access</span>
                <span className={`font-medium ${priorityAccess ? 'text-blue-600' : 'text-gray-600'}`}>
                  {priorityAccess ? 'Enabled' : 'Disabled'}
                </span>
              </div>
              <div className="flex justify-between">
                <span className="text-gray-600">Seattle Pilot</span>
                <span className={`font-medium ${seattlePilot ? 'text-blue-600' : 'text-gray-600'}`}>
                  {seattlePilot ? 'Included' : 'Not Included'}
                </span>
              </div>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
