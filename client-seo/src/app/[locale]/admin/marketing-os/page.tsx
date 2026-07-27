import { Metadata } from 'next';
import Dashboard from './Dashboard';

export const metadata: Metadata = {
  title: 'Marketing OS | Reservatior',
  description: 'Automated campaign generation and execution rules',
};

export default function Page() {
  return <Dashboard />;
}
