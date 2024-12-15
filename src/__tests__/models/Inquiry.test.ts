import mongoose from 'mongoose';
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

  beforeAll(async () => {
    await mongoose.connect(process.env.MONGODB_URI as string);
  });

  afterAll(async () => {
    await mongoose.connection.close();
  });

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

      let validationError: mongoose.Error.ValidationError | null = null;
      
      try {
        await inquiryWithoutRequired.validate();
      } catch (error) {
        if (error instanceof mongoose.Error.ValidationError) {
          validationError = error;
        }
      }

      expect(validationError).toBeInstanceOf(mongoose.Error.ValidationError);
      expect(validationError?.errors.email).toBeDefined();
      expect(validationError?.errors.phone).toBeDefined();
    });

    test('should fail validation with invalid preferredContactMethod', async () => {
      const inquiryWithInvalidContact = new Inquiry({
        ...validInquiryData,
        preferredContactMethod: 'invalid' as IInquiry['preferredContactMethod'],
      });

      let validationError: mongoose.Error.ValidationError | null = null;
      
      try {
        await inquiryWithInvalidContact.validate();
      } catch (error) {
        if (error instanceof mongoose.Error.ValidationError) {
          validationError = error;
        }
      }

      expect(validationError).toBeInstanceOf(mongoose.Error.ValidationError);
      expect(validationError?.errors.preferredContactMethod).toBeDefined();
    });

    test('should fail validation with invalid urgency', async () => {
      const inquiryWithInvalidUrgency = new Inquiry({
        ...validInquiryData,
        urgency: 'invalid' as IInquiry['urgency'],
      });

      let validationError: mongoose.Error.ValidationError | null = null;
      
      try {
        await inquiryWithInvalidUrgency.validate();
      } catch (error) {
        if (error instanceof mongoose.Error.ValidationError) {
          validationError = error;
        }
      }

      expect(validationError).toBeInstanceOf(mongoose.Error.ValidationError);
      expect(validationError?.errors.urgency).toBeDefined();
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
      interface IndexMap {
        [key: string]: number;
      }
      
      const indexMap = indexes.reduce((acc: IndexMap, index) => {
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

    test('should enforce unique email index', async () => {
      const inquiry1 = new Inquiry(validInquiryData);
      await inquiry1.save();

      const inquiry2 = new Inquiry(validInquiryData);
      let mongoError: mongoose.mongo.MongoServerError | null = null;

      try {
        await inquiry2.save();
      } catch (error) {
        if (error instanceof mongoose.mongo.MongoServerError) {
          mongoError = error;
        }
      }

      expect(mongoError).toBeDefined();
      expect(mongoError?.code).toBe(11000); // Duplicate key error code
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
