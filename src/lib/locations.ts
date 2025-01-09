export interface Location {
  name: string;
  slug: string;
  areas: {
    [key: string]: {
      name: string;
      slug: string;
      neighborhoods: {
        name: string;
        slug: string;
      }[];
    };
  };
}

export const denverRegions: { [key: string]: Location } = {
  "central-denver": {
    name: "Central Denver",
    slug: "central-denver",
    areas: {
      "downtown-area": {
        name: "Downtown Area",
        slug: "downtown-area",
        neighborhoods: [
          { name: "Downtown Denver", slug: "downtown-denver" },
          { name: "Capitol Hill", slug: "capitol-hill" },
          { name: "Union Station", slug: "union-station" },
          { name: "Five Points", slug: "five-points" }
        ]
      },
      "central-parks": {
        name: "Central Parks",
        slug: "central-parks",
        neighborhoods: [
          { name: "City Park", slug: "city-park" },
          { name: "City Park West", slug: "city-park-west" },
          { name: "Cheesman Park", slug: "cheesman-park" },
          { name: "Congress Park", slug: "congress-park" }
        ]
      },
      "central-shopping": {
        name: "Central Shopping",
        slug: "central-shopping",
        neighborhoods: [
          { name: "Cherry Creek", slug: "cherry-creek" },
          { name: "Lincoln Park", slug: "lincoln-park" },
          { name: "North Capitol Hill", slug: "north-capitol-hill" }
        ]
      }
    }
  },
  "east-denver": {
    name: "East Denver",
    slug: "east-denver",
    areas: {
      "park-hill-area": {
        name: "Park Hill Area",
        slug: "park-hill-area",
        neighborhoods: [
          { name: "Park Hill", slug: "park-hill" },
          { name: "North Park Hill", slug: "north-park-hill" },
          { name: "Northeast Park Hill", slug: "northeast-park-hill" },
          { name: "South Park Hill", slug: "south-park-hill" }
        ]
      },
      "northeast-area": {
        name: "Northeast Area",
        slug: "northeast-area",
        neighborhoods: [
          { name: "Stapleton (Central Park)", slug: "stapleton-central-park" },
          { name: "Montbello", slug: "montbello" },
          { name: "Green Valley Ranch", slug: "green-valley-ranch" },
          { name: "Gateway – Green Valley Ranch", slug: "gateway-green-valley-ranch" }
        ]
      },
      "east-colfax-area": {
        name: "East Colfax Area",
        slug: "east-colfax-area",
        neighborhoods: [
          { name: "East Colfax", slug: "east-colfax" },
          { name: "Skyland", slug: "skyland" }
        ]
      }
    }
  },
  "denver-suburbs": {
    name: "Denver Suburbs",
    slug: "denver-suburbs",
    areas: {
      "northwest-suburbs": {
        name: "Northwest Suburbs",
        slug: "northwest-suburbs",
        neighborhoods: [
          { name: "Westminster", slug: "westminster" },
          { name: "Arvada", slug: "arvada" },
          { name: "Wheat Ridge", slug: "wheat-ridge" },
          { name: "Edgewater", slug: "edgewater" },
          { name: "Golden", slug: "golden" }
        ]
      },
      "northeast-suburbs": {
        name: "Northeast Suburbs",
        slug: "northeast-suburbs",
        neighborhoods: [
          { name: "Thornton", slug: "thornton" },
          { name: "Northglenn", slug: "northglenn" },
          { name: "Brighton", slug: "brighton" },
          { name: "Commerce City", slug: "commerce-city" }
        ]
      },
      "southeast-suburbs": {
        name: "Southeast Suburbs",
        slug: "southeast-suburbs",
        neighborhoods: [
          { name: "Centennial", slug: "centennial" },
          { name: "Highlands Ranch", slug: "highlands-ranch" },
          { name: "Parker", slug: "parker" },
          { name: "Lone Tree", slug: "lone-tree" },
          { name: "Greenwood Village", slug: "greenwood-village" }
        ]
      },
      "southwest-suburbs": {
        name: "Southwest Suburbs",
        slug: "southwest-suburbs",
        neighborhoods: [
          { name: "Littleton", slug: "littleton" },
          { name: "Englewood", slug: "englewood" }
        ]
      }
    }
  }
};
