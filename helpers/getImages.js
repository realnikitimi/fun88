import { firefox } from "playwright";
import fs from "node:fs";

const url = "https://www.fun88.mx";
const browser = await firefox.launch({
  headless: false,
});

browser
  .newPage({
    baseURL: url,
  })
  .then(async (page) => {
    await page.goto("/casino/introcio");
    page.on("requestfinished", async (request) => {
      const response = await request.response();
      const parsedURL = new URL(request.url());
      const lastDividerIndex = parsedURL.pathname.lastIndexOf("/");
      const pathname = parsedURL.pathname.substring(
        lastDividerIndex,
        parsedURL.pathname.length
      );
      const validImageExtensions = ["webp", "png", "gif", "svg"];
      const extension = pathname.split(".")[1];

      if (!extension) return console.warn("no file extension.");
      if (!validImageExtensions.includes(extension.trim())) {
        return console.warn("not valid image type.");
      }
      if (!response || !response.ok()) return console.warn("Response is null");
      switch (request.resourceType()) {
        case "image":
          fs.writeFileSync(
            new URL(`./assets/${pathname}`, import.meta.url),
            await response.body()
          );
          break;
        default:
          break;
      }
    });
  })
  .catch((err) => {
    browser.close();
    console.log(err.message);
  });

browser.once("disconnected", () => process.exit());
