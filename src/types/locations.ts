export interface LocationSubcategory {
  name: string;
  areas: string[];
}

export interface LocationCategory {
  name: string;
  subcategories: LocationSubcategory[];
}

export const DENVER_LOCATIONS: LocationCategory[] = [
  {
    name: "Central Denver Neighborhoods",
    subcategories: [
      {
        name: "Downtown Area",
        areas: [
          "Downtown Denver",
          "Capitol Hill",
          "Union Station",
          "Five Points"
        ]
      },
      {
        name: "Central Parks",
        areas: [
          "City Park",
          "City Park West",
          "Cheesman Park",
          "Congress Park"
        ]
      },
      {
        name: "Central Shopping",
        areas: [
          "Cherry Creek",
          "Lincoln Park",
          "North Capitol Hill"
        ]
      }
    ]
  },
  {
    name: "East Denver Neighborhoods",
    subcategories: [
      {
        name: "Park Hill Area",
        areas: [
          "Park Hill",
          "North Park Hill",
          "Northeast Park Hill",
          "South Park Hill"
        ]
      },
      {
        name: "Northeast Area",
        areas: [
          "Stapleton (Central Park)",
          "Montbello",
          "Green Valley Ranch",
          "Gateway – Green Valley Ranch"
        ]
      },
      {
        name: "East Colfax Area",
        areas: [
          "East Colfax",
          "Skyland"
        ]
      }
    ]
  },
  {
    name: "Denver Suburbs",
    subcategories: [
      {
        name: "Northwest Suburbs",
        areas: [
          "Westminster",
          "Arvada",
          "Wheat Ridge",
          "Edgewater",
          "Golden"
        ]
      },
      {
        name: "Northeast Suburbs",
        areas: [
          "Thornton",
          "Northglenn",
          "Brighton",
          "Commerce City"
        ]
      },
      {
        name: "Southeast Suburbs",
        areas: [
          "Centennial",
          "Highlands Ranch",
          "Parker",
          "Lone Tree",
          "Greenwood Village"
        ]
      },
      {
        name: "Southwest Suburbs",
        areas: [
          "Littleton",
          "Englewood"
        ]
      }
    ]
  },
  {
    name: "Boulder & Surrounding Areas",
    subcategories: [
      {
        name: "Boulder Area",
        areas: [
          "Boulder",
          "Lafayette",
          "Louisville",
          "Superior"
        ]
      }
    ]
  },
  {
    name: "Outer Surrounding Cities",
    subcategories: [
      {
        name: "Extended Service Area",
        areas: [
          "Aurora",
          "Castle Rock",
          "Loveland"
        ]
      }
    ]
  }
];
