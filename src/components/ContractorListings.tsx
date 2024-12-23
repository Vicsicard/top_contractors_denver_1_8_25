"use client";

import React, { useEffect, useState, useCallback } from 'react';
import { Card, CardContent, Typography, Rating, Grid, Box, Button } from '@mui/material';
import LocationOnIcon from '@mui/icons-material/LocationOn';
import PhoneIcon from '@mui/icons-material/Phone';
import StarIcon from '@mui/icons-material/Star';
import { PlaceResult } from '@/types/google-places';

interface ContractorListingsProps {
  keyword?: string;
  location?: string;
  initialResults?: PlaceResult[];
}

export default function ContractorListings({ keyword = '', location = '', initialResults = [] }: ContractorListingsProps) {
  const [results, setResults] = useState<PlaceResult[]>(initialResults);
  const [loading, setLoading] = useState(!initialResults.length);
  const [error, setError] = useState<string | null>(null);

  const fetchResults = useCallback(async () => {
    try {
      // Don't fetch if no keyword is provided
      if (!keyword?.trim()) {
        setError('Please provide a search term');
        return;
      }

      setLoading(true);
      setError(null);
      
      // Format the keyword to ensure it includes "contractor" if not already present
      const formattedKeyword = keyword.trim().toLowerCase().includes('contractor') ? 
        keyword.trim() : 
        `${keyword.trim()} contractor`;
      
      // Format the location to ensure it includes Denver if not already present
      const formattedLocation = (location?.trim() || 'Denver, CO').toLowerCase().includes('denver') ? 
        (location?.trim() || 'Denver, CO') : 
        `${location?.trim() || 'Denver'}, Denver, CO`;

      console.log('Fetching results for:', { 
        keyword: formattedKeyword, 
        location: formattedLocation 
      });

      const queryParams = new URLSearchParams({
        query: formattedKeyword,
        location: formattedLocation,
        type: 'contractor'  // Add type parameter for better filtering
      });

      const response = await fetch(`/api/places/search?${queryParams}`, {
        method: 'GET',
        headers: {
          'Accept': 'application/json'
        }
      });
      
      let data;
      try {
        data = await response.json();
      } catch (parseError) {
        console.error('Error parsing response:', parseError);
        throw new Error('Invalid response from server');
      }

      if (!response.ok) {
        console.error('API error:', data);
        throw new Error(data.message || data.error || 'Failed to fetch results');
      }

      if (data.results && Array.isArray(data.results)) {
        console.log('Received results:', {
          count: data.results.length,
          firstResult: data.results[0]?.name,
          status: data.status
        });

        // Filter results to ensure they are actually contractors
        const filteredResults = data.results.filter(result => {
          const name = result.name.toLowerCase();
          const types = result.types?.map(t => t.toLowerCase()) || [];
          
          // Check if it's likely a contractor
          return (
            name.includes('contractor') ||
            name.includes('construction') ||
            name.includes('service') ||
            name.includes('repair') ||
            types.some(t => 
              t.includes('contractor') || 
              t.includes('service') || 
              t.includes('repair') ||
              t.includes('construction')
            )
          );
        });

        console.log('Filtered results:', {
          original: data.results.length,
          filtered: filteredResults.length
        });

        setResults(filteredResults);
      } else {
        console.error('Invalid results format:', data);
        setResults([]);
      }
    } catch (err) {
      console.error('Error fetching results:', err);
      setError(err instanceof Error ? err.message : 'Failed to load contractors. Please try again later.');
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
