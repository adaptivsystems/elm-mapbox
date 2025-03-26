import { defineConfig } from "rollup";
import typescript from "@rollup/plugin-typescript";
import pkg from "./package.json" with { type: "json" };

export default defineConfig({
  input: "src/js/main.mts",
  external: ["mapbox-gl"],
  output: {
    file: pkg.module,
    format: "module",
  },
  plugins: [typescript()],
});
