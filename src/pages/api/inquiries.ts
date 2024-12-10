import type { NextApiRequest, NextApiResponse } from 'next';
import { connectDB } from '@/utils/mongodb';
import { Inquiry } from '@/models/Inquiry';

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method !== 'POST') {
    return res.status(405).json({ message: 'Method not allowed' });
  }

  try {
    await connectDB();

    const inquiry = await Inquiry.create(req.body);
    
    return res.status(201).json({ success: true, data: inquiry });
  } catch (error) {
    console.error('Error in inquiry submission:', error);
    return res.status(500).json({ 
      success: false, 
      message: 'Error submitting inquiry',
      error: error instanceof Error ? error.message : 'Unknown error'
    });
  }
}
