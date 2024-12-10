import fs from 'fs/promises';
import path from 'path';
export default class DirectoryGenerator {
    baseDir;
    constructor(baseDir) {
        this.baseDir = baseDir;
    }
    async generateDirectory(categories, locations) {
        for (const category of categories) {
            for (const location of locations) {
                const dirPath = path.join(this.baseDir, 'src', 'app', category, location);
                await fs.mkdir(dirPath, { recursive: true });
            }
        }
    }
}
