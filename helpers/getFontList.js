import fs from "node:fs";

const relativeDirectory = "assets/fonts/";
const fontDirectoryURL = new URL(`../${relativeDirectory}`, import.meta.url);
const contents = fs.readdirSync(fontDirectoryURL);

console.info(contents.map((s) => relativeDirectory + s));
