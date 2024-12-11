import React from 'react';

interface JsonLdProps {
  type: string;
  data: Record<string, any>;
}

export function JsonLd({ type, data }: JsonLdProps): React.ReactElement {
  return (
    <script
      type={type}
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export default JsonLd;
