import { exec } from 'child_process';
import { promisify } from 'util';
import DirectoryGenerator from './generate-directory.js';
import { generateSitemaps } from './generate-sitemaps.js';
const execAsync = promisify(exec);
async function runCommand(command) {
    try {
        const { stdout, stderr } = await execAsync(command);
        console.log(stdout);
        if (stderr) {
            console.error(stderr);
        }
    }
    catch (error) {
        console.error('Error executing command:', error);
        throw error;
    }
}
async function generateAll() {
    try {
        const categories = ['plumbers', 'electricians', 'contractors'];
        const locations = ['denver', 'boulder', 'aurora'];
        const baseUrl = 'https://denvercontractors.com';
        // Generate directory structure
        const generator = new DirectoryGenerator(process.cwd());
        await generator.generateDirectory(categories, locations);
        // Generate sitemaps
        await generateSitemaps(baseUrl, categories, locations);
        console.log('Generation completed successfully!');
    }
    catch (error) {
        console.error('Error during generation:', error);
        process.exit(1);
    }
}
generateAll();
