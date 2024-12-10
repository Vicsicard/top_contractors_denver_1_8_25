interface JsonLdProps {
  type: string;
  data: Record<string, unknown>;
}

export function JsonLd({ type, data }: JsonLdProps): JSX.Element {
  return (
    <script
      type={type}
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export default JsonLd;
