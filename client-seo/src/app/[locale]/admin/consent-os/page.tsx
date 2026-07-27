import { Metadata } from 'next';
import Dashboard from './Dashboard';

export const metadata: Metadata = {
  title: 'Consent OS | Reservatior',
  description: 'Entity-based consent management for GDPR, CCPA, KVKK compliance',
};

export default function Page() {
  return <Dashboard />;
}
