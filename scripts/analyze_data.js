const { createClient } = require('@supabase/supabase-js');
require('dotenv').config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const supabase = createClient(supabaseUrl, supabaseKey);

async function analyzeDistribution() {
  console.log('Analyzing contractor distribution...\n');

  // Get total count
  const { count: totalCount } = await supabase
    .from('contractors')
    .select('*', { count: 'exact', head: true });

  console.log(`Total Contractors: ${totalCount}\n`);

  // Analyze category distribution
  const { data: categoryData } = await supabase
    .from('contractors')
    .select(`
      categories (
        category_name
      )
    `);

  const categoryDistribution = categoryData.reduce((acc, curr) => {
    const categoryName = curr.categories.category_name;
    acc[categoryName] = (acc[categoryName] || 0) + 1;
    return acc;
  }, {});

  console.log('Category Distribution:');
  console.log('---------------------');
  Object.entries(categoryDistribution)
    .sort(([, a], [, b]) => b - a)
    .forEach(([category, count]) => {
      const percentage = (count / totalCount * 100).toFixed(1);
      console.log(`${category}: ${count} (${percentage}%)`);
    });

  // Analyze subregion distribution
  const { data: subregionData } = await supabase
    .from('contractors')
    .select(`
      subregions (
        subregion_name
      )
    `);

  const subregionDistribution = subregionData.reduce((acc, curr) => {
    const subregionName = curr.subregions.subregion_name;
    acc[subregionName] = (acc[subregionName] || 0) + 1;
    return acc;
  }, {});

  console.log('\nSubregion Distribution:');
  console.log('---------------------');
  Object.entries(subregionDistribution)
    .sort(([, a], [, b]) => b - a)
    .forEach(([subregion, count]) => {
      const percentage = (count / totalCount * 100).toFixed(1);
      console.log(`${subregion}: ${count} (${percentage}%)`);
    });

  // Find categories with low coverage
  console.log('\nCategories with Low Coverage (<5%):');
  console.log('--------------------------------');
  Object.entries(categoryDistribution)
    .filter(([, count]) => count / totalCount < 0.05)
    .forEach(([category, count]) => {
      const percentage = (count / totalCount * 100).toFixed(1);
      console.log(`${category}: ${count} (${percentage}%)`);
    });

  // Find subregions with low coverage
  console.log('\nSubregions with Low Coverage (<5%):');
  console.log('--------------------------------');
  Object.entries(subregionDistribution)
    .filter(([, count]) => count / totalCount < 0.05)
    .forEach(([subregion, count]) => {
      const percentage = (count / totalCount * 100).toFixed(1);
      console.log(`${subregion}: ${count} (${percentage}%)`);
    });

  // Calculate average contractors per category and subregion
  const avgPerCategory = totalCount / Object.keys(categoryDistribution).length;
  const avgPerSubregion = totalCount / Object.keys(subregionDistribution).length;

  console.log('\nSummary Statistics:');
  console.log('------------------');
  console.log(`Average contractors per category: ${avgPerCategory.toFixed(1)}`);
  console.log(`Average contractors per subregion: ${avgPerSubregion.toFixed(1)}`);
}

analyzeDistribution()
  .catch(console.error)
  .finally(() => process.exit(0));
