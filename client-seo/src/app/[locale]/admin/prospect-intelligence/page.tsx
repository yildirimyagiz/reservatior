import { Metadata } from 'next';
import Dashboard from './Dashboard';

export const metadata: Metadata = {
  title: 'Prospect Intelligence | Reservatior',
  description: 'MLS prospect intelligence and acquisition opportunity scoring',
};

export default function Page() {
  return <Dashboard />;
}
