const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function analyzeCategories() {
  console.log('Analyzing all categories...\n');

  // Get all categories first
  const { data: categories } = await supabase
    .from('categories')
    .select('id, category_name')
    .order('category_name');

  if (!categories) {
    console.log('No categories found');
    return;
  }

  // Get total contractor count
  const { count: totalCount } = await supabase
    .from('contractors')
    .select('*', { count: 'exact', head: true });

  console.log(`Total Contractors in Database: ${totalCount}\n`);
  
  // Analyze each category
  for (const category of categories) {
    const { data: contractors } = await supabase
      .from('contractors')
      .select(`
        *,
        subregions (
          subregion_name
        )
      `)
      .eq('category_id', category.id);

    const count = contractors?.length || 0;
    const percentage = ((count / totalCount) * 100).toFixed(1);

    console.log(`\n${category.category_name}: ${count} contractors (${percentage}%)`);
    
    if (count > 0) {
      // Group by subregion
      const bySubregion = contractors.reduce((acc, curr) => {
        const subregion = curr.subregions.subregion_name;
        if (!acc[subregion]) acc[subregion] = [];
        acc[subregion].push(curr);
        return acc;
      }, {});

      // Show distribution across subregions
      console.log('Distribution by subregion:');
      Object.entries(bySubregion)
        .sort(([, a], [, b]) => b.length - a.length)
        .forEach(([subregion, contractors]) => {
          const subPercentage = ((contractors.length / count) * 100).toFixed(1);
          console.log(`  ${subregion}: ${contractors.length} (${subPercentage}%)`);
        });
    }
  }

  // Summary statistics
  console.log('\n=== Summary Statistics ===');
  console.log(`Total Categories: ${categories.length}`);
  console.log(`Total Contractors: ${totalCount}`);
  console.log(`Average Contractors per Category: ${(totalCount / categories.length).toFixed(1)}`);

  // Categories below average
  console.log('\nCategories Below Average:');
  for (const category of categories) {
    const { count } = await supabase
      .from('contractors')
      .select('*', { count: 'exact', head: true })
      .eq('category_id', category.id);

    if (count < totalCount / categories.length) {
      const percentage = ((count / totalCount) * 100).toFixed(1);
      console.log(`${category.category_name}: ${count} (${percentage}%)`);
    }
  }
}

analyzeCategories()
  .catch(console.error)
  .finally(() => process.exit(0));
