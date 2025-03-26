import { defineConfig } from "vite";
import elm from "vite-plugin-elm-watch";

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
