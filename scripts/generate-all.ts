import { exec } from 'child_process';
import { promisify } from 'util';
import DirectoryGenerator from './generate-directory';
import { generateSitemaps } from './generate-sitemaps';

const execAsync = promisify(exec);

async function runCommand(command: string): Promise<void> {
  try {
    const { stdout, stderr } = await execAsync(command);
    console.log(stdout);
    if (stderr) console.error(stderr);
  } catch (error) {
    console.error(`Error executing command: ${command}`, error);
    throw error;
  }
}

async function generateAll() {
  console.log('🚀 Starting full site generation...');

  try {
    // 1. Generate directory pages
    console.log('\n📁 Generating directory pages...');
    const generator = new DirectoryGenerator();
    await generator.generateAllPages();

    // 2. Generate sitemaps
    console.log('\n🗺️ Generating sitemaps...');
    await generateSitemaps();

    // 3. Build the Next.js project
    console.log('\n🏗️ Building Next.js project...');
    await runCommand('next build');

    console.log('\n✅ Site generation completed successfully!');
  } catch (error) {
    console.error('\n❌ Error during site generation:', error);
    process.exit(1);
  }
}

generateAll(); 