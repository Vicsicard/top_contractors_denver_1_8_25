/**
 * ⚠️ IMPORTANT - DO NOT MODIFY ⚠️
 * This file contains core utilities for the Popular Trades section.
 * The format, layout, and functionality of these trades have been finalized.
 * 
 * Protected Features:
 * - Trade page layouts
 * - Google Places API integration
 * - Contractor listing formats
 * - Contact form implementations
 * - Service area configurations
 * 
 * Any changes to these components must be approved by the project owner.
 * The current implementation has been optimized for:
 * - User experience
 * - SEO performance
 * - Conversion rates
 * - API efficiency
 */

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
  schema?: {
    local: string;
    breadcrumb: string;
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
  'epoxy-garage': [
    { name: 'Epoxy Floor Installation', description: 'Professional installation of epoxy coating systems for garage floors' },
    { name: 'Garage Floor Coating', description: 'High-quality epoxy and polyaspartic floor coatings' },
    { name: 'Floor Preparation', description: 'Surface grinding, cleaning, and repair before coating application' },
    { name: 'Concrete Repair', description: 'Fixing cracks, spalls, and other concrete damage' },
    { name: 'Custom Designs', description: 'Decorative flake systems, metallic epoxy, and custom color options' }
  ],
  plumber: [
    { name: 'Emergency Repairs', description: '24/7 emergency plumbing repair services' },
    { name: 'Leak Detection', description: 'Advanced leak detection and repair services' },
    { name: 'Drain Cleaning', description: 'Professional drain cleaning and maintenance' },
    { name: 'Water Heater Services', description: 'Installation, repair, and maintenance of water heaters' },
    { name: 'Pipe Repair', description: 'Expert pipe repair and replacement services' },
    { name: 'Fixture Installation', description: 'Installation of sinks, toilets, and other fixtures' }
  ],
  electrician: [
    { name: 'Emergency Services', description: '24/7 emergency electrical repairs' },
    { name: 'Electrical Repairs', description: 'General electrical repair and maintenance' },
    { name: 'Panel Upgrades', description: 'Electrical panel upgrades and replacements' },
    { name: 'Lighting Installation', description: 'Indoor and outdoor lighting installation' },
    { name: 'Wiring Services', description: 'New wiring installation and rewiring' }
  ],
  hvac: [
    { name: 'AC Repair', description: 'Air conditioning repair and maintenance' },
    { name: 'Heating Repair', description: 'Heating system repair and maintenance' },
    { name: 'System Installation', description: 'New HVAC system installation' },
    { name: 'Duct Cleaning', description: 'Professional duct cleaning services' },
    { name: 'Preventive Maintenance', description: 'Regular HVAC system maintenance' }
  ],
  roofer: [
    { name: 'Roof Repair', description: 'Professional roof repair services' },
    { name: 'Roof Replacement', description: 'Complete roof replacement services' },
    { name: 'Emergency Services', description: '24/7 emergency roof repair' },
    { name: 'Inspection', description: 'Comprehensive roof inspections' },
    { name: 'Maintenance', description: 'Regular roof maintenance services' }
  ],
  carpenter: [
    { name: 'Custom Carpentry', description: 'Custom woodworking and carpentry' },
    { name: 'Cabinet Installation', description: 'Custom cabinet installation' },
    { name: 'Trim Work', description: 'Crown molding and trim installation' },
    { name: 'Door Installation', description: 'Door installation and repair' },
    { name: 'Framing', description: 'Structural framing services' }
  ],
  painter: [
    { name: 'Interior Painting', description: 'Professional interior painting services' },
    { name: 'Exterior Painting', description: 'Expert exterior painting services' },
    { name: 'Cabinet Painting', description: 'Cabinet refinishing and painting' },
    { name: 'Color Consultation', description: 'Professional color consultation' },
    { name: 'Wallpaper Installation', description: 'Wallpaper installation and removal' }
  ],
  landscaper: [
    { name: 'Landscape Design', description: 'Custom landscape design services' },
    { name: 'Lawn Maintenance', description: 'Regular lawn mowing and maintenance' },
    { name: 'Irrigation Systems', description: 'Installation and repair of irrigation systems' },
    { name: 'Hardscape Installation', description: 'Installation of patios, walkways, and retaining walls' },
    { name: 'Tree & Shrub Care', description: 'Pruning, trimming, and removal of trees and shrubs' },
    { name: 'Outdoor Lighting', description: 'Installation of outdoor lighting systems' }
  ],
  homeRemodeling: [
    { name: 'Full Home Renovations', description: 'Complete home remodeling services' },
    { name: 'Basement Finishing', description: 'Basement finishing and remodeling' },
    { name: 'Room Additions', description: 'Adding new rooms to your home' },
    { name: 'Structural Modifications', description: 'Modifying the structure of your home' },
    { name: 'Permit Management', description: 'Obtaining necessary permits for your project' },
    { name: 'Design Services', description: 'Custom design services for your remodeling project' }
  ],
  bathroomRemodeling: [
    { name: 'Full Bathroom Remodels', description: 'Complete bathroom remodeling services' },
    { name: 'Shower & Tub Installation', description: 'Installation of new showers and tubs' },
    { name: 'Tile Installation', description: 'Installation of tile flooring and walls' },
    { name: 'Vanity & Cabinet Installation', description: 'Installation of new vanities and cabinets' },
    { name: 'Plumbing Fixtures', description: 'Installation of new plumbing fixtures' },
    { name: 'Lighting Updates', description: 'Updating the lighting in your bathroom' }
  ],
  kitchenRemodeling: [
    { name: 'Custom Cabinet Installation', description: 'Installation of custom cabinets' },
    { name: 'Countertop Installation', description: 'Installation of new countertops' },
    { name: 'Kitchen Island Design', description: 'Design and installation of kitchen islands' },
    { name: 'Appliance Installation', description: 'Installation of new appliances' },
    { name: 'Lighting & Electrical', description: 'Updating the lighting and electrical in your kitchen' },
    { name: 'Backsplash Installation', description: 'Installation of new backsplashes' }
  ],
  sidingAndGutters: [
    { name: 'Siding Installation', description: 'Installation of new siding' },
    { name: 'Gutter Installation', description: 'Installation of new gutters' },
    { name: 'Downspout Installation', description: 'Installation of new downspouts' },
    { name: 'Fascia & Soffit Repair', description: 'Repair of fascia and soffit' },
    { name: 'Gutter Guards', description: 'Installation of gutter guards' },
    { name: 'Siding Repair', description: 'Repair of existing siding' }
  ],
  masonry: [
    { name: 'Brick & Stone Installation', description: 'Installation of brick and stone' },
    { name: 'Retaining Walls', description: 'Installation of retaining walls' },
    { name: 'Chimney Repair', description: 'Repair of chimneys' },
    { name: 'Concrete Work', description: 'Installation and repair of concrete' },
    { name: 'Paver Installation', description: 'Installation of pavers' },
    { name: 'Stone Veneer', description: 'Installation of stone veneer' }
  ],
  decks: [
    { name: 'Custom Deck Design', description: 'Custom design of decks' },
    { name: 'Deck Construction', description: 'Construction of new decks' },
    { name: 'Deck Repair', description: 'Repair of existing decks' },
    { name: 'Railing Installation', description: 'Installation of new railings' },
    { name: 'Deck Staining & Sealing', description: 'Staining and sealing of decks' },
    { name: 'Pergola Construction', description: 'Construction of pergolas' }
  ],
  flooring: [
    { name: 'Hardwood Installation', description: 'Installation of hardwood flooring' },
    { name: 'Tile Installation', description: 'Installation of tile flooring' },
    { name: 'Carpet Installation', description: 'Installation of carpet' },
    { name: 'Vinyl & Laminate', description: 'Installation of vinyl and laminate flooring' },
    { name: 'Floor Refinishing', description: 'Refinishing of existing floors' },
    { name: 'Subfloor Repair', description: 'Repair of subfloors' }
  ],
  windows: [
    { name: 'Window Installation', description: 'Installation of new windows' },
    { name: 'Window Replacement', description: 'Replacement of existing windows' },
    { name: 'Energy Efficient Updates', description: 'Updating windows for energy efficiency' },
    { name: 'Storm Windows', description: 'Installation of storm windows' },
    { name: 'Custom Window Design', description: 'Custom design of windows' },
    { name: 'Window Repair', description: 'Repair of existing windows' }
  ],
  fencing: [
    { name: 'Fence Installation', description: 'Installation of new fences' },
    { name: 'Gate Installation', description: 'Installation of new gates' },
    { name: 'Privacy Fencing', description: 'Installation of privacy fencing' },
    { name: 'Chain Link Fencing', description: 'Installation of chain link fencing' },
    { name: 'Wood Fence Construction', description: 'Construction of wood fences' },
    { name: 'Fence Repair', description: 'Repair of existing fences' }
  ]
};

export function generateContractorData(
  contractorType: string,
  pageType: string,
  services: Array<{ name: string; description: string }>
): ContractorPageData {
  const title = `Top ${contractorType}s in Denver - Licensed & Insured ${contractorType} Services`;
  const description = `Find the best ${contractorType.toLowerCase()}s in Denver. Professional, licensed, and insured ${contractorType.toLowerCase()} services for all your needs.`;

  const localBusiness = {
    name: `Denver ${contractorType} Services`,
    description,
    address: {
      "@type": "PostalAddress",
      streetAddress: "1234 Main St",
      addressLocality: "Denver",
      addressRegion: "CO",
      postalCode: "80014",
      addressCountry: "US"
    },
    geo: {
      "@type": "GeoCoordinates",
      latitude: 39.7392,
      longitude: -104.9903
    },
    url: `https://www.topcontractorsdenver.com/${pageType}`,
    telephone: "(720) 463-2319"
  };

  const breadcrumbItems = [
    {
      "@type": "ListItem",
      position: 1,
      item: {
        "@id": "https://www.topcontractorsdenver.com/",
        name: "Home"
      }
    },
    {
      "@type": "ListItem",
      position: 2,
      item: {
        "@id": `https://www.topcontractorsdenver.com/${pageType}`,
        name: `${contractorType}s`
      }
    }
  ];

  return {
    type: contractorType,
    title,
    description,
    services: services.map(service => service.name),
    serviceAreas,
    schema: {
      local: generateLocalBusinessSchema(localBusiness),
      breadcrumb: generateBreadcrumbSchema(breadcrumbItems)
    }
  };
}
