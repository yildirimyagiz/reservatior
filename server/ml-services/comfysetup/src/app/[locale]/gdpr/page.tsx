import { LegalLayout } from '@/components/ui/legal-layout';

export default function GdprPage() {
    return (
        <LegalLayout title="GDPR Compliance" lastUpdated="January 15, 2026">
            <p>
                FurnitureStaging.AI is committed to compliance with the General Data Protection Regulation (GDPR). We safeguard the personal data of our users in the European Economic Area (EEA).
            </p>

            <h3>1. Data Processing</h3>
            <p>
                We process personal data only when we have a lawful basis to do so, such as fulfillment of contract, consent, or legitimate interests.
            </p>

            <h3>2. Data Transfers</h3>
            <p>
                If we transfer personal data outside the EEA, we ensure appropriate safeguards are in place, such as Standard Contractual Clauses.
            </p>

            <h3>3. Your Rights User GDPR</h3>
            <p>
                If you are a resident of the EEA, you have the following rights:
            </p>
            <ul>
                <li>The right to be informed about how we use your personal data.</li>
                <li>The right of access to your personal data.</li>
                <li>The right to rectification of inaccurate data.</li>
                <li>The right to erasure (&apos;the right to be forgotten&apos;).</li>
                <li>The right to restrict processing.</li>
                <li>The right to data portability.</li>
                <li>The right to object to processing.</li>
            </ul>

            <h3>4. Data Protection Officer</h3>
            <p>
                You can contact our Data Protection Officer at dpo@furniturestaging.ai for any GDPR-related inquiries.
            </p>
        </LegalLayout>
    );
}
