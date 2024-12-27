# Contractor Directory

A modern web application for finding and connecting with trusted contractors in your area. Built with Next.js, React, and Supabase.

## Features

- Modern, responsive UI built with Tailwind CSS
- Form handling with React Hook Form and Zod validation
- API integration with Supabase
- SEO optimization with Next.js metadata
- Type-safe development with TypeScript

## Tech Stack

- **Framework**: Next.js 15.1.3
- **Database**: Supabase
- **Styling**: Tailwind CSS
- **Form Management**: React Hook Form
- **Validation**: Zod
- **HTTP Client**: Axios
- **UI Components**: Radix UI
- **Font**: Inter (Google Fonts)

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   npm install
   ```

3. Create a `.env.local` file in the root directory with your Supabase credentials:
   ```
   NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. Run the development server:
   ```bash
   npm run dev
   ```

5. Open [http://localhost:3000](http://localhost:3000) in your browser

## Project Structure

```
contractor-directory/
├── src/
│   ├── app/
│   │   ├── api/            # API routes
│   │   ├── layout.tsx      # Root layout
│   │   └── page.tsx        # Home page
│   ├── components/
│   │   ├── ui/            # Reusable UI components
│   │   └── contractor-form.tsx
│   └── lib/
│       ├── api.ts         # API client
│       ├── axios.ts       # Axios configuration
│       ├── supabase/      # Supabase configuration
│       └── utils.ts       # Utility functions
├── public/
└── package.json
```

## Development Status

- [x] Project setup and configuration
- [x] UI components and styling
- [x] Form handling and validation
- [x] API integration
- [x] Supabase configuration
- [ ] Authentication
- [ ] Contractor listing page
- [ ] Search functionality
- [ ] Reviews system

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

This project is licensed under the MIT License.
