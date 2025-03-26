import { registerCustomElement, registerPorts } from "elm-mapbox";
import "mapbox-gl/dist/mapbox-gl.css";
import Example02 from "./Example02.elm";

const token = import.meta.env.VITE_MAPBOX_TOKEN;

registerCustomElement({ token });

Example02.init({ node: document.body });
// registerPorts(app);
