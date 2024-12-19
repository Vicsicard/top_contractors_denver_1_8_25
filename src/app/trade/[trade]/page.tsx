import React from 'react';
import { Suspense } from 'react';
import type { Metadata } from 'next';
import ContractorLayout from '@/components/ContractorLayout';
import { generateContractorData, contractorServices, serviceAreas } from '@/utils/contractorPageUtils';

type Props = {
  params: {
    trade: string;
  };
};

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const tradeName = params.trade
    .split('-')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');

  const contractorData = generateContractorData(
    tradeName,
    params.trade,
    params.trade === 'epoxy-garage' 
      ? ['Epoxy Floor Installation', 'Garage Floor Coating', 'Floor Preparation', 'Concrete Repair', 'Custom Designs']
      : contractorServices[params.trade]?.map(service => service.name) || []
  );

  return {
    title: `${contractorData.title} | Denver Contractors`,
    description: contractorData.description,
    openGraph: {
      title: `${contractorData.title} | Denver Contractors`,
      description: contractorData.description,
      url: `https://www.topcontractorsdenver.com/${params.trade}`,
      siteName: 'Denver Contractors',
      locale: 'en_US',
      type: 'website',
    },
  };
}

export default function TradePage({ params }: Props) {
  const tradeName = params.trade
    .split('-')
    .map(word => word.charAt(0).toUpperCase() + word.slice(1))
    .join(' ');

  const contractorData = generateContractorData(
    tradeName,
    params.trade,
    params.trade === 'epoxy-garage'
      ? ['Epoxy Floor Installation', 'Garage Floor Coating', 'Floor Preparation', 'Concrete Repair', 'Custom Designs']
      : contractorServices[params.trade]?.map(service => service.name) || []
  );

  return (
    <ContractorLayout
      title={contractorData.title}
      description={contractorData.description}
      services={contractorData.services}
      searchQuery={`${tradeName} contractors`}
      location="Denver, CO"
      areas={serviceAreas}
    />
  );
}
