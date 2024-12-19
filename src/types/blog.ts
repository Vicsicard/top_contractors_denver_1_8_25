export interface BlogPost {
  id: string;
  title: string;
  slug: string;
  html: string;
  feature_image?: string;
  meta_title?: string;
  meta_description?: string;
  og_image?: string;
  og_title?: string;
  og_description?: string;
  published_at: string;
  categories: string[];
}

export interface RSSFeedResponse {
  items: BlogPost[];
  title: string;
  description: string;
  link: string;
}
