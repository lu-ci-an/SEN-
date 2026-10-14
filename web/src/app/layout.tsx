import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata = { title: 'Scientific Web Calculator', description: 'React and TypeScript scientific calculator with keyboard input, angle modes and result history.' };
export default function Layout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="en"><body>{children}</body></html>;
}
