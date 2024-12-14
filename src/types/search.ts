export interface SearchParams extends URLSearchParams {
  keyword?: string;
  location?: string;
}

export type SearchParamsInit = string | string[][] | Record<string, string> | URLSearchParams;
