import Image from 'next/image'

interface ServiceHeroProps {
  title: string
  description: string
}

export function ServiceHero({ title, description }: ServiceHeroProps) {
  return (
    <div className="relative h-[400px] w-full">
      {/* Background Image */}
      <Image
        src="/images/denver-skyline.jpg"
        alt="Denver skyline"
        fill
        priority
        className="object-cover"
        quality={90}
      />
      
      {/* Gradient Overlay */}
      <div 
        className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/50 to-black/30"
        aria-hidden="true"
      />

      {/* Content */}
      <div className="relative h-full w-full">
        <div className="container mx-auto px-4 h-full">
          <div className="flex flex-col justify-center h-full max-w-3xl">
            <h1 className="text-4xl md:text-5xl font-bold text-white mb-4">
              {title}
            </h1>
            <p className="text-lg md:text-xl text-gray-100">
              {description}
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}
