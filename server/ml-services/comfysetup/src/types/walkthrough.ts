export interface WalkthroughInput {
  listing_id: string;
  image_urls: string[];
  room_type?: string;
  design_style?: string;
}

export interface WalkthroughOutput {
  job_id: string;
  status: string;
  output_url?: string;
  error?: string;
}
