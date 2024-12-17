import { generateLocalBusinessSchema, generateBreadcrumbSchema } from './schema';

export interface ServiceArea {
  city: string;
  state: string;
  zip: string;
}

export interface ContractorService {
  name: string;
  description: string;
}

export interface ContractorPageData {
  type: string;
  title: string;
  description: string;
  services: string[];
  serviceAreas: ServiceArea[];
  schema: {
    local: any;
    breadcrumb: any;
  };
}

export const serviceAreas: ServiceArea[] = [
  { city: 'Denver', state: 'CO', zip: '80014' },
  { city: 'Aurora', state: 'CO', zip: '80010' },
  { city: 'Lakewood', state: 'CO', zip: '80215' },
  { city: 'Arvada', state: 'CO', zip: '80002' },
  { city: 'Westminster', state: 'CO', zip: '80030' },
  { city: 'Thornton', state: 'CO', zip: '80229' },
  { city: 'Centennial', state: 'CO', zip: '80112' },
  { city: 'Highlands Ranch', state: 'CO', zip: '80129' },
  { city: 'Littleton', state: 'CO', zip: '80120' },
  { city: 'Englewood', state: 'CO', zip: '80110' }
];

export const contractorServices = {
  plumber: [
    "Emergency Repairs",
    "Leak Detection",
    "Drain Cleaning",
    "Water Heater Services",
    "Pipe Repairs and Replacement"
  ],
  electrician: [
    "Emergency Electrical Repairs",
    "Electrical Panel Upgrades",
    "Lighting Installation",
    "Wiring and Rewiring",
    "Electrical Safety Inspections"
  ],
  roofer: [
    "Roof Repairs",
    "Roof Replacement",
    "Storm Damage Repair",
    "Gutter Installation",
    "Roof Inspections"
  ],
  hvac: [
    "AC Installation & Repair",
    "Heating System Services",
    "Ventilation Solutions",
    "Emergency HVAC Repairs",
    "Preventive Maintenance"
  ],
  carpenter: [
    "Custom Cabinetry",
    "Trim & Molding Installation",
    "Door Installation & Repair",
    "Custom Built-ins",
    "Structural Repairs",
    "Wood Framing"
  ],
  painter: [
    "Interior Painting",
    "Exterior Painting",
    "Cabinet Refinishing",
    "Deck & Fence Staining",
    "Color Consultation",
    "Wallpaper Installation"
  ],
  landscaper: [
    "Landscape Design",
    "Lawn Maintenance",
    "Irrigation Systems",
    "Hardscape Installation",
    "Tree & Shrub Care",
    "Outdoor Lighting"
  ],
  homeRemodeling: [
    "Full Home Renovations",
    "Basement Finishing",
    "Room Additions",
    "Structural Modifications",
    "Permit Management",
    "Design Services"
  ],
  bathroomRemodeling: [
    "Full Bathroom Remodels",
    "Shower & Tub Installation",
    "Tile Installation",
    "Vanity & Cabinet Installation",
    "Plumbing Fixtures",
    "Lighting Updates"
  ],
  kitchenRemodeling: [
    "Custom Cabinet Installation",
    "Countertop Installation",
    "Kitchen Island Design",
    "Appliance Installation",
    "Lighting & Electrical",
    "Backsplash Installation"
  ],
  sidingAndGutters: [
    "Siding Installation",
    "Gutter Installation",
    "Downspout Installation",
    "Fascia & Soffit Repair",
    "Gutter Guards",
    "Siding Repair"
  ],
  masonry: [
    "Brick & Stone Installation",
    "Retaining Walls",
    "Chimney Repair",
    "Concrete Work",
    "Paver Installation",
    "Stone Veneer"
  ],
  decks: [
    "Custom Deck Design",
    "Deck Construction",
    "Deck Repair",
    "Railing Installation",
    "Deck Staining & Sealing",
    "Pergola Construction"
  ],
  flooring: [
    "Hardwood Installation",
    "Tile Installation",
    "Carpet Installation",
    "Vinyl & Laminate",
    "Floor Refinishing",
    "Subfloor Repair"
  ],
  windows: [
    "Window Installation",
    "Window Replacement",
    "Energy Efficient Updates",
    "Storm Windows",
    "Custom Window Design",
    "Window Repair"
  ],
  fencing: [
    "Fence Installation",
    "Gate Installation",
    "Privacy Fencing",
    "Chain Link Fencing",
    "Wood Fence Construction",
    "Fence Repair"
  ]
};

export function generateContractorData(
  contractorType: string,
  pageType: string,
  services: string[]
): ContractorPageData {
  const title = `Top ${contractorType}s in Denver, CO`;
  const description = `Professional ${contractorType.toLowerCase()} services in Denver and surrounding areas. Licensed and insured experts providing quality workmanship and excellent customer service.`;

  return {
    type: contractorType,
    title,
    description,
    services,
    serviceAreas,
    schema: {
      local: generateLocalBusinessSchema(title, description),
      breadcrumb: generateBreadcrumbSchema([
        { name: 'Home', item: '/' },
        { name: contractorType, item: `/${pageType}` }
      ])
    }
  };
}
