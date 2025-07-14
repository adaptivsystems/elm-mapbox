# elm-mapbox

This is a fork of `gampleman/elm-mapbox`, currently at a PRE-ALPHA stage, and is
not yet published to the npm or Elm package registries. Please file issues with
feedback or create threads on Slack.

---

Great looking and performant maps in Elm using MapboxGL. Discuss in #maps on the
Elm Slack.

## High quality maps in Elm

There have been
[some attempts](https://github.com/gampleman/elm-visualization/wiki/Data-Visualization-Packages#maps)
to make native elm mapping packages. However, Mapbox offers a very complex
solution that offers some killer features that are difficult to reproduce:

- client side high quality cartography
- high performance with large datasets

The way this works, the map accepts a configuration object called a **style**.
The main thing in a style is a list of **layers**. Layers control what you see
on the screen. Their order controls their layering. Each layer references a data
**source** and has a list of properties. Properties are a bit like CSS for maps
in the sense that you can use them to specify colors, line thickness, etc.
However, unlike CSS, the values that you pass to these use are **expressions**
in a little language, that allows you to style based on other factors like the
map's zoom level or actual data in any of the **features** being styled.

**Sources** specify how to get the data that powers the layers. Multiple layers
can take in a single source.

This library allows you to specify the **style** declaratively passing it into a
specific element in your view function. However, the map element holds some
internal state: mostly about the position of the viewport and all the event
handling needed to manipulate it. In my experience this is mostly what you
want - the default map interactions tend to be appropriate. So this library
includes commands that tell the map to modify its internal state (including
stuff like animations etc).

## How does this work?

This is a hybrid library that consists both of Elm and JavaScript parts. It uses
a combination of ports and custom elements for communication between them.

## Getting started

To get going, install the Elm package, the accompanying npm library, and the
`mapbox-gl` package (you'll need this as a direct dependency for its CSS file).

    # THIS FORK IS NOT YET PUBLISHED to JS or Elm package registries.
    # You'll need to manually "vendor" it into your codebase for now, using
    # commands like this, from your project's root directory:

    mkdir -p vendor
    git clone https://github.com/adaptivsystems/elm-mapbox vendor/elm-mapbox
    npm -C vendor/elm-mapbox install
    npm -C vendor/elm-mapbox run build
    npm add vendor/elm-mapbox mapbox-gl

    # Then you'll need to add "vendor/elm-mapbox/src" to your app's elm.json
    # `source-directories` array.

    # Unless you want to add as a git submodule, you might want to delete
    # the repository's .git folder so you can add its contents to your own
    # project's git repository.
    rm -rf vendor/elm-mapbox/.git

    # Eventually, we plan to make these commands work:
    # elm install adaptivsystems/elm-mapbox
    # npm add @adaptivsystems/elm-mapbox mapbox-gl

Old versions of Microsoft Edge need a polyfill to use custom elements. The
polyfill provided by webcomponents.org is known to work
https://github.com/webcomponents/custom-elements:

    npm add @webcomponents/custom-elements

Then include the library into your page. How exactly to do this depends on how
you are building your application. We recommend using
[Parcel](https://parceljs.org/), since it is super easy to setup. Then you will
want to make your `index.js` look something like this:

```javascript
// Polyfill for custom elements. Optional; see https://caniuse.com/#feat=custom-elementsv1
import "@webcomponents/custom-elements";

import { registerCustomElement, registerPorts } from "elm-mapbox";

// Bring in Mapbox's required CSS
import "mapbox-gl/dist/mapbox-gl.css";

// Your Elm application
import { Elm } from "./src/Main.elm";

// Mapbox API token. Register at https://mapbox.com to get one of these for free.
const token = "pk.eyJ1Ijovm,vedfg";

// This will add elm-mapbox's custom element into the page's registry.
// This **must** happen before your application attempts to render a map.
registerCustomElement({
  token,
});

// Initialize your Elm application. There are a few different ways
// to do this. Whichever you choose doesn't matter.
const app = Elm.Main.init({ flags: {} });

// Register ports. You only need to do this if you use the port integration.
// I usually keep this commented out until I need it.
registerPorts(app);
```

Next, optionally, set up a ports module. The best way to do this is to to copy
[this file](https://github.com/adaptivsystems/elm-mapbox/blob/main/examples/MapCommands.elm)
into your project. I usually name it `Map/Cmd.elm`. This will allow you to
easily use the commands to control parts of your map interactions
imperatively--for example, you can command your map to fly to a particular
location.

Finally, you will need to setup a base style. You can copy some of the
[example styles](https://github.com/adaptivsystems/elm-mapbox/blob/main/examples/Styles),
or you can use the (beta)
[Style code generator](https://github.com/adaptivsystems/elm-mapbox/blob/main/style-generator/)
in conjunction with [Mapbox Studio](https://www.mapbox.com/mapbox-studio/).

## Example

See
[Example01](https://github.com/adaptivsystems/elm-geospatial/blob/main/examples/src/Example01.elm)
for an example application.

## Browser support

This library is supported in all modern browsers. The `elmMapbox` library has a
`supported` function that can be injected via flags:

```javascript
import { supported } from "elm-mapbox";

const app = Elm.MyApp.fullscreen({
  mapboxSupported: supported({
    // If  true , the function will return  false if the performance of
    // Mapbox GL JS would be dramatically worse than expected (e.g. a
    // software WebGL renderer would be used).
    failIfMajorPerformanceCaveat: true,
  }),
});
```

## Customizing the JS side

The `registerCustomElement` function accepts an options object that takes the
following options:

- `token`: the Mapbox token. If you don't pass it here, you will need to use the
  `token` Elm attribute.
- `onMount` a callback that gives you access to the mapbox instance whenever a
  map gets instantiated. Mostly useful for registering
  [plugins](https://www.mapbox.com/mapbox-gl-js/plugins).

Furthermore, the elm-mapbox element exposes its internal mapboxgl.js reference
as a `map` property, which you can use if necessary (although, worth mentioning
on Slack if you are needing to do this).

The `registerPorts` function accepts an option object that takes the following
options:

- `incomingPort`: Name of the incoming messages port (defaults to
  `elmMapboxIncoming`)
- `outgoingPort`: Name of the outgoing messages port (defaults to
  `elmMapboxOutgoing`)
- `easingFunctions`: CURRENTLY IGNORED - patches welcome!

## License

(c) Jakub Hampl 2018, 2019

MIT License
