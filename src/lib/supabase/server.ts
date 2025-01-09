import { createClient as createSupabaseClient } from '@supabase/supabase-js';
import { cookies } from 'next/headers';
import { Database } from '@/types/supabase';

export async function createClient() {
  const cookieStore = await cookies();

  return createSupabaseClient<Database>(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      auth: {
        persistSession: true,
        storageKey: 'supabase.auth.token',
        storage: {
          getItem: (key: string) => {
            return cookieStore.get(key)?.value ?? null;
          },
          setItem: (key: string, value: string) => {
            cookieStore.set({ 
              name: key, 
              value,
              path: '/',
              maxAge: 60 * 60 * 24 * 365, // 1 year
              sameSite: 'lax',
              secure: process.env.NODE_ENV === 'production'
            });
          },
          removeItem: (key: string) => {
            cookieStore.delete(key);
          },
        },
      },
    }
  );
}
