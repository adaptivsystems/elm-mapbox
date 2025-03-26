import process from "node:process";
import { defineConfig } from "vite";
import elm from "vite-plugin-elm-watch";

if (!process.env.VITE_MAPBOX_TOKEN) {
  console.error("Error: Missing VITE_MAPBOX_TOKEN in environment");
  process.exit(1);
}

export default defineConfig({
  plugins: [elm()],
  optimizeDeps: {
    // Prevent this Vite in-browser error:
    // > Could not auto-determine entry point from rollupOptions or html files
    // > and there are no explicit optimizeDeps.include patterns. Skipping
    // > dependency pre-bundling.
    include: [],
  },
  server: {
    allowedHosts: ["localhost"],
  },
});
