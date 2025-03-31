import { defineConfig } from "rollup";
import typescript from "@rollup/plugin-typescript";
import pkg from "./package.json" with { type: "json" };

export default defineConfig({
  // The file is named this so that TS emits its declaration file with the same
  // name as our output file.
  input: "src/js/elm-mapbox.mts",
  external: ["mapbox-gl"],
  output: {
    file: pkg.module,
    format: "module",
    sourcemap: true,
  },
  plugins: [
    typescript({
      compilerOptions: {},
    }),
  ],
});
