import { JsonLd } from "@/components/json-ld";

interface FAQ {
  question: string;
  answer: string;
}

interface TradeFAQProps {
  trade: string;
  faqs: FAQ[];
}

export function TradeFAQ({ trade, faqs }: TradeFAQProps) {
  console.log('Rendering FAQ for trade:', trade);
  console.log('Number of FAQs:', faqs.length);

  const schema = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": faqs.map(faq => ({
      "@type": "Question",
      "name": faq.question,
      "acceptedAnswer": {
        "@type": "Answer",
        "text": faq.answer
      }
    }))
  };

  return (
    <>
      <JsonLd data={schema} />
      <section className="py-12 bg-gray-50">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold text-center mb-8">
            Frequently Asked Questions About {trade} Services in Denver
          </h2>
          <div className="max-w-3xl mx-auto space-y-6">
            {faqs.map((faq, index) => (
              <div key={index} className="bg-white rounded-lg shadow-sm p-6">
                <h3 className="text-xl font-semibold mb-3">{faq.question}</h3>
                <p className="text-gray-600">{faq.answer}</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </>
  );
}
