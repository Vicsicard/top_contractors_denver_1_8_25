import mongoose from 'mongoose';

export interface IInquiry {
  name: string;
  email: string;
  phone: string;
  address: string;
  serviceType: string;
  description: string;
  preferredContactMethod: 'email' | 'phone';
  preferredTimeToContact?: string;
  urgency: 'low' | 'medium' | 'high';
  budget?: string;
  createdAt: Date;
  status: 'new' | 'contacted' | 'in_progress' | 'completed' | 'cancelled';
}

const inquirySchema = new mongoose.Schema<IInquiry>({
  name: { type: String, required: true },
  email: { type: String, required: true },
  phone: { type: String, required: true },
  address: { type: String, required: true },
  serviceType: { type: String, required: true },
  description: { type: String, required: true },
  preferredContactMethod: { 
    type: String, 
    enum: ['email', 'phone'], 
    required: true 
  },
  preferredTimeToContact: { type: String },
  urgency: { 
    type: String, 
    enum: ['low', 'medium', 'high'], 
    required: true 
  },
  budget: { type: String },
  createdAt: { 
    type: Date, 
    default: Date.now 
  },
  status: { 
    type: String, 
    enum: ['new', 'contacted', 'in_progress', 'completed', 'cancelled'],
    default: 'new'
  }
});

// Create indexes for better query performance
inquirySchema.index({ email: 1 });
inquirySchema.index({ status: 1 });
inquirySchema.index({ createdAt: -1 });

export const Inquiry = mongoose.models.Inquiry || mongoose.model<IInquiry>('Inquiry', inquirySchema);
