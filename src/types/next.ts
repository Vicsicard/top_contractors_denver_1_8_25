import type { Metadata, ResolvingMetadata } from 'next';

export type SearchParams = { [key: string]: string | string[] | undefined };

export type PageProps<T = SearchParams> = {
  params: { [key: string]: string };
  searchParams: T;
};

export type LayoutProps = {
  children: React.ReactNode;
};

export type GenerateMetadataProps<T = { [key: string]: string }> = {
  params: T;
  searchParams: SearchParams;
};

export type GenerateMetadata<T = { [key: string]: string }> = (
  props: GenerateMetadataProps<T>,
  parent: ResolvingMetadata
) => Promise<Metadata> | Metadata;

export type ErrorPageProps = {
  error: Error & { digest?: string };
  reset: () => void;
};

export type NotFoundProps = {
  params?: { [key: string]: string | string[] };
};
