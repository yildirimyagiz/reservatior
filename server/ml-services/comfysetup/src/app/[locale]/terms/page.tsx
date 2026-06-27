import { LegalLayout } from '@/components/ui/legal-layout';

export default function TermsPage() {
    return (
        <LegalLayout title="Terms of Service" lastUpdated="January 15, 2026">
            <p>
                Welcome to FurnitureStaging.AI. By accessing or using our website and services, you agree to be bound by these Terms of Service.
            </p>

            <h3>1. Acceptance of Terms</h3>
            <p>
                By accessing or using our services, you agree to these Terms. If you do not agree to all of the terms and conditions, you may not access or use our services.
            </p>

            <h3>2. User Responsibilities</h3>
            <p>
                You are responsible for your use of the services and for any content you provide, including compliance with applicable laws, rules, and regulations. You represent that you have the necessary rights to any images you upload for staging.
            </p>

            <h3>3. Intellectual Property</h3>
            <p>
                The generated staged images are provided to you for your real estate marketing use. We retain the rights to the underlying technology and AI models used to generate these images.
            </p>

            <h3>4. Limitation of Liability</h3>
            <p>
                To the maximum extent permitted by law, FurnitureStaging.AI shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues.
            </p>

            <h3>5. Changes to Terms</h3>
            <p>
                We reserve the right to modify these Terms at any time. We will provide notice of any material changes through our website or other means.
            </p>
        </LegalLayout>
    );
}
