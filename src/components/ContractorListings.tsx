"use client";

import React, { useEffect, useState, useCallback } from 'react';
import { Card, CardContent, Typography, Rating, Grid, Box, Button } from '@mui/material';
import LocationOnIcon from '@mui/icons-material/LocationOn';
import PhoneIcon from '@mui/icons-material/Phone';
import StarIcon from '@mui/icons-material/Star';
import { PlaceResult } from '@/types/google-places';

interface ContractorListingsProps {
  keyword: string;
  location: string;
  initialResults?: PlaceResult[];
}

export default function ContractorListings({ keyword, location, initialResults = [] }: ContractorListingsProps) {
  const [results, setResults] = useState<PlaceResult[]>(initialResults);
  const [loading, setLoading] = useState(!initialResults.length);
  const [error, setError] = useState<string | null>(null);

  const fetchResults = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);
      const response = await fetch(`/api/search/places?keyword=${encodeURIComponent(keyword)}&location=${encodeURIComponent(location)}`);
      if (!response.ok) {
        throw new Error('Failed to fetch results');
      }
      const data = await response.json();
      setResults(data.results || []);
    } catch (err) {
      setError('Failed to load contractors. Please try again later.');
      console.error('Error fetching results:', err);
    } finally {
      setLoading(false);
    }
  }, [keyword, location]);

  useEffect(() => {
    if (!initialResults.length) {
      fetchResults();
    }
  }, [initialResults.length, fetchResults]);

  if (loading) {
    return (
      <Box sx={{ textAlign: 'center', py: 4 }}>
        <Typography>Loading contractors...</Typography>
      </Box>
    );
  }

  if (error) {
    return (
      <Box sx={{ textAlign: 'center', py: 4 }}>
        <Typography color="error">{error}</Typography>
        <Button onClick={fetchResults} sx={{ mt: 2 }}>
          Try Again
        </Button>
      </Box>
    );
  }

  if (!results.length) {
    return (
      <Box sx={{ textAlign: 'center', py: 4 }}>
        <Typography>No contractors found in this area.</Typography>
        <Button onClick={fetchResults} sx={{ mt: 2 }}>
          Refresh Results
        </Button>
      </Box>
    );
  }

  return (
    <Grid container spacing={3}>
      {results.map((result) => (
        <Grid item xs={12} sm={6} md={4} key={result.place_id}>
          <Card sx={{ height: '100%', display: 'flex', flexDirection: 'column' }}>
            <CardContent sx={{ flexGrow: 1 }}>
              <Typography variant="h6" component="h2" gutterBottom>
                {result.name}
              </Typography>
              
              {result.rating && (
                <Box sx={{ display: 'flex', alignItems: 'center', mb: 1 }}>
                  <Rating
                    value={result.rating}
                    readOnly
                    precision={0.1}
                    size="small"
                    icon={<StarIcon fontSize="inherit" />}
                  />
                  <Typography variant="body2" color="text.secondary" sx={{ ml: 1 }}>
                    ({result.user_ratings_total || 0})
                  </Typography>
                </Box>
              )}

              <Box sx={{ display: 'flex', alignItems: 'flex-start', mb: 1 }}>
                <LocationOnIcon sx={{ mr: 1, mt: 0.5 }} fontSize="small" />
                <Typography variant="body2" color="text.secondary">
                  {result.formatted_address}
                </Typography>
              </Box>

              {result.business_status === 'OPERATIONAL' && (
                <Box sx={{ display: 'flex', alignItems: 'center' }}>
                  <PhoneIcon sx={{ mr: 1 }} fontSize="small" />
                  <Typography variant="body2" color="text.secondary">
                    Click to view phone number
                  </Typography>
                </Box>
              )}
            </CardContent>
          </Card>
        </Grid>
      ))}
    </Grid>
  );
}
