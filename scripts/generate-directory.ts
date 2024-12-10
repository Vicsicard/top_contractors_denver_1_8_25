import fs from 'fs/promises';
import path from 'path';

export default class DirectoryGenerator {
  private readonly baseDir: string;

  constructor(baseDir: string) {
    this.baseDir = baseDir;
  }

  async generateDirectory(categories: string[], locations: string[]): Promise<void> {
    for (const category of categories) {
      for (const location of locations) {
        const dirPath = path.join(this.baseDir, 'src', 'app', category, location);
        await fs.mkdir(dirPath, { recursive: true });
      }
    }
  }
}
