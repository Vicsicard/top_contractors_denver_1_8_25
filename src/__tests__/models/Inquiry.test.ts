import mongoose from 'mongoose';
import { MongoMemoryServer } from 'mongodb-memory-server';
import { Inquiry, IInquiry } from '../../models/Inquiry';

// Use the imported model
const inquiryModel = Inquiry;

describe('Inquiry Model Test Suite', () => {
  const validInquiryData: Partial<IInquiry> = {
    name: 'John Doe',
    email: 'john@example.com',
    phone: '123-456-7890',
    address: '123 Main St, Denver, CO',
    serviceType: 'Renovation',
    description: 'Need help with kitchen renovation',
    preferredContactMethod: 'email',
    urgency: 'medium',
  };

  describe('Validation Tests', () => {
    test('should validate a valid inquiry', async () => {
      const validInquiry = new inquiryModel(validInquiryData);
      const savedInquiry = await validInquiry.save();
      
      expect(savedInquiry._id).toBeDefined();
      expect(savedInquiry.name).toBe(validInquiryData.name);
      expect(savedInquiry.email).toBe(validInquiryData.email);
      expect(savedInquiry.status).toBe('new'); // default value
      expect(savedInquiry.createdAt).toBeDefined();
    });

    test('should fail validation without required fields', async () => {
      const inquiryWithoutRequired = new inquiryModel({
        name: 'John Doe',
        // missing required fields
      });

      let err: mongoose.Error.ValidationError | null = null;
      try {
        await inquiryWithoutRequired.save();
      } catch (error) {
        if (error instanceof mongoose.Error.ValidationError) {
          err = error;
        }
      }

      expect(err).toBeInstanceOf(mongoose.Error.ValidationError);
      expect(err?.errors.email).toBeDefined();
      expect(err?.errors.phone).toBeDefined();
    });

    test('should fail validation with invalid preferredContactMethod', async () => {
      const inquiryWithInvalidContact = new inquiryModel({
        ...validInquiryData,
        preferredContactMethod: 'invalid',
      });

      let err: mongoose.Error.ValidationError | null = null;
      try {
        await inquiryWithInvalidContact.save();
      } catch (error) {
        if (error instanceof mongoose.Error.ValidationError) {
          err = error;
        }
      }

      expect(err).toBeInstanceOf(mongoose.Error.ValidationError);
      expect(err?.errors.preferredContactMethod).toBeDefined();
    });
  });

  describe('Index Tests', () => {
    beforeAll(async () => {
      // Ensure indexes are created
      await inquiryModel.init();
    });

    test('should have expected indexes', async () => {
      const indexes = await inquiryModel.collection.indexes();
      
      // Convert indexes to a more easily testable format
      const indexMap = indexes.reduce((acc: { [key: string]: any }, index) => {
        const key = Object.keys(index.key)[0];
        acc[key] = index.key[key];
        return acc;
      }, {});
      
      expect(indexMap).toMatchObject({
        _id: 1,        // Default MongoDB index
        email: 1,      // Our custom indexes
        status: 1,
        createdAt: -1
      });
    });
  });

  describe('Query Tests', () => {
    beforeEach(async () => {
      // Create some test data
      await inquiryModel.create([
        { ...validInquiryData, status: 'new' },
        { ...validInquiryData, email: 'test2@example.com', status: 'contacted' },
        { ...validInquiryData, email: 'test3@example.com', status: 'completed' },
      ]);
    });

    test('should find inquiries by status', async () => {
      const newInquiries = await inquiryModel.find({ status: 'new' });
      expect(newInquiries).toHaveLength(1);
      
      const completedInquiries = await inquiryModel.find({ status: 'completed' });
      expect(completedInquiries).toHaveLength(1);
    });

    test('should find inquiry by email', async () => {
      const inquiry = await inquiryModel.findOne({ email: 'test2@example.com' });
      expect(inquiry).toBeDefined();
      expect(inquiry?.status).toBe('contacted');
    });
  });
});
