/* eslint-disable */
// @ts-nocheck
import Main from "./src/Main.elm";
import { migrate } from "@mapbox/mapbox-gl-style-spec";
import CodeMirror from "codemirror/lib/codemirror.js";
import "codemirror/lib/codemirror.css";
import "codemirror/theme/base16-light.css";
import "codemirror/mode/elm/elm.js";
import "codemirror/mode/javascript/javascript.js";

// This code comes from "@mapbox/mapbox-gl-style-spec/migrate/deref.js"
function deref(layer) {
  const result = {};
  for (const k in layer) {
    if (k !== "ref") {
      result[k] = layer[k];
    }
  }
  return result;
}

customElements.define(
  "code-editor",
  class extends HTMLElement {
    constructor() {
      super();
      this._editorValue = "";
    }

    get editorValue() {
      return this._editorValue;
    }

    set editorValue(value) {
      if (this._editorValue === value) return;
      this._editorValue = value;
      if (!this._editor) return;
      this._editor.setValue(value);
    }

    get readonly() {
      return this._readonly;
    }

    set readonly(value) {
      this._readonly = value;
      if (!this._editor) return;
      this._editor.setOption("readonly", value);
    }

    get mode() {
      return this._mode;
    }

    set mode(value) {
      this._mode = value;
      if (!this._editor) return;
      this._editor.setOption("mode", value);
    }

    connectedCallback() {
      this._editor = CodeMirror(this, {
        identUnit: 4,
        mode: this._mode,
        lineNumbers: true,
        value: this._editorValue,
        readOnly: this._readonly,
        lineWrapping: true,
      });

      this._editor.on("changes", () => {
        this._editorValue = this._editor.getValue();
        console.log("changes", this._editorValue);
        this.dispatchEvent(
          new CustomEvent("editorChanged", { detail: this._editorValue }),
        );
      });

      const { width, height } = this.getBoundingClientRect();
      this._editor.setSize(width, height);
    }
  },
);

const app = Main.init({});
app.ports.requestStyleUpgrade.subscribe((style) => {
  try {
    const parsed = JSON.parse(style);
    const migrated = migrate(parsed);
    console.dir({ parsed, migrated });
    const result = deref(migrated);
    app.ports.styleUpgradeComplete.send({ type: "Ok", result });
  } catch (error) {
    app.ports.styleUpgradeComplete.send({
      type: "Err",
      error: { message: `${error.name}: ${error.message}` },
    });
  }
});
