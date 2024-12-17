import { useState, useEffect } from 'react';
import { Business } from '@prisma/client';
import { refreshBusinessData } from '../utils/dataRefresh';

export function useBusinessData(placeId: string) {
  const [business, setBusiness] = useState<Business | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function fetchData() {
      try {
        setLoading(true);
        const data = await refreshBusinessData(placeId);
        setBusiness(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Failed to fetch business data');
      } finally {
        setLoading(false);
      }
    }

    if (placeId) {
      fetchData();
    }
  }, [placeId]);

  return { business, loading, error };
}
