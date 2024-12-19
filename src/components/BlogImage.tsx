'use client';

import Image from 'next/image';
import { useState } from 'react';

interface BlogImageProps {
  src: string;
  alt: string;
  priority?: boolean;
  className?: string;
}

export default function BlogImage({ src, alt, priority = false, className = '' }: BlogImageProps) {
  const [isError, setIsError] = useState(false);

  if (isError) {
    return null;
  }

  return (
    <div className="relative h-full w-full">
      <Image
        src={src}
        alt={alt}
        fill
        className={className}
        priority={priority}
        onError={() => setIsError(true)}
      />
    </div>
  );
}
