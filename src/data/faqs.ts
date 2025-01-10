interface FAQ {
  question: string;
  answer: string;
}

interface TradeFAQs {
  [key: string]: FAQ[];
}

export const generalFAQs: FAQ[] = [
  {
    question: "How do you verify contractors?",
    answer: "We verify all contractors through a rigorous process that includes license verification, insurance checks, and review of past work history. We also collect and verify customer reviews to ensure quality service."
  },
  {
    question: "Are the contractors insured and licensed?",
    answer: "Yes, all contractors listed on our platform are required to maintain current licenses and insurance as required by Denver and Colorado state regulations. We regularly verify these credentials."
  },
  {
    question: "How do I choose the right contractor?",
    answer: "We recommend comparing multiple contractors based on their reviews, experience, pricing, and specialties. You can view detailed profiles, past work examples, and verified customer reviews to make an informed decision."
  },
  {
    question: "What areas do you serve?",
    answer: "We serve the entire Denver metropolitan area, including all suburbs and neighboring communities. Each contractor's specific service area is listed on their profile."
  }
];

export const tradeFAQs: TradeFAQs = {
  "Painters": [
    {
      question: "How much does it cost to paint a house in Denver?",
      answer: "The cost to paint a house in Denver typically ranges from $2,500 to $6,000 for exterior painting and $1,500 to $4,000 for interior painting. Factors affecting cost include house size, paint quality, surface preparation needs, and accessibility."
    },
    {
      question: "What type of paint is best for Denver's climate?",
      answer: "For Denver's climate, we recommend high-quality acrylic latex paints with UV protection for exteriors. These paints withstand extreme temperature changes, high altitude sun exposure, and occasional severe weather."
    },
    {
      question: "How often should I repaint my house in Denver?",
      answer: "In Denver's climate, exterior paint typically lasts 5-7 years, while interior paint can last 7-10 years. However, this varies based on sun exposure, weather conditions, and paint quality."
    }
  ],
  "Roofers": [
    {
      question: "How much does a new roof cost in Denver?",
      answer: "A new roof in Denver typically costs between $8,000 and $15,000 for an average-sized home. Costs vary based on materials chosen, roof size, pitch, and any existing damage repairs needed."
    },
    {
      question: "What roofing materials work best in Denver's climate?",
      answer: "Popular roofing materials for Denver include asphalt shingles (rated for high wind and hail), metal roofing, and concrete tiles. Each material offers different benefits for our unique climate and weather patterns."
    },
    {
      question: "How do I know if my roof needs replacement?",
      answer: "Signs you need a new roof include: shingles that are curling, cracking, or missing; granules in gutters; daylight visible through roof boards; sagging areas; and water damage in your attic. Most asphalt roofs last 20-25 years in Denver."
    }
  ],
  "Plumbers": [
    {
      question: "What are common plumbing issues in Denver homes?",
      answer: "Common plumbing issues in Denver include frozen pipes during winter, hard water mineral buildup, water pressure problems due to elevation, and aging pipe infrastructure in older neighborhoods."
    },
    {
      question: "How much do plumbers charge in Denver?",
      answer: "Denver plumbers typically charge $75-150 per hour, with most service calls starting at $150-200. Emergency services may cost more. Complex jobs are usually quoted as flat-rate projects."
    },
    {
      question: "How can I prevent frozen pipes in winter?",
      answer: "To prevent frozen pipes: insulate exposed pipes, keep garage doors closed, let faucets drip during extreme cold, maintain consistent indoor temperature, and know how to shut off your water main in emergencies."
    }
  ]
};

export function getFAQsForTrade(tradeName: string): FAQ[] {
  return tradeFAQs[tradeName] || generalFAQs;
}
