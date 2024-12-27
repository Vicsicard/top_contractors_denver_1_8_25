import { ContractorForm } from "@/components/contractor-form";

export default function Home() {
  return (
    <main className="min-h-screen bg-background">
      <div className="container mx-auto py-10">
        <div className="space-y-6">
          <div className="space-y-2">
            <h1 className="text-3xl font-bold tracking-tight">Contractor Directory</h1>
            <p className="text-muted-foreground">
              Find and connect with trusted contractors in your area.
            </p>
          </div>

          <div className="rounded-lg border bg-card p-6">
            <div className="space-y-4">
              <div className="space-y-2">
                <h2 className="text-xl font-semibold tracking-tight">Add New Contractor</h2>
                <p className="text-sm text-muted-foreground">
                  Fill out the form below to add a new contractor to our directory.
                </p>
              </div>
              <ContractorForm />
            </div>
          </div>
        </div>
      </div>
    </main>
  );
}
