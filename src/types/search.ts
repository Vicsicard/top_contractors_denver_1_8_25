export type SearchParams = {
  [key: string]: string | string[] | undefined;
  keyword?: string;
  location?: string;
}

export type SearchResult = {
  keyword: string;
  location: string;
}

export type SearchParamsInit = string | string[][] | Record<string, string> | URLSearchParams;
