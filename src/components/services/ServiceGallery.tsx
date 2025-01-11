import { useState } from 'react'
import Image from 'next/image'

interface GalleryImage {
  url: string
  alt: string
  category?: string
}

interface ServiceGalleryProps {
  images: GalleryImage[]
  categories?: string[]
}

export function ServiceGallery({ images, categories = [] }: ServiceGalleryProps) {
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null)

  const filteredImages = selectedCategory
    ? images.filter((img) => img.category === selectedCategory)
    : images

  return (
    <div className="bg-gray-50 py-12">
      <div className="container mx-auto px-4">
        <h2 className="text-3xl font-bold text-gray-900 mb-8">Project Gallery</h2>

        {categories.length > 0 && (
          <div className="flex gap-4 mb-8 overflow-x-auto pb-2">
            <button
              className={`px-4 py-2 rounded-lg font-medium ${
                !selectedCategory
                  ? 'bg-blue-600 text-white'
                  : 'bg-white text-gray-600 hover:bg-gray-100'
              }`}
              onClick={() => setSelectedCategory(null)}
            >
              All
            </button>
            {categories.map((category) => (
              <button
                key={category}
                className={`px-4 py-2 rounded-lg font-medium ${
                  selectedCategory === category
                    ? 'bg-blue-600 text-white'
                    : 'bg-white text-gray-600 hover:bg-gray-100'
                }`}
                onClick={() => setSelectedCategory(category)}
              >
                {category}
              </button>
            ))}
          </div>
        )}

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredImages.map((image, index) => (
            <div
              key={index}
              className="relative aspect-video rounded-lg overflow-hidden group"
            >
              <Image
                src={image.url}
                alt={image.alt}
                fill
                className="w-full h-full object-cover transition-transform group-hover:scale-105"
              />
              <div className="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-30 transition-opacity" />
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
