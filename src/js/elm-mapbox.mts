import mapboxgl, {
  EasingOptions,
  FeatureSelector,
  FilterSpecification,
  LngLatBoundsLike,
  LngLatLike,
  MapEventOf,
  MapEventType,
  PointLike,
  StyleSpecification,
} from "mapbox-gl";

type Command = (map: mapboxgl.Map) => void;
type FeatureState = {
  [_: string]: unknown;
};
type Options = {
  onMount?: (map: mapboxgl.Map, customElement: HTMLElement) => void;
  token?: string;
};

// Types copied from mapbox-gl's typedefs because they're not exported.
type QueryRenderedFeaturesParams = {
  layers?: string[];
  filter?: FilterSpecification;
  validate?: boolean;
  target?: never;
};
type Listener<T extends MapEventType> = (event: MapEventOf<T>) => void;

const commandRegistry: Record<string, Command[]> = {};

export function registerCustomElement(settings: Options) {
  const options = Object.assign(
    {
      onMount() {},
    },
    settings,
  );
  if (options.token) {
    mapboxgl.accessToken = options.token;
  }
  window.customElements.define(
    "elm-mapbox-map",
    class MapboxMap extends HTMLElement {
      private _bearing?: number;
      private _center?: LngLatLike;
      private _eventListenerMap: Map<
        Listener<MapEventType>,
        Listener<MapEventType>
      >;
      private _eventRegistrationQueue: {
        [T in MapEventType]?: Listener<Extract<T, MapEventType>>[];
      };
      private _featureState?: [Required<FeatureSelector>, FeatureState][];
      private _map?: mapboxgl.Map;
      private _maxBounds?: LngLatBoundsLike;
      private _maxZoom?: number;
      private _minZoom?: number;
      private _pitch?: number;
      private _refreshExpiredTiles: boolean;
      private _renderWorldCopies: boolean;
      private _style?: StyleSpecification | string;
      private _zoom?: number;
      eventFeaturesLayers: string[]; // NEVER SET
      eventFeaturesFilter: FilterSpecification; // NEVER SET
      interactive: boolean; // ONLY SET TO true
      logoPosition?: mapboxgl.ControlPosition; // NEVER SET
      token: undefined; // NEVER SET

      constructor() {
        super();
        this._eventListenerMap = new Map();
        this._eventRegistrationQueue = {};
        this._refreshExpiredTiles = true;
        this._renderWorldCopies = true;
        this.interactive = true;
      }

      get mapboxStyle(): typeof this._style {
        return this._style;
      }

      set mapboxStyle(value: StyleSpecification | string) {
        if (this._map) this._map.setStyle(value);
        this._style = value;
      }

      get minZoom() {
        return this._minZoom;
      }
      set minZoom(value) {
        if (this._map) this._map.setMinZoom(value);
        this._minZoom = value;
      }

      get maxZoom() {
        return this._maxZoom;
      }
      set maxZoom(value) {
        if (this._map) this._map.setMaxZoom(value);
        this._maxZoom = value;
      }

      get map() {
        return this._map;
      }

      get maxBounds(): LngLatBoundsLike | undefined {
        return this._maxBounds;
      }
      set maxBounds(value: LngLatBoundsLike) {
        if (this._map) this._map.setMaxBounds(value);
        this._maxBounds = value;
      }

      get renderWorldCopies() {
        return this._renderWorldCopies;
      }
      set renderWorldCopies(value) {
        if (this._map) this._map.setRenderWorldCopies(value);
        this._renderWorldCopies = value;
      }

      get center(): LngLatLike | undefined {
        return this._center;
      }
      set center(value: LngLatLike) {
        if (this._map) this._map.setCenter(value);
        this._center = value;
      }

      get zoom(): number | undefined {
        return this._zoom;
      }
      set zoom(value: number) {
        if (this._map) this._map.setZoom(value);
        this._zoom = value;
      }

      get bearing(): number | undefined {
        return this._bearing;
      }
      set bearing(value: number) {
        if (this._map) this._map.setBearing(value);
        this._bearing = value;
      }

      get pitch(): number | undefined {
        return this._pitch;
      }
      set pitch(value: number) {
        if (this._map) this._map.setPitch(value);
        this._pitch = value;
      }

      get featureState(): typeof this._featureState {
        return this._featureState;
      }
      set featureState(value: NonNullable<typeof this._featureState>) {
        // TODO: Clean this up
        function makeId({
          id,
          source,
          sourceLayer,
        }: {
          id: string | number;
          source: string;
          sourceLayer: string;
        }) {
          return `${id}::${source}::${sourceLayer}`;
        }
        if (this._map && this._featureState) {
          const map = new Map(
            this._featureState.map(([feature, state]) => [
              makeId(feature),
              { feature, state },
            ]),
          );
          value.forEach(([feature, state]) => {
            const id = makeId(feature);
            if (map.has(id)) {
              const prevValue = map.get(id)!.state;
              const keys = Object.keys(prevValue);
              const newValue: Record<string, unknown> = {};
              keys.forEach((k) => {
                if (state[k] === undefined) {
                  newValue[k] = undefined;
                }
              });
              this._map!.setFeatureState(
                feature,
                Object.assign(newValue, state),
              );
            } else {
              this._map!.setFeatureState(feature, state);
            }
            map.delete(id);
          });

          map.forEach(({ feature, state }) => {
            const keys = Object.keys(state);
            const newValue: Record<string, unknown> = {};
            keys.forEach((k) => {
              newValue[k] = undefined;
            });
            this._map!.setFeatureState(feature, newValue);
          });
        }

        this._featureState = value;
      }

      addEventListener<T extends MapEventType>(
        type: T,
        fn: Listener<Extract<T, MapEventType>>,
      ): this {
        if (this._map) {
          // Wrap the listener--which will likely be an Elm function--in order
          // to sneakily give it a proxy object so we can get information it
          // needs from the map object.
          const wrapped: Listener<Extract<T, MapEventType>> = (e) =>
            fn(
              new Proxy(e, {
                has: (obj, prop) =>
                  prop in obj ||
                  (typeof prop === "string" &&
                    ((prop === "features" && obj["point"]) ||
                      (prop === "perPointFeatures" && obj["points"]) ||
                      ((prop.slice(0, 2) === "is" ||
                        prop.slice(0, 3) === "get") &&
                        prop in this._map &&
                        typeof this._map[prop] === "function"))),
                get: (obj, prop) => {
                  if (prop in obj) {
                    return obj[prop];
                  } else if (prop === "features" && obj["point"]) {
                    return this._map.queryRenderedFeatures(obj["point"], {
                      layers: this.eventFeaturesLayers,
                      filter: this.eventFeaturesFilter,
                    });
                  } else if (
                    prop === "perPointFeatures" &&
                    obj["points"] &&
                    Array.isArray(obj["points"])
                  ) {
                    return obj["points"].map(
                      (point: PointLike | [PointLike, PointLike]) =>
                        this._map.queryRenderedFeatures(point, {
                          layers: this.eventFeaturesLayers,
                          filter: this.eventFeaturesFilter,
                        }),
                    );
                  } else if (
                    typeof prop === "string" &&
                    (prop.slice(0, 2) === "is" || prop.slice(0, 3) === "get") &&
                    prop in this._map &&
                    typeof this._map[prop] === "function"
                  ) {
                    try {
                      return this._map[prop]();
                    } catch (_) {
                      return undefined;
                    }
                  }
                  return undefined;
                },
              }),
            );
          this._eventListenerMap.set(fn, wrapped);
          this._map.on(type, wrapped);
        } else {
          this._eventRegistrationQueue[type] =
            this._eventRegistrationQueue[type] || [];
          this._eventRegistrationQueue[type].push(fn);
        }
        return this;
      }

      removeEventListener<T extends MapEventType>(
        type: T,
        fn: Listener<Extract<T, MapEventType>>,
      ): this {
        if (this._map) {
          const wrapped: Listener<Extract<T, MapEventType>> =
            this._eventListenerMap.get(fn);
          this._eventListenerMap.delete(fn);
          this._map.off(type, wrapped);
        } else {
          const queue = this._eventRegistrationQueue[type] || [];
          const index = queue.findIndex(fn);
          if (index >= 0) {
            queue.splice(index, 1);
          }
        }
        return this;
      }

      _createMapInstance() {
        const mapOptions: mapboxgl.MapOptions = {
          container: this,
          style: this._style,
          minZoom: this._minZoom || 0,
          maxZoom: this._maxZoom || 22,
          interactive: this.interactive,
          attributionControl: false,
          logoPosition: this.logoPosition || "bottom-left",
          refreshExpiredTiles: this._refreshExpiredTiles,
          maxBounds: this._maxBounds,
          renderWorldCopies: this._renderWorldCopies,
        };
        if (this._center) {
          mapOptions.center = this._center;
        }
        if (this._zoom) {
          mapOptions.zoom = this._zoom;
        }
        if (this._bearing) {
          mapOptions.bearing = this._bearing;
        }
        if (this._pitch) {
          mapOptions.pitch = this._pitch;
        }
        this._map = new mapboxgl.Map(mapOptions);

        Object.entries(this._eventRegistrationQueue).map(
          ([type, listeners]: [MapEventType, Listener<MapEventType>[]]) => {
            listeners.forEach((listener) => {
              this.addEventListener(type, listener);
            });
          },
        );
        this._eventRegistrationQueue = {};
        options.onMount(this._map, this);
        if (commandRegistry[this.id]) {
          this._map.on("load", () => {
            let cmd: undefined | ((map: mapboxgl.Map) => void);
            while ((cmd = commandRegistry[this.id].shift())) {
              cmd(this._map!);
            }
          });
        }
        return this._map;
      }

      connectedCallback() {
        if (this.token) {
          mapboxgl.accessToken = this.token;
        }
        this.style.display = "block";
        this.style.width = "100%";
        this.style.height = "100%";

        this._upgradeProperty("mapboxStyle");
        this._upgradeProperty("minZoom");
        this._upgradeProperty("maxZoom");
        this._upgradeProperty("maxBounds");
        this._upgradeProperty("renderWorldCopies");
        this._upgradeProperty("center");
        this._upgradeProperty("zoom");
        this._upgradeProperty("bearing");
        this._upgradeProperty("pitch");
        this._upgradeProperty("featureState");

        this._map = this._createMapInstance();
      }

      _upgradeProperty(prop: string) {
        if (this.hasOwnProperty(prop)) {
          const value = this[prop];
          delete this[prop];
          this[prop] = value;
        }
      }

      disconnectedCallback() {
        this._map?.remove();
        delete this._map;
      }
    },
  );
}

type ElmApp = {
  ports?: Record<string, Port>;
};

type AnimationPortCommand = { target: string; options: EasingOptions } & (
  | { command: "resize" }
  | { command: "fitBounds"; bounds: LngLatBoundsLike }
  | { command: "panBy"; offset: PointLike }
  | { command: "panTo"; location: LngLatLike }
  | { command: "zoomTo"; zoom: number }
  | { command: "zoomIn" }
  | { command: "zoomOut" }
  | { command: "rotateTo"; bearing: number }
  | { command: "jumpTo" }
  | { command: "easeTo" }
  | { command: "flyTo" }
  | { command: "stop" }
);
type QueryPortCommand = { target: string } & (
  | { command: "setRTLTextPlugin"; url: string }
  | { command: "getBounds"; requestId: string }
  | {
      command: "queryRenderedFeatures";
      geometry: PointLike | [PointLike, PointLike];
      requestId: string;
      options: QueryRenderedFeaturesParams;
    }
);

type PortCommand = AnimationPortCommand | QueryPortCommand;

type Port = {
  send?: (data: unknown) => void;
  subscribe?: (callback: (command: PortCommand) => unknown) => void;
};
type RegisterPortsOptions = {
  outgoingPort: string;
  incomingPort: string;
  easingFunctions: Record<string, (t: number) => number>;
};

export function registerPorts(
  elmApp: ElmApp,
  settings: Partial<RegisterPortsOptions> = {},
) {
  const options: RegisterPortsOptions = Object.assign(
    {
      outgoingPort: "elmMapboxOutgoing",
      incomingPort: "elmMapboxIncoming",
      easingFunctions: {
        linear: (t: number) => t,
      },
    },
    settings,
  );

  if (elmApp.ports && elmApp.ports[options.outgoingPort]) {
    function processOptions(opts: EasingOptions) {
      /* AJD: Looks like opt.easing has changed to "always a function".
       * Not sure if we can still do the logic below!
      if (opts.easing) {
        return Object.assign({}, opts, {
          easing: options.easingFunctions[opts.easing],
        });
      }
      */
      return opts;
    }

    function waitForMap(target: string, cb: (map: mapboxgl.Map) => void) {
      const el = document.getElementById(target);
      // Unable to access actual MapboxMap type from this scope
      type MapboxMap = HTMLElement & { _map: mapboxgl.Map };
      if (el && (el as MapboxMap)._map) {
        // AJD: Fixed from cb(el.map)
        cb((el as MapboxMap)._map);
      } else {
        let queue = commandRegistry[target];
        if (!queue) queue = commandRegistry[target] = [];
        queue.push(cb);
      }
    }

    elmApp.ports[options.outgoingPort].subscribe!((event) => {
      waitForMap(event.target, function (map) {
        switch (event.command) {
          case "resize":
            return map.resize();

          case "fitBounds":
            return map.fitBounds(event.bounds, processOptions(event.options));

          case "panBy":
            return map.panBy(event.offset, processOptions(event.options));

          case "panTo":
            return map.panTo(event.location, processOptions(event.options));

          case "zoomTo":
            return map.zoomTo(event.zoom, processOptions(event.options));

          case "zoomIn":
            return map.zoomIn(processOptions(event.options));

          case "zoomOut":
            return map.zoomOut(processOptions(event.options));

          case "rotateTo":
            return map.rotateTo(event.bearing, processOptions(event.options));

          case "jumpTo":
            return map.jumpTo(processOptions(event.options));

          case "easeTo":
            return map.easeTo(processOptions(event.options));

          case "flyTo":
            return map.flyTo(processOptions(event.options));

          case "stop":
            return map.stop();

          case "setRTLTextPlugin":
            return mapboxgl.setRTLTextPlugin(event.url);

          case "getBounds":
            return elmApp.ports[options.incomingPort].send({
              type: "getBounds",
              id: event.requestId,
              bounds: map.getBounds().toArray(),
            });

          case "queryRenderedFeatures":
            return elmApp.ports[options.incomingPort].send({
              type: "queryRenderedFeatures",
              id: event.requestId,
              features: event.geometry
                ? map.queryRenderedFeatures(event.geometry, event.options)
                : map.queryRenderedFeatures(event.options),
            });
        }
      });
    });
  } else {
    console.warn(
      `Expected Elm App to expose ${
        options.outgoingPort
      } port. Please add https://github.com/gampleman/elm-mapbox/blob/master/examples/MapCommands.elm to your project and import it from your Main file.`,
    );
  }

  return elmApp;
}

export const supported = mapboxgl.supported;
