module Mapbox.Layer exposing
    ( Layer, SourceId, encode
    , background, clip, fill, symbol, line, raster, circle, fillExtrusion, heatmap, hillshade, model, rasterParticle, sky
    , Background, Clip, Fill, Symbol, Line, Raster, Circle, FillExtrusion, Heatmap, Hillshade, Model, RasterParticle, Sky
    , LayerAttr
    , metadata, sourceLayer, minzoom, maxzoom, filter, visible
    , clipLayerScope, clipLayerTypes
    , fillAntialias, fillColor, fillElevationReference, fillEmissiveStrength, fillOpacity, fillOutlineColor, fillPattern, fillSortKey, fillTranslate, fillTranslateAnchor, fillZOffset
    , lineBlur, lineBorderColor, lineBorderWidth, lineCap, lineColor, lineDasharray, lineElevationReference, lineEmissiveStrength, lineGapWidth, lineGradient, lineJoin, lineMiterLimit, lineOcclusionOpacity, lineOffset, lineOpacity, linePattern, lineRoundLimit, lineSortKey, lineTranslate, lineTranslateAnchor, lineTrimColor, lineTrimFadeRange, lineWidth, lineWidthUnit, lineZOffset
    , circleBlur, circleColor, circleElevationReference, circleEmissiveStrength, circleOpacity, circlePitchAlignment, circlePitchScale, circleRadius, circleSortKey, circleStrokeColor, circleStrokeOpacity, circleStrokeWidth, circleTranslate, circleTranslateAnchor
    , heatmapColor, heatmapIntensity, heatmapOpacity, heatmapRadius, heatmapWeight
    , fillExtrusionAmbientOcclusionGroundAttenuation, fillExtrusionAmbientOcclusionGroundRadius, fillExtrusionAmbientOcclusionIntensity, fillExtrusionAmbientOcclusionRadius, fillExtrusionAmbientOcclusionWallRadius, fillExtrusionBase, fillExtrusionBaseAlignment, fillExtrusionCastShadows, fillExtrusionColor, fillExtrusionCutoffFadeRange, fillExtrusionEmissiveStrength, fillExtrusionFloodLightColor, fillExtrusionFloodLightGroundAttenuation, fillExtrusionFloodLightGroundRadius, fillExtrusionFloodLightIntensity, fillExtrusionFloodLightWallRadius, fillExtrusionHeight, fillExtrusionHeightAlignment, fillExtrusionLineWidth, fillExtrusionOpacity, fillExtrusionPattern, fillExtrusionRoundedRoof, fillExtrusionTranslate, fillExtrusionTranslateAnchor, fillExtrusionVerticalGradient, fillExtrusionVerticalScale
    , iconAllowOverlap, iconAnchor, iconColor, iconColorBrightnessMax, iconColorBrightnessMin, iconColorContrast, iconColorSaturation, iconEmissiveStrength, iconHaloBlur, iconHaloColor, iconHaloWidth, iconIgnorePlacement, iconImage, iconImageCrossFade, iconKeepUpright, iconOcclusionOpacity, iconOffset, iconOpacity, iconOptional, iconPadding, iconPitchAlignment, iconRotate, iconRotationAlignment, iconSize, iconSizeScaleRange, iconTextFit, iconTextFitPadding, iconTranslate, iconTranslateAnchor, symbolAvoidEdges, symbolElevationReference, symbolPlacement, symbolSortKey, symbolSpacing, symbolZElevate, symbolZOffset, symbolZOrder, textAllowOverlap, textAnchor, textColor, textEmissiveStrength, textField, textFont, textHaloBlur, textHaloColor, textHaloWidth, textIgnorePlacement, textJustify, textKeepUpright, textLetterSpacing, textLineHeight, textMaxAngle, textMaxWidth, textOcclusionOpacity, textOffset, textOpacity, textOptional, textPadding, textPitchAlignment, textRadialOffset, textRotate, textRotationAlignment, textSize, textSizeScaleRange, textTransform, textTranslate, textTranslateAnchor, textVariableAnchor, textWritingMode
    , rasterArrayBand, rasterBrightnessMax, rasterBrightnessMin, rasterColor, rasterColorMix, rasterColorRange, rasterContrast, rasterElevation, rasterEmissiveStrength, rasterFadeDuration, rasterHueRotate, rasterOpacity, rasterResampling, rasterSaturation
    , rasterParticleArrayBand, rasterParticleColor, rasterParticleCount, rasterParticleElevation, rasterParticleFadeOpacityFactor, rasterParticleMaxSpeed, rasterParticleResetRateFactor, rasterParticleSpeedFactor
    , hillshadeAccentColor, hillshadeEmissiveStrength, hillshadeExaggeration, hillshadeHighlightColor, hillshadeIlluminationAnchor, hillshadeIlluminationDirection, hillshadeShadowColor
    , backgroundColor, backgroundEmissiveStrength, backgroundOpacity, backgroundPattern, backgroundPitchAlignment
    , skyAtmosphereColor, skyAtmosphereHaloColor, skyAtmosphereSun, skyAtmosphereSunIntensity, skyGradient, skyGradientCenter, skyGradientRadius, skyOpacity, skyType
    , modelAmbientOcclusionIntensity, modelCastShadows, modelColor, modelColorMixIntensity, modelCutoffFadeRange, modelEmissiveStrength, modelFrontCutoff, modelHeightBasedEmissiveStrengthMultiplier, modelId, modelOpacity, modelReceiveShadows, modelRotation, modelRoughness, modelScale, modelTranslation, modelType
    )

{-| Layers specify what is actually rendered on the map and are rendered in order.

Except for layers of the background type, each layer needs to refer to a source. Layers take the data that they get from a source, optionally filter features, and then define how those features are styled.

There are two kinds of properties: _Layout_ and _Paint_ properties.

Layout properties are applied early in the rendering process and define how data for that layer is passed to the GPU. Changes to a layout property require an asynchronous "layout" step.

Paint properties are applied later in the rendering process. Changes to a paint property are cheap and happen synchronously.


#### Skip to:

  - [Clip Attributes](#clip-attributes)
  - [Fill Attributes](#fill-attributes)
  - [Line Attributes](#line-attributes)
  - [Circle Attributes](#circle-attributes)
  - [Heatmap Attributes](#heatmap-attributes)
  - [FillExtrusion Attributes](#fillextrusion-attributes)
  - [Symbol Attributes](#symbol-attributes)
  - [Raster Attributes](#raster-attributes)
  - [RasterParticle Attributes](#rasterparticle-attributes)
  - [Hillshade Attributes](#hillshade-attributes)
  - [Background Attributes](#background-attributes)
  - [Sky Attributes](#sky-attributes)
  - [Model Attributes](#model-attributes)


### Working with layers

@docs Layer, SourceId, encode


### Layer Types

@docs background, clip, fill, symbol, line, raster, circle, fillExtrusion, heatmap, hillshade, model, rasterParticle, sky
@docs Background, Clip, Fill, Symbol, Line, Raster, Circle, FillExtrusion, Heatmap, Hillshade, Model, RasterParticle, Sky


### General Attributes

@docs LayerAttr
@docs metadata, sourceLayer, minzoom, maxzoom, filter, visible


### Clip Attributes

@docs clipLayerScope, clipLayerTypes


### Fill Attributes

@docs fillAntialias, fillColor, fillElevationReference, fillEmissiveStrength, fillOpacity, fillOutlineColor, fillPattern, fillSortKey, fillTranslate, fillTranslateAnchor, fillZOffset


### Line Attributes

@docs lineBlur, lineBorderColor, lineBorderWidth, lineCap, lineColor, lineDasharray, lineElevationReference, lineEmissiveStrength, lineGapWidth, lineGradient, lineJoin, lineMiterLimit, lineOcclusionOpacity, lineOffset, lineOpacity, linePattern, lineRoundLimit, lineSortKey, lineTranslate, lineTranslateAnchor, lineTrimColor, lineTrimFadeRange, lineWidth, lineWidthUnit, lineZOffset


### Circle Attributes

@docs circleBlur, circleColor, circleElevationReference, circleEmissiveStrength, circleOpacity, circlePitchAlignment, circlePitchScale, circleRadius, circleSortKey, circleStrokeColor, circleStrokeOpacity, circleStrokeWidth, circleTranslate, circleTranslateAnchor


### Heatmap Attributes

@docs heatmapColor, heatmapIntensity, heatmapOpacity, heatmapRadius, heatmapWeight


### FillExtrusion Attributes

@docs fillExtrusionAmbientOcclusionGroundAttenuation, fillExtrusionAmbientOcclusionGroundRadius, fillExtrusionAmbientOcclusionIntensity, fillExtrusionAmbientOcclusionRadius, fillExtrusionAmbientOcclusionWallRadius, fillExtrusionBase, fillExtrusionBaseAlignment, fillExtrusionCastShadows, fillExtrusionColor, fillExtrusionCutoffFadeRange, fillExtrusionEmissiveStrength, fillExtrusionFloodLightColor, fillExtrusionFloodLightGroundAttenuation, fillExtrusionFloodLightGroundRadius, fillExtrusionFloodLightIntensity, fillExtrusionFloodLightWallRadius, fillExtrusionHeight, fillExtrusionHeightAlignment, fillExtrusionLineWidth, fillExtrusionOpacity, fillExtrusionPattern, fillExtrusionRoundedRoof, fillExtrusionTranslate, fillExtrusionTranslateAnchor, fillExtrusionVerticalGradient, fillExtrusionVerticalScale


### Symbol Attributes

@docs iconAllowOverlap, iconAnchor, iconColor, iconColorBrightnessMax, iconColorBrightnessMin, iconColorContrast, iconColorSaturation, iconEmissiveStrength, iconHaloBlur, iconHaloColor, iconHaloWidth, iconIgnorePlacement, iconImage, iconImageCrossFade, iconKeepUpright, iconOcclusionOpacity, iconOffset, iconOpacity, iconOptional, iconPadding, iconPitchAlignment, iconRotate, iconRotationAlignment, iconSize, iconSizeScaleRange, iconTextFit, iconTextFitPadding, iconTranslate, iconTranslateAnchor, symbolAvoidEdges, symbolElevationReference, symbolPlacement, symbolSortKey, symbolSpacing, symbolZElevate, symbolZOffset, symbolZOrder, textAllowOverlap, textAnchor, textColor, textEmissiveStrength, textField, textFont, textHaloBlur, textHaloColor, textHaloWidth, textIgnorePlacement, textJustify, textKeepUpright, textLetterSpacing, textLineHeight, textMaxAngle, textMaxWidth, textOcclusionOpacity, textOffset, textOpacity, textOptional, textPadding, textPitchAlignment, textRadialOffset, textRotate, textRotationAlignment, textSize, textSizeScaleRange, textTransform, textTranslate, textTranslateAnchor, textVariableAnchor, textWritingMode


### Raster Attributes

@docs rasterArrayBand, rasterBrightnessMax, rasterBrightnessMin, rasterColor, rasterColorMix, rasterColorRange, rasterContrast, rasterElevation, rasterEmissiveStrength, rasterFadeDuration, rasterHueRotate, rasterOpacity, rasterResampling, rasterSaturation


### RasterParticle Attributes

@docs rasterParticleArrayBand, rasterParticleColor, rasterParticleCount, rasterParticleElevation, rasterParticleFadeOpacityFactor, rasterParticleMaxSpeed, rasterParticleResetRateFactor, rasterParticleSpeedFactor


### Hillshade Attributes

@docs hillshadeAccentColor, hillshadeEmissiveStrength, hillshadeExaggeration, hillshadeHighlightColor, hillshadeIlluminationAnchor, hillshadeIlluminationDirection, hillshadeShadowColor


### Background Attributes

@docs backgroundColor, backgroundEmissiveStrength, backgroundOpacity, backgroundPattern, backgroundPitchAlignment


### Sky Attributes

@docs skyAtmosphereColor, skyAtmosphereHaloColor, skyAtmosphereSun, skyAtmosphereSunIntensity, skyGradient, skyGradientCenter, skyGradientRadius, skyOpacity, skyType


### Model Attributes

@docs modelAmbientOcclusionIntensity, modelCastShadows, modelColor, modelColorMixIntensity, modelCutoffFadeRange, modelEmissiveStrength, modelFrontCutoff, modelHeightBasedEmissiveStrengthMultiplier, modelId, modelOpacity, modelReceiveShadows, modelRotation, modelRoughness, modelScale, modelTranslation, modelType

-}

import Array exposing (Array)
import Internal exposing (Supported)
import Json.Encode as Encode exposing (Value)
import Mapbox.Expression as Expression exposing (CameraExpression, Color, DataExpression, Expression, FormattedText)


{-| Represents a layer.
-}
type Layer
    = Layer Value


{-| All layers (except background layers) need a source
-}
type alias SourceId =
    String


{-| -}
type Background
    = BackgroundLayer


{-| -}
type Clip
    = ClipLayer


{-| -}
type Fill
    = FillLayer


{-| -}
type Symbol
    = SymbolLayer


{-| -}
type Line
    = LineLayer


{-| -}
type Raster
    = RasterLayer


{-| -}
type Circle
    = CircleLayer


{-| -}
type FillExtrusion
    = FillExtrusionLayer


{-| -}
type Heatmap
    = HeatmapLayer


{-| -}
type Hillshade
    = HillshadeLayer


{-| -}
type Model
    = ModelLayer


{-| -}
type RasterParticle
    = RasterParticleLayer


{-| -}
type Sky
    = SkyLayer


{-| Turns a layer into JSON
-}
encode : Layer -> Value
encode (Layer value) =
    value


layerImpl : String -> String -> String -> List (LayerAttr tipe) -> Layer
layerImpl tipe id source attrs =
    [ ( "type", Encode.string tipe )
    , ( "id", Encode.string id )
    , ( "source", Encode.string source )
    ]
        ++ encodeAttrs attrs
        |> Encode.object
        |> Layer


encodeAttrs : List (LayerAttr tipe) -> List ( String, Value )
encodeAttrs attrs =
    let
        { top, layout, paint } =
            List.foldl
                (\attr lists ->
                    case attr of
                        Top key val ->
                            { lists | top = ( key, val ) :: lists.top }

                        Paint key val ->
                            { lists | paint = ( key, val ) :: lists.paint }

                        Layout key val ->
                            { lists | layout = ( key, val ) :: lists.layout }
                )
                { top = [], layout = [], paint = [] }
                attrs
    in
    ( "layout", Encode.object layout ) :: ( "paint", Encode.object paint ) :: top


{-| The background color or pattern of the map.
-}
background : String -> List (LayerAttr Background) -> Layer
background id attrs =
    [ ( "type", Encode.string "background" )
    , ( "id", Encode.string id )
    ]
        ++ encodeAttrs attrs
        |> Encode.object
        |> Layer


{-| Clip
-}
clip : String -> SourceId -> List (LayerAttr Clip) -> Layer
clip =
    layerImpl "clip"


{-| A filled polygon with an optional stroked border.
-}
fill : String -> SourceId -> List (LayerAttr Fill) -> Layer
fill =
    layerImpl "fill"


{-| A stroked line.
-}
line : String -> SourceId -> List (LayerAttr Line) -> Layer
line =
    layerImpl "line"


{-| An icon or a text label.
-}
symbol : String -> SourceId -> List (LayerAttr Symbol) -> Layer
symbol =
    layerImpl "symbol"


{-| Raster map textures such as satellite imagery.
-}
raster : String -> SourceId -> List (LayerAttr Raster) -> Layer
raster =
    layerImpl "raster"


{-| A filled circle.
-}
circle : String -> SourceId -> List (LayerAttr Circle) -> Layer
circle =
    layerImpl "circle"


{-| An extruded (3D) polygon.
-}
fillExtrusion : String -> SourceId -> List (LayerAttr FillExtrusion) -> Layer
fillExtrusion =
    layerImpl "fill-extrusion"


{-| A heatmap.
-}
heatmap : String -> SourceId -> List (LayerAttr Heatmap) -> Layer
heatmap =
    layerImpl "heatmap"


{-| Client-side hillshading visualization based on DEM data. Currently, the implementation only supports Mapbox Terrain RGB and Mapzen Terrarium tiles.
-}
hillshade : String -> SourceId -> List (LayerAttr Hillshade) -> Layer
hillshade =
    layerImpl "hillshade"


{-| Model
-}
model : String -> SourceId -> List (LayerAttr Model) -> Layer
model =
    layerImpl "model"


{-| RasterParticle
-}
rasterParticle : String -> SourceId -> List (LayerAttr RasterParticle) -> Layer
rasterParticle =
    layerImpl "rasterParticle"


{-| Sky
-}
sky : String -> SourceId -> List (LayerAttr RasterParticle) -> Layer
sky =
    layerImpl "sky"


{-| -}
type LayerAttr tipe
    = Top String Value
    | Paint String Value
    | Layout String Value



-- General Attributes


{-| Arbitrary properties useful to track with the layer, but do not influence rendering. Properties should be prefixed to avoid collisions, like 'mapbox:'.
-}
metadata : Value -> LayerAttr all
metadata =
    Top "metadata"


{-| Layer to use from a vector tile source. Required for vector tile sources; prohibited for all other source types, including GeoJSON sources.
-}
sourceLayer : String -> LayerAttr all
sourceLayer =
    Encode.string >> Top "source-layer"


{-| The minimum zoom level for the layer. At zoom levels less than the minzoom, the layer will be hidden. A number between 0 and 24 inclusive.
-}
minzoom : Float -> LayerAttr all
minzoom =
    Encode.float >> Top "minzoom"


{-| The maximum zoom level for the layer. At zoom levels equal to or greater than the maxzoom, the layer will be hidden. A number between 0 and 24 inclusive.
-}
maxzoom : Float -> LayerAttr all
maxzoom =
    Encode.float >> Top "maxzoom"


{-| A expression specifying conditions on source features. Only features that match the filter are displayed.
-}
filter : Expression any Bool -> LayerAttr all
filter =
    Expression.encode >> Top "filter"


{-| Whether this layer is displayed.
-}
visible : Bool -> LayerAttr any
visible isVisible =
    Layout "visibility" <|
        Expression.encode <|
            Expression.str <|
                if isVisible then
                    "visible"

                else
                    "none"



-- Clip


{-| Layer types that will also be removed if fallen below this clip layer. Layout property. Defaults to `""`.

  - `model`: If present the clip layer would remove all 3d model layers below it. Currently only instanced models (e.g. trees) are removed.
  - `symbol`: If present the clip layer would remove all symbol layers below it.

-}
clipLayerTypes : Expression CameraExpression FormattedText -> LayerAttr Clip
clipLayerTypes =
    Expression.encode >> Layout "clip-layer-types"


{-| Removes content from layers with the specified scope. By default all layers are affected. For example specifying `basemap` will only remove content from the Mapbox Standard style layers which have the same scope Layout property. Defaults to `""`.
-}
clipLayerScope : Expression CameraExpression (Array String) -> LayerAttr Clip
clipLayerScope =
    Expression.encode >> Layout "clip-layer-scope"



-- Fill


{-| Controls the frame of reference for `fillTranslate`. Paint property. Defaults to `map`. Requires `fillTranslate`.

  - `map`: The fill is translated relative to the map.
  - `viewport`: The fill is translated relative to the viewport.

-}
fillTranslateAnchor : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr Fill
fillTranslateAnchor =
    Expression.encode >> Paint "fill-translate-anchor"


{-| Controls the intensity of light emitted on the source features. Paint property.

Should be greater than or equal to `0`.
Units in intensity. Defaults to `0`. Requires `lights`.

-}
fillEmissiveStrength : Expression CameraExpression Float -> LayerAttr Fill
fillEmissiveStrength =
    Expression.encode >> Paint "fill-emissive-strength"


{-| Name of image in sprite to use for drawing image fills. For seamless patterns, image width and height must be a factor of two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be evaluated only at integer zoom levels. Paint property.
-}
fillPattern : Expression any String -> LayerAttr Fill
fillPattern =
    Expression.encode >> Paint "fill-pattern"


{-| Selects the base of fill-elevation. Some modes might require precomputed elevation data in the tileset. Layout property. Defaults to `none`.

  - `none`: Elevated rendering is disabled.
  - `hdRoadBase`: Elevate geometry relative to HD roads. Use this mode to describe base polygons of the road networks.
  - `hdRoadMarkup`: Elevated rendering is enabled. Use this mode to describe additive and stackable features such as 'hatched areas' that should exist only on top of road polygons.

-}
fillElevationReference : Expression CameraExpression { none : Supported, hdRoadBase : Supported, hdRoadMarkup : Supported } -> LayerAttr Fill
fillElevationReference =
    Expression.encode >> Layout "fill-elevation-reference"


{-| Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key. Layout property.
-}
fillSortKey : Expression any Float -> LayerAttr Fill
fillSortKey =
    Expression.encode >> Layout "fill-sort-key"


{-| Specifies an uniform elevation in meters. Note: If the value is zero, the layer will be rendered on the ground. Non-zero values will elevate the layer from the sea level, which can cause it to be rendered below the terrain. Paint property.

Should be greater than or equal to `0`. Defaults to `0`.

-}
fillZOffset : Expression any Float -> LayerAttr Fill
fillZOffset =
    Expression.encode >> Paint "fill-z-offset"


{-| The color of the filled part of this layer. This color can be specified as `rgba` with an alpha component and the color's opacity will not affect the opacity of the 1px stroke, if it is used. Paint property. Defaults to `#000000`. Disabled by `fillPattern`.
-}
fillColor : Expression any Color -> LayerAttr Fill
fillColor =
    Expression.encode >> Paint "fill-color"


{-| The geometry's offset. Values are [x, y] where negatives indicate left and up, respectively. Paint property.
Units in pixels. Defaults to `0,0`.
-}
fillTranslate : Expression CameraExpression (Array Float) -> LayerAttr Fill
fillTranslate =
    Expression.encode >> Paint "fill-translate"


{-| The opacity of the entire fill layer. In contrast to the `fillColor`, this value will also affect the 1px stroke around the fill, if the stroke is used. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
fillOpacity : Expression any Float -> LayerAttr Fill
fillOpacity =
    Expression.encode >> Paint "fill-opacity"


{-| The outline color of the fill. Matches the value of `fillColor` if unspecified. Paint property. Disabled by `fillPattern`. Requires `fillAntialias` to be `true`.
-}
fillOutlineColor : Expression any Color -> LayerAttr Fill
fillOutlineColor =
    Expression.encode >> Paint "fill-outline-color"


{-| Whether or not the fill should be antialiased. Paint property. Defaults to `true`.
-}
fillAntialias : Expression CameraExpression Bool -> LayerAttr Fill
fillAntialias =
    Expression.encode >> Paint "fill-antialias"



-- Line


{-| A gradient used to color a line feature at various distances along its length. Defined using a `step` or `interpolate` expression which outputs a color for each corresponding `line-progress` input value. `line-progress` is a percentage of the line feature's total length as measured on the webmercator projected coordinate plane (a `number` between `0` and `1`). Can only be used with GeoJSON sources that specify `"lineMetrics": true`. Paint property. Disabled by `linePattern`. Requires `source` to be `geojson`.
-}
lineGradient : Expression CameraExpression Color -> LayerAttr Line
lineGradient =
    Expression.encode >> Paint "line-gradient"


{-| Blur applied to the line, in pixels. Paint property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `0`.

-}
lineBlur : Expression any Float -> LayerAttr Line
lineBlur =
    Expression.encode >> Paint "line-blur"


{-| Controls the frame of reference for `lineTranslate`. Paint property. Defaults to `map`. Requires `lineTranslate`.

  - `map`: The line is translated relative to the map.
  - `viewport`: The line is translated relative to the viewport.

-}
lineTranslateAnchor : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr Line
lineTranslateAnchor =
    Expression.encode >> Paint "line-translate-anchor"


{-| Controls the intensity of light emitted on the source features. Paint property.

Should be greater than or equal to `0`.
Units in intensity. Defaults to `0`. Requires `lights`.

-}
lineEmissiveStrength : Expression CameraExpression Float -> LayerAttr Line
lineEmissiveStrength =
    Expression.encode >> Paint "line-emissive-strength"


{-| Draws a line casing outside of a line's actual path. Value indicates the width of the inner gap. Paint property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `0`.

-}
lineGapWidth : Expression any Float -> LayerAttr Line
lineGapWidth =
    Expression.encode >> Paint "line-gap-width"


{-| Name of image in sprite to use for drawing image lines. For seamless patterns, image width must be a factor of two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be evaluated only at integer zoom levels. Paint property.
-}
linePattern : Expression any String -> LayerAttr Line
linePattern =
    Expression.encode >> Paint "line-pattern"


{-| Opacity multiplier (multiplies line-opacity value) of the line part that is occluded by 3D objects. Value 0 hides occluded part, value 1 means the same opacity as non-occluded part. The property is not supported when `lineOpacity` has data-driven styling. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`.

-}
lineOcclusionOpacity : Expression CameraExpression Float -> LayerAttr Line
lineOcclusionOpacity =
    Expression.encode >> Paint "line-occlusion-opacity"


{-| Selects the base of line-elevation. Some modes might require precomputed elevation data in the tileset. Layout property. Defaults to `none`.

  - `none`: Elevated rendering is disabled.
  - `sea`: Elevated rendering is enabled. Use this mode to elevate lines relative to the sea level.
  - `ground`: Elevated rendering is enabled. Use this mode to elevate lines relative to the ground's height below them.
  - `hdRoadMarkup`: Elevated rendering is enabled. Use this mode to describe additive and stackable features that should exist only on top of road polygons.

-}
lineElevationReference : Expression CameraExpression { none : Supported, sea : Supported, ground : Supported, hdRoadMarkup : Supported } -> LayerAttr Line
lineElevationReference =
    Expression.encode >> Layout "line-elevation-reference"


{-| Selects the unit of line-width. The same unit is automatically used for line-blur and line-offset. Note: This is an experimental property and might be removed in a future release. Layout property. Defaults to `pixels`.

  - `pixels`: Width is rendered in pixels.
  - `meters`: Width is rendered in meters.

-}
lineWidthUnit : Expression CameraExpression { pixels : Supported, meters : Supported } -> LayerAttr Line
lineWidthUnit =
    Expression.encode >> Layout "line-width-unit"


{-| Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key. Layout property.
-}
lineSortKey : Expression any Float -> LayerAttr Line
lineSortKey =
    Expression.encode >> Layout "line-sort-key"


{-| Specifies the lengths of the alternating dashes and gaps that form the dash pattern. The lengths are later scaled by the line width. To convert a dash length to pixels, multiply the length by the current line width. Note that GeoJSON sources with `lineMetrics: true` specified won't render dashed lines to the expected scale. Also note that zoom-dependent expressions will be evaluated only at integer zoom levels. Paint property.

Should be greater than or equal to `0`.
Units in line widths. Disabled by `linePattern`.

-}
lineDasharray : Expression any (Array Float) -> LayerAttr Line
lineDasharray =
    Expression.encode >> Paint "line-dasharray"


{-| Stroke thickness. Paint property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `1`.

-}
lineWidth : Expression any Float -> LayerAttr Line
lineWidth =
    Expression.encode >> Paint "line-width"


{-| The color of the line border. If line-border-width is greater than zero and the alpha value of this color is 0 (default), the color for the border will be selected automatically based on the line color. Paint property. Defaults to `rgba 0 0 0 0`.
-}
lineBorderColor : Expression any Color -> LayerAttr Line
lineBorderColor =
    Expression.encode >> Paint "line-border-color"


{-| The color to be used for rendering the trimmed line section that is defined by the `lineTrimOffset` property. Paint property. Defaults to `transparent`. Requires `lineTrimOffset`. Requires `source` to be `geojson`.
-}
lineTrimColor : Expression CameraExpression Color -> LayerAttr Line
lineTrimColor =
    Expression.encode >> Paint "line-trim-color"


{-| The color with which the line will be drawn. Paint property. Defaults to `#000000`. Disabled by `linePattern`.
-}
lineColor : Expression any Color -> LayerAttr Line
lineColor =
    Expression.encode >> Paint "line-color"


{-| The display of line endings. Layout property. Defaults to `butt`.

  - `butt`: A cap with a squared-off end which is drawn to the exact endpoint of the line.
  - `rounded`: A cap with a rounded end which is drawn beyond the endpoint of the line at a radius of one-half of the line's width and centered on the endpoint of the line.
  - `square`: A cap with a squared-off end which is drawn beyond the endpoint of the line at a distance of one-half of the line's width.

-}
lineCap : Expression any { butt : Supported, rounded : Supported, square : Supported } -> LayerAttr Line
lineCap =
    Expression.encode >> Layout "line-cap"


{-| The display of lines when joining. Layout property. Defaults to `miter`.

  - `bevel`: A join with a squared-off end which is drawn beyond the endpoint of the line at a distance of one-half of the line's width.
  - `rounded`: A join with a rounded end which is drawn beyond the endpoint of the line at a radius of one-half of the line's width and centered on the endpoint of the line.
  - `miter`: A join with a sharp, angled corner which is drawn with the outer sides beyond the endpoint of the path until they meet.
  - `none`: Line segments are not joined together, each one creates a separate line. Useful in combination with line-pattern. Line-cap property is not respected. Can't be used with data-driven styling.

-}
lineJoin : Expression any { bevel : Supported, rounded : Supported, miter : Supported, none : Supported } -> LayerAttr Line
lineJoin =
    Expression.encode >> Layout "line-join"


{-| The fade range for the trim-start and trim-end points is defined by the `lineTrimOffset` property. The first element of the array represents the fade range from the trim-start point toward the end of the line, while the second element defines the fade range from the trim-end point toward the beginning of the line. The fade result is achieved by interpolating between `lineTrimColor` and the color specified by the `lineColor` or the `lineGradient` property. Paint property.

Should be between `0,0` and `1,1` inclusive. Defaults to `0,0`. Requires `lineTrimOffset`. Requires `source` to be `geojson`.

-}
lineTrimFadeRange : Expression CameraExpression (Array Float) -> LayerAttr Line
lineTrimFadeRange =
    Expression.encode >> Paint "line-trim-fade-range"


{-| The geometry's offset. Values are [x, y] where negatives indicate left and up, respectively. Paint property.
Units in pixels. Defaults to `0,0`.
-}
lineTranslate : Expression CameraExpression (Array Float) -> LayerAttr Line
lineTranslate =
    Expression.encode >> Paint "line-translate"


{-| The line's offset. For linear features, a positive value offsets the line to the right, relative to the direction of the line, and a negative value to the left. For polygon features, a positive value results in an inset, and a negative value results in an outset. Paint property.
Units in pixels. Defaults to `0`.
-}
lineOffset : Expression any Float -> LayerAttr Line
lineOffset =
    Expression.encode >> Paint "line-offset"


{-| The opacity at which the line will be drawn. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
lineOpacity : Expression any Float -> LayerAttr Line
lineOpacity =
    Expression.encode >> Paint "line-opacity"


{-| The width of the line border. A value of zero means no border. Paint property.

Should be greater than or equal to `0`. Defaults to `0`.

-}
lineBorderWidth : Expression any Float -> LayerAttr Line
lineBorderWidth =
    Expression.encode >> Paint "line-border-width"


{-| Used to automatically convert miter joins to bevel joins for sharp angles. Layout property. Defaults to `2`. Requires `lineJoin` to be `miter`.
-}
lineMiterLimit : Expression CameraExpression Float -> LayerAttr Line
lineMiterLimit =
    Expression.encode >> Layout "line-miter-limit"


{-| Used to automatically convert round joins to miter joins for shallow angles. Layout property. Defaults to `1.05`. Requires `lineJoin` to be `round`.
-}
lineRoundLimit : Expression CameraExpression Float -> LayerAttr Line
lineRoundLimit =
    Expression.encode >> Layout "line-round-limit"


{-| Vertical offset from ground, in meters. Defaults to 0. This is an experimental property with some known issues:

  - Not supported for globe projection at the moment
  - Elevated line discontinuity is possible on tile borders with terrain enabled
  - Rendering artifacts can happen near line joins and line caps depending on the line styling
  - Rendering artifacts relating to `lineOpacity` and `lineBlur`
  - Elevated line visibility is determined by layer order
  - Z-fighting issues can happen with intersecting elevated lines
  - Elevated lines don't cast shadows Layout property. Defaults to `0`. Requires `lineElevationReference`.

-}
lineZOffset : Expression any Float -> LayerAttr Line
lineZOffset =
    Expression.encode >> Layout "line-z-offset"



-- Circle


{-| Amount to blur the circle. 1 blurs the circle such that only the centerpoint is full opacity. Setting a negative value renders the blur as an inner glow effect. Paint property. Defaults to `0`.
-}
circleBlur : Expression any Float -> LayerAttr Circle
circleBlur =
    Expression.encode >> Paint "circle-blur"


{-| Circle radius. Paint property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `5`.

-}
circleRadius : Expression any Float -> LayerAttr Circle
circleRadius =
    Expression.encode >> Paint "circle-radius"


{-| Controls the frame of reference for `circleTranslate`. Paint property. Defaults to `map`. Requires `circleTranslate`.

  - `map`: The circle is translated relative to the map.
  - `viewport`: The circle is translated relative to the viewport.

-}
circleTranslateAnchor : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr Circle
circleTranslateAnchor =
    Expression.encode >> Paint "circle-translate-anchor"


{-| Controls the intensity of light emitted on the source features. Paint property.

Should be greater than or equal to `0`.
Units in intensity. Defaults to `0`. Requires `lights`.

-}
circleEmissiveStrength : Expression CameraExpression Float -> LayerAttr Circle
circleEmissiveStrength =
    Expression.encode >> Paint "circle-emissive-strength"


{-| Controls the scaling behavior of the circle when the map is pitched. Paint property. Defaults to `map`.

  - `map`: Circles are scaled according to their apparent distance to the camera.
  - `viewport`: Circles are not scaled.

-}
circlePitchScale : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr Circle
circlePitchScale =
    Expression.encode >> Paint "circle-pitch-scale"


{-| Orientation of circle when map is pitched. Paint property. Defaults to `viewport`.

  - `map`: The circle is aligned to the plane of the map.
  - `viewport`: The circle is aligned to the plane of the viewport.

-}
circlePitchAlignment : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr Circle
circlePitchAlignment =
    Expression.encode >> Paint "circle-pitch-alignment"


{-| Selects the base of circle-elevation. Some modes might require precomputed elevation data in the tileset. Layout property. Defaults to `none`.

  - `none`: Elevated rendering is disabled.
  - `hdRoadMarkup`: Elevated rendering is enabled. Use this mode to describe additive and stackable features that should exist only on top of road polygons.

-}
circleElevationReference : Expression CameraExpression { none : Supported, hdRoadMarkup : Supported } -> LayerAttr Circle
circleElevationReference =
    Expression.encode >> Layout "circle-elevation-reference"


{-| Sorts features in ascending order based on this value. Features with a higher sort key will appear above features with a lower sort key. Layout property.
-}
circleSortKey : Expression any Float -> LayerAttr Circle
circleSortKey =
    Expression.encode >> Layout "circle-sort-key"


{-| The fill color of the circle. Paint property. Defaults to `#000000`.
-}
circleColor : Expression any Color -> LayerAttr Circle
circleColor =
    Expression.encode >> Paint "circle-color"


{-| The geometry's offset. Values are [x, y] where negatives indicate left and up, respectively. Paint property.
Units in pixels. Defaults to `0,0`.
-}
circleTranslate : Expression CameraExpression (Array Float) -> LayerAttr Circle
circleTranslate =
    Expression.encode >> Paint "circle-translate"


{-| The opacity at which the circle will be drawn. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
circleOpacity : Expression any Float -> LayerAttr Circle
circleOpacity =
    Expression.encode >> Paint "circle-opacity"


{-| The opacity of the circle's stroke. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
circleStrokeOpacity : Expression any Float -> LayerAttr Circle
circleStrokeOpacity =
    Expression.encode >> Paint "circle-stroke-opacity"


{-| The stroke color of the circle. Paint property. Defaults to `#000000`.
-}
circleStrokeColor : Expression any Color -> LayerAttr Circle
circleStrokeColor =
    Expression.encode >> Paint "circle-stroke-color"


{-| The width of the circle's stroke. Strokes are placed outside of the `circleRadius`. Paint property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `0`.

-}
circleStrokeWidth : Expression any Float -> LayerAttr Circle
circleStrokeWidth =
    Expression.encode >> Paint "circle-stroke-width"



-- Heatmap


{-| A measure of how much an individual point contributes to the heatmap. A value of 10 would be equivalent to having 10 points of weight 1 in the same spot. Especially useful when combined with clustering. Paint property.

Should be greater than or equal to `0`. Defaults to `1`.

-}
heatmapWeight : Expression any Float -> LayerAttr Heatmap
heatmapWeight =
    Expression.encode >> Paint "heatmap-weight"


{-| Defines the color of each pixel based on its density value in a heatmap. The value should be an Expression that uses `heatmapDensity` as input. Defaults to:

      E.heatmapDensity
      |> E.interpolate E.Linear
        [ (0.0, rgba 0 0 255 0)
        , (0.1, rgba 65 105 225 1)
        , (0.3, rgba 0 255 255 1)
        , (0.5, rgba 0 255 0 1)
        , (0.7, rgba 255 255 0 1)
        , (1.0, rgba 255 0 0 1)] Paint property.

-}
heatmapColor : Expression CameraExpression Color -> LayerAttr Heatmap
heatmapColor =
    Expression.encode >> Paint "heatmap-color"


{-| Radius of influence of one heatmap point in pixels. Increasing the value makes the heatmap smoother, but less detailed. `queryRenderedFeatures` on heatmap layers will return points within this radius. Paint property.

Should be greater than or equal to `1`.
Units in pixels. Defaults to `30`.

-}
heatmapRadius : Expression any Float -> LayerAttr Heatmap
heatmapRadius =
    Expression.encode >> Paint "heatmap-radius"


{-| Similar to `heatmapWeight` but controls the intensity of the heatmap globally. Primarily used for adjusting the heatmap based on zoom level. Paint property.

Should be greater than or equal to `0`. Defaults to `1`.

-}
heatmapIntensity : Expression CameraExpression Float -> LayerAttr Heatmap
heatmapIntensity =
    Expression.encode >> Paint "heatmap-intensity"


{-| The global opacity at which the heatmap layer will be drawn. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
heatmapOpacity : Expression CameraExpression Float -> LayerAttr Heatmap
heatmapOpacity =
    Expression.encode >> Paint "heatmap-opacity"



-- FillExtrusion


{-| A global multiplier that can be used to scale base, height, AO, and flood light of the fill extrusions. Paint property.

Should be greater than or equal to `0`. Defaults to `1`.

-}
fillExtrusionVerticalScale : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionVerticalScale =
    Expression.encode >> Paint "fill-extrusion-vertical-scale"


{-| Controls the behavior of fill extrusion base over terrain Paint property. Defaults to `terrain`. Requires `fillExtrusionBase`.

  - `terrain`: The fill extrusion base follows terrain slope.
  - `flat`: The fill extrusion base is flat over terrain.

-}
fillExtrusionBaseAlignment : Expression CameraExpression { terrain : Supported, flat : Supported } -> LayerAttr FillExtrusion
fillExtrusionBaseAlignment =
    Expression.encode >> Paint "fill-extrusion-base-alignment"


{-| Controls the behavior of fill extrusion height over terrain Paint property. Defaults to `flat`. Requires `fillExtrusionHeight`.

  - `terrain`: The fill extrusion height follows terrain slope.
  - `flat`: The fill extrusion height is flat over terrain.

-}
fillExtrusionHeightAlignment : Expression CameraExpression { terrain : Supported, flat : Supported } -> LayerAttr FillExtrusion
fillExtrusionHeightAlignment =
    Expression.encode >> Paint "fill-extrusion-height-alignment"


{-| Controls the frame of reference for `fillExtrusionTranslate`. Paint property. Defaults to `map`. Requires `fillExtrusionTranslate`.

  - `map`: The fill extrusion is translated relative to the map.
  - `viewport`: The fill extrusion is translated relative to the viewport.

-}
fillExtrusionTranslateAnchor : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr FillExtrusion
fillExtrusionTranslateAnchor =
    Expression.encode >> Paint "fill-extrusion-translate-anchor"


{-| Controls the intensity of light emitted on the source features. Paint property.

Should be greater than or equal to `0`.
Units in intensity. Defaults to `0`. Requires `lights`.

-}
fillExtrusionEmissiveStrength : Expression any Float -> LayerAttr FillExtrusion
fillExtrusionEmissiveStrength =
    Expression.encode >> Paint "fill-extrusion-emissive-strength"


{-| Controls the intensity of shading near ground and concave angles between walls. Default value 0.0 disables ambient occlusion and values around 0.3 provide the most plausible results for buildings. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`.

-}
fillExtrusionAmbientOcclusionIntensity : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionAmbientOcclusionIntensity =
    Expression.encode >> Paint "fill-extrusion-ambient-occlusion-intensity"


{-| Enable/Disable shadow casting for this layer Paint property. Defaults to `true`.
-}
fillExtrusionCastShadows : Expression CameraExpression Bool -> LayerAttr FillExtrusion
fillExtrusionCastShadows =
    Expression.encode >> Paint "fill-extrusion-cast-shadows"


{-| If a non-zero value is provided, it sets the fill-extrusion layer into wall rendering mode. The value is used to render the feature with the given width over the outlines of the geometry. Note: This property is experimental and some other fill-extrusion properties might not be supported with non-zero line width. Paint property.

Should be greater than or equal to `0`.
Units in meters. Defaults to `0`.

-}
fillExtrusionLineWidth : Expression any Float -> LayerAttr FillExtrusion
fillExtrusionLineWidth =
    Expression.encode >> Paint "fill-extrusion-line-width"


{-| Indicates whether top edges should be rounded when fill-extrusion-edge-radius has a value greater than 0. If false, rounded edges are only applied to the sides. Default is true. Paint property. Defaults to `true`. Requires `fillExtrusionEdgeRadius`.
-}
fillExtrusionRoundedRoof : Expression CameraExpression Bool -> LayerAttr FillExtrusion
fillExtrusionRoundedRoof =
    Expression.encode >> Paint "fill-extrusion-rounded-roof"


{-| Name of image in sprite to use for drawing images on extruded fills. For seamless patterns, image width and height must be a factor of two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be evaluated only at integer zoom levels. Paint property.
-}
fillExtrusionPattern : Expression any String -> LayerAttr FillExtrusion
fillExtrusionPattern =
    Expression.encode >> Paint "fill-extrusion-pattern"


{-| Provides a control to futher fine-tune the look of the ambient occlusion on the ground beneath the extruded buildings. Lower values give the effect a more solid look while higher values make it smoother. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0.69`. Requires `lights`.

-}
fillExtrusionAmbientOcclusionGroundAttenuation : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionAmbientOcclusionGroundAttenuation =
    Expression.encode >> Paint "fill-extrusion-ambient-occlusion-ground-attenuation"


{-| Provides a control to futher fine-tune the look of the flood light on the ground beneath the extruded buildings. Lower values give the effect a more solid look while higher values make it smoother. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0.69`. Requires `lights`.

-}
fillExtrusionFloodLightGroundAttenuation : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionFloodLightGroundAttenuation =
    Expression.encode >> Paint "fill-extrusion-flood-light-ground-attenuation"


{-| Shades area near ground and concave angles between walls where the radius defines only vertical impact. Default value 3.0 corresponds to height of one floor and brings the most plausible results for buildings. Paint property.

Should be greater than or equal to `0`. Defaults to `3`. Requires `lights`. Requires `fillExtrusionEdgeRadius`.

-}
fillExtrusionAmbientOcclusionWallRadius : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionAmbientOcclusionWallRadius =
    Expression.encode >> Paint "fill-extrusion-ambient-occlusion-wall-radius"


{-| Shades area near ground and concave angles between walls where the radius defines only vertical impact. Default value 3.0 corresponds to height of one floor and brings the most plausible results for buildings. This property works only with legacy light. When 3D lights are enabled `fillExtrusionAmbientOcclusionWallRadius` and `fillExtrusionAmbientOcclusionGroundRadius` are used instead. Paint property.

Should be greater than or equal to `0`. Defaults to `3`. Requires `fillExtrusionEdgeRadius`.

-}
fillExtrusionAmbientOcclusionRadius : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionAmbientOcclusionRadius =
    Expression.encode >> Paint "fill-extrusion-ambient-occlusion-radius"


{-| The base color of the extruded fill. The extrusion's surfaces will be shaded differently based on this color in combination with the root `light` settings. If this color is specified as `rgba` with an alpha component, the alpha component will be ignored; use `fillExtrusionOpacity` to set layer opacity. Paint property. Defaults to `#000000`. Disabled by `fillExtrusionPattern`.
-}
fillExtrusionColor : Expression any Color -> LayerAttr FillExtrusion
fillExtrusionColor =
    Expression.encode >> Paint "fill-extrusion-color"


{-| The color of the flood light effect on the walls of the extruded buildings. Paint property. Defaults to `#Ffffff`. Requires `lights`.
-}
fillExtrusionFloodLightColor : Expression CameraExpression Color -> LayerAttr FillExtrusion
fillExtrusionFloodLightColor =
    Expression.encode >> Paint "fill-extrusion-flood-light-color"


{-| The extent of the ambient occlusion effect on the ground beneath the extruded buildings in meters. Paint property.

Should be greater than or equal to `0`. Defaults to `3`. Requires `lights`.

-}
fillExtrusionAmbientOcclusionGroundRadius : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionAmbientOcclusionGroundRadius =
    Expression.encode >> Paint "fill-extrusion-ambient-occlusion-ground-radius"


{-| The extent of the flood light effect on the ground beneath the extruded buildings in meters. Note: this experimental property is evaluated once per tile, during tile initialization. Changing the property value could trigger tile reload. The `featureState` styling is deprecated and will get removed soon. Paint property.
Units in meters. Defaults to `0`. Requires `lights`.
-}
fillExtrusionFloodLightGroundRadius : Expression any Float -> LayerAttr FillExtrusion
fillExtrusionFloodLightGroundRadius =
    Expression.encode >> Paint "fill-extrusion-flood-light-ground-radius"


{-| The extent of the flood light effect on the walls of the extruded buildings in meters. Paint property.

Should be greater than or equal to `0`.
Units in meters. Defaults to `0`. Requires `lights`.

-}
fillExtrusionFloodLightWallRadius : Expression any Float -> LayerAttr FillExtrusion
fillExtrusionFloodLightWallRadius =
    Expression.encode >> Paint "fill-extrusion-flood-light-wall-radius"


{-| The geometry's offset. Values are [x, y] where negatives indicate left and up (on the flat plane), respectively. Paint property.
Units in pixels. Defaults to `0,0`.
-}
fillExtrusionTranslate : Expression CameraExpression (Array Float) -> LayerAttr FillExtrusion
fillExtrusionTranslate =
    Expression.encode >> Paint "fill-extrusion-translate"


{-| The height with which to extrude the base of this layer. Must be less than or equal to `fillExtrusionHeight`. Paint property.

Should be greater than or equal to `0`.
Units in meters. Defaults to `0`. Requires `fillExtrusionHeight`.

-}
fillExtrusionBase : Expression any Float -> LayerAttr FillExtrusion
fillExtrusionBase =
    Expression.encode >> Paint "fill-extrusion-base"


{-| The height with which to extrude this layer. Paint property.

Should be greater than or equal to `0`.
Units in meters. Defaults to `0`.

-}
fillExtrusionHeight : Expression any Float -> LayerAttr FillExtrusion
fillExtrusionHeight =
    Expression.encode >> Paint "fill-extrusion-height"


{-| The intensity of the flood light color. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`. Requires `lights`.

-}
fillExtrusionFloodLightIntensity : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionFloodLightIntensity =
    Expression.encode >> Paint "fill-extrusion-flood-light-intensity"


{-| The opacity of the entire fill extrusion layer. This is rendered on a per-layer, not per-feature, basis, and data-driven styling is not available. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
fillExtrusionOpacity : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionOpacity =
    Expression.encode >> Paint "fill-extrusion-opacity"


{-| This parameter defines the range for the fade-out effect before an automatic content cutoff on pitched map views. Fade out is implemented by scaling down and removing buildings in the fade range in a staggered fashion. Opacity is not changed. The fade range is expressed in relation to the height of the map view. A value of 1.0 indicates that the content is faded to the same extent as the map's height in pixels, while a value close to zero represents a sharp cutoff. When the value is set to 0.0, the cutoff is completely disabled. Note: The property has no effect on the map if terrain is enabled. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`.

-}
fillExtrusionCutoffFadeRange : Expression CameraExpression Float -> LayerAttr FillExtrusion
fillExtrusionCutoffFadeRange =
    Expression.encode >> Paint "fill-extrusion-cutoff-fade-range"


{-| Whether to apply a vertical gradient to the sides of a fill-extrusion layer. If true, sides will be shaded slightly darker farther down. Paint property. Defaults to `true`.
-}
fillExtrusionVerticalGradient : Expression CameraExpression Bool -> LayerAttr FillExtrusion
fillExtrusionVerticalGradient =
    Expression.encode >> Paint "fill-extrusion-vertical-gradient"



-- Symbol


{-| Controls the frame of reference for `iconTranslate`. Paint property. Defaults to `map`. Requires `iconImage`. Requires `iconTranslate`.

  - `map`: Icons are translated relative to the map.
  - `viewport`: Icons are translated relative to the viewport.

-}
iconTranslateAnchor : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr Symbol
iconTranslateAnchor =
    Expression.encode >> Paint "icon-translate-anchor"


{-| Controls the frame of reference for `textTranslate`. Paint property. Defaults to `map`. Requires `textField`. Requires `textTranslate`.

  - `map`: The text is translated relative to the map.
  - `viewport`: The text is translated relative to the viewport.

-}
textTranslateAnchor : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr Symbol
textTranslateAnchor =
    Expression.encode >> Paint "text-translate-anchor"


{-| Controls the intensity of light emitted on the source features. Paint property.

Should be greater than or equal to `0`.
Units in intensity. Defaults to `1`. Requires `lights`.

-}
iconEmissiveStrength : Expression any Float -> LayerAttr Symbol
iconEmissiveStrength =
    Expression.encode >> Paint "icon-emissive-strength"


{-| Controls the intensity of light emitted on the source features. Paint property.

Should be greater than or equal to `0`.
Units in intensity. Defaults to `1`. Requires `lights`.

-}
textEmissiveStrength : Expression any Float -> LayerAttr Symbol
textEmissiveStrength =
    Expression.encode >> Paint "text-emissive-strength"


{-| Controls the transition progress between the image variants of icon-image. Zero means the first variant is used, one is the second, and in between they are blended together. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`. Requires `iconImage`.

-}
iconImageCrossFade : Expression any Float -> LayerAttr Symbol
iconImageCrossFade =
    Expression.encode >> Paint "icon-image-cross-fade"


{-| Defines the minimum and maximum scaling factors for icon related properties like `iconSize`, `iconHaloWidth`, `iconHaloBlur` Layout property.

Should be between `0.1` and `10` inclusive. Defaults to `0.8,2`.

-}
iconSizeScaleRange : Expression CameraExpression (Array Float) -> LayerAttr Symbol
iconSizeScaleRange =
    Expression.encode >> Layout "icon-size-scale-range"


{-| Defines the minimum and maximum scaling factors for text related properties like `textSize`, `textMaxWidth`, `textHaloWidth`, `fontSize` Layout property.

Should be between `0.1` and `10` inclusive. Defaults to `0.8,2`.

-}
textSizeScaleRange : Expression CameraExpression (Array Float) -> LayerAttr Symbol
textSizeScaleRange =
    Expression.encode >> Layout "text-size-scale-range"


{-| Determines whether overlapping symbols in the same layer are rendered in the order that they appear in the data source or by their y-position relative to the viewport. To control the order and prioritization of symbols otherwise, use `symbolSortKey`. Layout property. Defaults to `auto`.

  - `auto`: Sorts symbols by `symbolSortKey` if set. Otherwise, sorts symbols by their y-position relative to the viewport if `iconAllowOverlap` or `textAllowOverlap` is set to `true` or `iconIgnorePlacement` or `textIgnorePlacement` is `false`.
  - `viewportY`: Sorts symbols by their y-position relative to the viewport if any of the following is set to `true`: `iconAllowOverlap`, `textAllowOverlap`, `iconIgnorePlacement`, `textIgnorePlacement`.
  - `source`: Sorts symbols by `symbolSortKey` if set. Otherwise, no sorting is applied; symbols are rendered in the same order as the source data.

-}
symbolZOrder : Expression CameraExpression { auto : Supported, viewportY : Supported, source : Supported } -> LayerAttr Symbol
symbolZOrder =
    Expression.encode >> Layout "symbol-z-order"


{-| Distance between two symbol anchors. Layout property.

Should be greater than or equal to `1`.
Units in pixels. Defaults to `250`. Requires `symbolPlacement` to be `line`.

-}
symbolSpacing : Expression CameraExpression Float -> LayerAttr Symbol
symbolSpacing =
    Expression.encode >> Layout "symbol-spacing"


{-| Distance of halo to the font outline. Max text halo width is 1/4 of the font-size. Paint property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `0`. Requires `textField`.

-}
textHaloWidth : Expression any Float -> LayerAttr Symbol
textHaloWidth =
    Expression.encode >> Paint "text-halo-width"


{-| Distance of halo to the icon outline. Paint property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `0`. Requires `iconImage`.

-}
iconHaloWidth : Expression any Float -> LayerAttr Symbol
iconHaloWidth =
    Expression.encode >> Paint "icon-halo-width"


{-| Distance that the icon's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up. Paint property.
Units in pixels. Defaults to `0,0`. Requires `iconImage`.
-}
iconTranslate : Expression CameraExpression (Array Float) -> LayerAttr Symbol
iconTranslate =
    Expression.encode >> Paint "icon-translate"


{-| Distance that the text's anchor is moved from its original placement. Positive values indicate right and down, while negative values indicate left and up. Paint property.
Units in pixels. Defaults to `0,0`. Requires `textField`.
-}
textTranslate : Expression CameraExpression (Array Float) -> LayerAttr Symbol
textTranslate =
    Expression.encode >> Paint "text-translate"


{-| Fade out the halo towards the outside. Paint property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `0`. Requires `iconImage`.

-}
iconHaloBlur : Expression any Float -> LayerAttr Symbol
iconHaloBlur =
    Expression.encode >> Paint "icon-halo-blur"


{-| Font size. Layout property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `16`. Requires `textField`.

-}
textSize : Expression any Float -> LayerAttr Symbol
textSize =
    Expression.encode >> Layout "text-size"


{-| Font stack to use for displaying text. Layout property. Requires `textField`.
-}
textFont : Expression any (Array String) -> LayerAttr Symbol
textFont =
    Expression.encode >> Layout "text-font"


{-| If true, icons will display without their corresponding text when the text collides with other symbols and the icon does not. Layout property. Defaults to `false`. Requires `textField`. Requires `iconImage`.
-}
textOptional : Expression CameraExpression Bool -> LayerAttr Symbol
textOptional =
    Expression.encode >> Layout "text-optional"


{-| If true, other symbols can be visible even if they collide with the icon. Layout property. Defaults to `false`. Requires `iconImage`.
-}
iconIgnorePlacement : Expression CameraExpression Bool -> LayerAttr Symbol
iconIgnorePlacement =
    Expression.encode >> Layout "icon-ignore-placement"


{-| If true, other symbols can be visible even if they collide with the text. Layout property. Defaults to `false`. Requires `textField`.
-}
textIgnorePlacement : Expression CameraExpression Bool -> LayerAttr Symbol
textIgnorePlacement =
    Expression.encode >> Layout "text-ignore-placement"


{-| If true, text will display without their corresponding icons when the icon collides with other symbols and the text does not. Layout property. Defaults to `false`. Requires `iconImage`. Requires `textField`.
-}
iconOptional : Expression CameraExpression Bool -> LayerAttr Symbol
iconOptional =
    Expression.encode >> Layout "icon-optional"


{-| If true, the icon may be flipped to prevent it from being rendered upside-down. Layout property. Defaults to `false`. Requires `iconImage`. Requires `iconRotationAlignment` to be `map`. Requires `symbolPlacement` to be `line`, or `lineCenter`.
-}
iconKeepUpright : Expression CameraExpression Bool -> LayerAttr Symbol
iconKeepUpright =
    Expression.encode >> Layout "icon-keep-upright"


{-| If true, the icon will be visible even if it collides with other previously drawn symbols. Layout property. Defaults to `false`. Requires `iconImage`.
-}
iconAllowOverlap : Expression CameraExpression Bool -> LayerAttr Symbol
iconAllowOverlap =
    Expression.encode >> Layout "icon-allow-overlap"


{-| If true, the symbols will not cross tile edges to avoid mutual collisions. Recommended in layers that don't have enough padding in the vector tile to prevent collisions, or if it is a point symbol layer placed after a line symbol layer. When using a client that supports global collision detection, like Mapbox GL JS version 0.42.0 or greater, enabling this property is not needed to prevent clipped labels at tile boundaries. Layout property. Defaults to `false`.
-}
symbolAvoidEdges : Expression CameraExpression Bool -> LayerAttr Symbol
symbolAvoidEdges =
    Expression.encode >> Layout "symbol-avoid-edges"


{-| If true, the text may be flipped vertically to prevent it from being rendered upside-down. Layout property. Defaults to `true`. Requires `textField`. Requires `textRotationAlignment` to be `map`. Requires `symbolPlacement` to be `line`, or `lineCenter`.
-}
textKeepUpright : Expression CameraExpression Bool -> LayerAttr Symbol
textKeepUpright =
    Expression.encode >> Layout "text-keep-upright"


{-| If true, the text will be visible even if it collides with other previously drawn symbols. Layout property. Defaults to `false`. Requires `textField`.
-}
textAllowOverlap : Expression CameraExpression Bool -> LayerAttr Symbol
textAllowOverlap =
    Expression.encode >> Layout "text-allow-overlap"


{-| In combination with `symbolPlacement`, determines the rotation behavior of icons. Layout property. Defaults to `auto`. Requires `iconImage`.

  - `map`: When `symbolPlacement` is set to `point`, aligns icons east-west. When `symbolPlacement` is set to `line` or `lineCenter`, aligns icon x-axes with the line.
  - `viewport`: Produces icons whose x-axes are aligned with the x-axis of the viewport, regardless of the value of `symbolPlacement`.
  - `auto`: When `symbolPlacement` is set to `point`, this is equivalent to `viewport`. When `symbolPlacement` is set to `line` or `lineCenter`, this is equivalent to `map`.

-}
iconRotationAlignment : Expression CameraExpression { map : Supported, viewport : Supported, auto : Supported } -> LayerAttr Symbol
iconRotationAlignment =
    Expression.encode >> Layout "icon-rotation-alignment"


{-| In combination with `symbolPlacement`, determines the rotation behavior of the individual glyphs forming the text. Layout property. Defaults to `auto`. Requires `textField`.

  - `map`: When `symbolPlacement` is set to `point`, aligns text east-west. When `symbolPlacement` is set to `line` or `lineCenter`, aligns text x-axes with the line.
  - `viewport`: Produces glyphs whose x-axes are aligned with the x-axis of the viewport, regardless of the value of `symbolPlacement`.
  - `auto`: When `symbolPlacement` is set to `point`, this is equivalent to `viewport`. When `symbolPlacement` is set to `line` or `lineCenter`, this is equivalent to `map`.

-}
textRotationAlignment : Expression CameraExpression { map : Supported, viewport : Supported, auto : Supported } -> LayerAttr Symbol
textRotationAlignment =
    Expression.encode >> Layout "text-rotation-alignment"


{-| Increase or reduce the brightness of the symbols. The value is the maximum brightness. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
iconColorBrightnessMax : Expression CameraExpression Float -> LayerAttr Symbol
iconColorBrightnessMax =
    Expression.encode >> Paint "icon-color-brightness-max"


{-| Increase or reduce the brightness of the symbols. The value is the minimum brightness. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`.

-}
iconColorBrightnessMin : Expression CameraExpression Float -> LayerAttr Symbol
iconColorBrightnessMin =
    Expression.encode >> Paint "icon-color-brightness-min"


{-| Increase or reduce the contrast of the symbol icon. Paint property.

Should be between `-1` and `1` inclusive. Defaults to `0`.

-}
iconColorContrast : Expression CameraExpression Float -> LayerAttr Symbol
iconColorContrast =
    Expression.encode >> Paint "icon-color-contrast"


{-| Increase or reduce the saturation of the symbol icon. Paint property.

Should be between `-1` and `1` inclusive. Defaults to `0`.

-}
iconColorSaturation : Expression CameraExpression Float -> LayerAttr Symbol
iconColorSaturation =
    Expression.encode >> Paint "icon-color-saturation"


{-| Label placement relative to its geometry. Layout property. Defaults to `point`.

  - `point`: The label is placed at the point where the geometry is located.
  - `line`: The label is placed along the line of the geometry. Can only be used on `lineString` and `polygon` geometries.
  - `lineCenter`: The label is placed at the center of the line of the geometry. Can only be used on `lineString` and `polygon` geometries. Note that a single feature in a vector tile may contain multiple line geometries.

-}
symbolPlacement : Expression CameraExpression { point : Supported, line : Supported, lineCenter : Supported } -> LayerAttr Symbol
symbolPlacement =
    Expression.encode >> Layout "symbol-placement"


{-| Maximum angle change between adjacent characters. Layout property.
Units in degrees. Defaults to `45`. Requires `textField`. Requires `symbolPlacement` to be `line`, or `lineCenter`.
-}
textMaxAngle : Expression CameraExpression Float -> LayerAttr Symbol
textMaxAngle =
    Expression.encode >> Layout "text-max-angle"


{-| Name of image in sprite to use for drawing an image background. Layout property.
-}
iconImage : Expression any String -> LayerAttr Symbol
iconImage =
    Expression.encode >> Layout "icon-image"


{-| Offset distance of icon from its anchor. Positive values indicate right and down, while negative values indicate left and up. Each component is multiplied by the value of `iconSize` to obtain the final offset in pixels. When combined with `iconRotate` the offset will be as if the rotated direction was up. Layout property. Defaults to `0,0`. Requires `iconImage`.
-}
iconOffset : Expression any (Array Float) -> LayerAttr Symbol
iconOffset =
    Expression.encode >> Layout "icon-offset"


{-| Offset distance of text from its anchor. Positive values indicate right and down, while negative values indicate left and up. If used with text-variable-anchor, input values will be taken as absolute values. Offsets along the x- and y-axis will be applied automatically based on the anchor position. Layout property.
Units in ems. Defaults to `0,0`. Requires `textField`. Disabled by `textRadialOffset`.
-}
textOffset : Expression any (Array Float) -> LayerAttr Symbol
textOffset =
    Expression.encode >> Layout "text-offset"


{-| Orientation of icon when map is pitched. Layout property. Defaults to `auto`. Requires `iconImage`.

  - `map`: The icon is aligned to the plane of the map.
  - `viewport`: The icon is aligned to the plane of the viewport.
  - `auto`: Automatically matches the value of `iconRotationAlignment`.

-}
iconPitchAlignment : Expression CameraExpression { map : Supported, viewport : Supported, auto : Supported } -> LayerAttr Symbol
iconPitchAlignment =
    Expression.encode >> Layout "icon-pitch-alignment"


{-| Orientation of text when map is pitched. Layout property. Defaults to `auto`. Requires `textField`.

  - `map`: The text is aligned to the plane of the map.
  - `viewport`: The text is aligned to the plane of the viewport.
  - `auto`: Automatically matches the value of `textRotationAlignment`.

-}
textPitchAlignment : Expression CameraExpression { map : Supported, viewport : Supported, auto : Supported } -> LayerAttr Symbol
textPitchAlignment =
    Expression.encode >> Layout "text-pitch-alignment"


{-| Part of the icon placed closest to the anchor. Layout property. Defaults to `center`. Requires `iconImage`.

  - `center`: The center of the icon is placed closest to the anchor.
  - `left`: The left side of the icon is placed closest to the anchor.
  - `right`: The right side of the icon is placed closest to the anchor.
  - `top`: The top of the icon is placed closest to the anchor.
  - `bottom`: The bottom of the icon is placed closest to the anchor.
  - `topLeft`: The top left corner of the icon is placed closest to the anchor.
  - `topRight`: The top right corner of the icon is placed closest to the anchor.
  - `bottomLeft`: The bottom left corner of the icon is placed closest to the anchor.
  - `bottomRight`: The bottom right corner of the icon is placed closest to the anchor.

-}
iconAnchor : Expression any { center : Supported, left : Supported, right : Supported, top : Supported, bottom : Supported, topLeft : Supported, topRight : Supported, bottomLeft : Supported, bottomRight : Supported } -> LayerAttr Symbol
iconAnchor =
    Expression.encode >> Layout "icon-anchor"


{-| Part of the text placed closest to the anchor. Layout property. Defaults to `center`. Requires `textField`. Disabled by `textVariableAnchor`.

  - `center`: The center of the text is placed closest to the anchor.
  - `left`: The left side of the text is placed closest to the anchor.
  - `right`: The right side of the text is placed closest to the anchor.
  - `top`: The top of the text is placed closest to the anchor.
  - `bottom`: The bottom of the text is placed closest to the anchor.
  - `topLeft`: The top left corner of the text is placed closest to the anchor.
  - `topRight`: The top right corner of the text is placed closest to the anchor.
  - `bottomLeft`: The bottom left corner of the text is placed closest to the anchor.
  - `bottomRight`: The bottom right corner of the text is placed closest to the anchor.

-}
textAnchor : Expression any { center : Supported, left : Supported, right : Supported, top : Supported, bottom : Supported, topLeft : Supported, topRight : Supported, bottomLeft : Supported, bottomRight : Supported } -> LayerAttr Symbol
textAnchor =
    Expression.encode >> Layout "text-anchor"


{-| Position symbol on buildings (both fill extrusions and models) rooftops. In order to have minimal impact on performance, this is supported only when `fillExtrusionHeight` is not zoom-dependent and remains unchanged. For fading in buildings when zooming in, fill-extrusion-vertical-scale should be used and symbols would raise with building rooftops. Symbols are sorted by elevation, except in cases when `viewportY` sorting or `symbolSortKey` are applied. Layout property. Defaults to `false`. Requires `symbolPlacement` to be `point`. Requires `symbolZOrder` to be `auto`.
-}
symbolZElevate : Expression CameraExpression Bool -> LayerAttr Symbol
symbolZElevate =
    Expression.encode >> Layout "symbol-z-elevate"


{-| Radial offset of text, in the direction of the symbol's anchor. Useful in combination with `textVariableAnchor`, which defaults to using the two-dimensional `textOffset` if present. Layout property.
Units in ems. Defaults to `0`. Requires `textField`.
-}
textRadialOffset : Expression any Float -> LayerAttr Symbol
textRadialOffset =
    Expression.encode >> Layout "text-radial-offset"


{-| Rotates the icon clockwise. Layout property.
Units in degrees. Defaults to `0`. Requires `iconImage`.
-}
iconRotate : Expression any Float -> LayerAttr Symbol
iconRotate =
    Expression.encode >> Layout "icon-rotate"


{-| Rotates the text clockwise. Layout property.
Units in degrees. Defaults to `0`. Requires `textField`.
-}
textRotate : Expression any Float -> LayerAttr Symbol
textRotate =
    Expression.encode >> Layout "text-rotate"


{-| Scales the icon to fit around the associated text. Layout property. Defaults to `none`. Requires `iconImage`. Requires `textField`.

  - `none`: The icon is displayed at its intrinsic aspect ratio.
  - `width`: The icon is scaled in the x-dimension to fit the width of the text.
  - `height`: The icon is scaled in the y-dimension to fit the height of the text.
  - `both`: The icon is scaled in both x- and y-dimensions.

-}
iconTextFit : Expression any { none : Supported, width : Supported, height : Supported, both : Supported } -> LayerAttr Symbol
iconTextFit =
    Expression.encode >> Layout "icon-text-fit"


{-| Scales the original size of the icon by the provided factor. The new pixel size of the image will be the original pixel size multiplied by `iconSize`. 1 is the original size; 3 triples the size of the image. Layout property.

Should be greater than or equal to `0`.
Units in factor of the original icon size. Defaults to `1`. Requires `iconImage`.

-}
iconSize : Expression any Float -> LayerAttr Symbol
iconSize =
    Expression.encode >> Layout "icon-size"


{-| Selects the base of symbol-elevation. Layout property. Defaults to `ground`.

  - `sea`: Elevate symbols relative to the sea level.
  - `ground`: Elevate symbols relative to the ground's height below them.
  - `hdRoadMarkup`: Use this mode to enable elevated behavior for features that are rendered on top of 3D road polygons. The feature is currently being developed.

-}
symbolElevationReference : Expression CameraExpression { sea : Supported, ground : Supported, hdRoadMarkup : Supported } -> LayerAttr Symbol
symbolElevationReference =
    Expression.encode >> Layout "symbol-elevation-reference"


{-| Size of the additional area added to dimensions determined by `iconTextFit`, in clockwise order: top, right, bottom, left. Layout property.
Units in pixels. Defaults to `0,0,0,0`. Requires `iconImage`. Requires `textField`. Requires `iconTextFit` to be `both`, or `width`, or `height`.
-}
iconTextFitPadding : Expression any (Array Float) -> LayerAttr Symbol
iconTextFitPadding =
    Expression.encode >> Layout "icon-text-fit-padding"


{-| Size of the additional area around the icon bounding box used for detecting symbol collisions. Layout property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `2`. Requires `iconImage`.

-}
iconPadding : Expression CameraExpression Float -> LayerAttr Symbol
iconPadding =
    Expression.encode >> Layout "icon-padding"


{-| Size of the additional area around the text bounding box used for detecting symbol collisions. Layout property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `2`. Requires `textField`.

-}
textPadding : Expression CameraExpression Float -> LayerAttr Symbol
textPadding =
    Expression.encode >> Layout "text-padding"


{-| Sorts features in ascending order based on this value. Features with lower sort keys are drawn and placed first. When `iconAllowOverlap` or `textAllowOverlap` is `false`, features with a lower sort key will have priority during placement. When `iconAllowOverlap` or `textAllowOverlap` is set to `true`, features with a higher sort key will overlap over features with a lower sort key. Layout property.
-}
symbolSortKey : Expression any Float -> LayerAttr Symbol
symbolSortKey =
    Expression.encode >> Layout "symbol-sort-key"


{-| Specifies an uniform elevation from the ground, in meters. Paint property.

Should be greater than or equal to `0`. Defaults to `0`.

-}
symbolZOffset : Expression any Float -> LayerAttr Symbol
symbolZOffset =
    Expression.encode >> Paint "symbol-z-offset"


{-| Specifies how to capitalize text, similar to the CSS `textTransform` property. Layout property. Defaults to `none`. Requires `textField`.

  - `none`: The text is not altered.
  - `uppercase`: Forces all letters to be displayed in uppercase.
  - `lowercase`: Forces all letters to be displayed in lowercase.

-}
textTransform : Expression any { none : Supported, uppercase : Supported, lowercase : Supported } -> LayerAttr Symbol
textTransform =
    Expression.encode >> Layout "text-transform"


{-| Text justification options. Layout property. Defaults to `center`. Requires `textField`.

  - `auto`: The text is aligned towards the anchor position.
  - `left`: The text is aligned to the left.
  - `center`: The text is centered.
  - `right`: The text is aligned to the right.

-}
textJustify : Expression any { auto : Supported, left : Supported, center : Supported, right : Supported } -> LayerAttr Symbol
textJustify =
    Expression.encode >> Layout "text-justify"


{-| Text leading value for multi-line text. Layout property.
Units in ems. Defaults to `1.2`. Requires `textField`.
-}
textLineHeight : Expression any Float -> LayerAttr Symbol
textLineHeight =
    Expression.encode >> Layout "text-line-height"


{-| Text tracking amount. Layout property.
Units in ems. Defaults to `0`. Requires `textField`.
-}
textLetterSpacing : Expression any Float -> LayerAttr Symbol
textLetterSpacing =
    Expression.encode >> Layout "text-letter-spacing"


{-| The color of the icon's halo. Icon halos can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/). Paint property. Defaults to `rgba 0 0 0 0`. Requires `iconImage`.
-}
iconHaloColor : Expression any Color -> LayerAttr Symbol
iconHaloColor =
    Expression.encode >> Paint "icon-halo-color"


{-| The color of the icon. This can only be used with [SDF icons](/help/troubleshooting/using-recolorable-images-in-mapbox-maps/). Paint property. Defaults to `#000000`. Requires `iconImage`.
-}
iconColor : Expression any Color -> LayerAttr Symbol
iconColor =
    Expression.encode >> Paint "icon-color"


{-| The color of the text's halo, which helps it stand out from backgrounds. Paint property. Defaults to `rgba 0 0 0 0`. Requires `textField`.
-}
textHaloColor : Expression any Color -> LayerAttr Symbol
textHaloColor =
    Expression.encode >> Paint "text-halo-color"


{-| The color with which the text will be drawn. Paint property. Defaults to `#000000`. Requires `textField`.
-}
textColor : Expression any Color -> LayerAttr Symbol
textColor =
    Expression.encode >> Paint "text-color"


{-| The halo's fadeout distance towards the outside. Paint property.

Should be greater than or equal to `0`.
Units in pixels. Defaults to `0`. Requires `textField`.

-}
textHaloBlur : Expression any Float -> LayerAttr Symbol
textHaloBlur =
    Expression.encode >> Paint "text-halo-blur"


{-| The maximum line width for text wrapping. Layout property.

Should be greater than or equal to `0`.
Units in ems. Defaults to `10`. Requires `textField`. Requires `symbolPlacement` to be `point`.

-}
textMaxWidth : Expression any Float -> LayerAttr Symbol
textMaxWidth =
    Expression.encode >> Layout "text-max-width"


{-| The opacity at which the icon will be drawn in case of being depth occluded. Absent value means full occlusion against terrain only. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`. Requires `iconImage`.

-}
iconOcclusionOpacity : Expression any Float -> LayerAttr Symbol
iconOcclusionOpacity =
    Expression.encode >> Paint "icon-occlusion-opacity"


{-| The opacity at which the icon will be drawn. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`. Requires `iconImage`.

-}
iconOpacity : Expression any Float -> LayerAttr Symbol
iconOpacity =
    Expression.encode >> Paint "icon-opacity"


{-| The opacity at which the text will be drawn in case of being depth occluded. Absent value means full occlusion against terrain only. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`. Requires `textField`.

-}
textOcclusionOpacity : Expression any Float -> LayerAttr Symbol
textOcclusionOpacity =
    Expression.encode >> Paint "text-occlusion-opacity"


{-| The opacity at which the text will be drawn. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`. Requires `textField`.

-}
textOpacity : Expression any Float -> LayerAttr Symbol
textOpacity =
    Expression.encode >> Paint "text-opacity"


{-| The property allows control over a symbol's orientation. Note that the property values act as a hint, so that a symbol whose language doesn’t support the provided orientation will be laid out in its natural orientation. Example: English point symbol will be rendered horizontally even if array value contains single 'vertical' enum value. For symbol with point placement, the order of elements in an array define priority order for the placement of an orientation variant. For symbol with line placement, the default text writing mode is either ['horizontal', 'vertical'] or ['vertical', 'horizontal'], the order doesn't affect the placement. Layout property. Requires `textField`.

  - `horizontal`: If a text's language supports horizontal writing mode, symbols would be laid out horizontally.
  - `vertical`: If a text's language supports vertical writing mode, symbols would be laid out vertically.

-}
textWritingMode : Expression CameraExpression FormattedText -> LayerAttr Symbol
textWritingMode =
    Expression.encode >> Layout "text-writing-mode"


{-| To increase the chance of placing high-priority labels on the map, you can provide an array of `textAnchor` locations: the renderer will attempt to place the label at each location, in order, before moving onto the next label. Use `textJustify:Auto` to choose justification based on anchor position. To apply an offset, use the `textRadialOffset` or the two-dimensional `textOffset`. Layout property. Requires `textField`. Requires `symbolPlacement` to be `point`.

  - `center`: The center of the text is placed closest to the anchor.
  - `left`: The left side of the text is placed closest to the anchor.
  - `right`: The right side of the text is placed closest to the anchor.
  - `top`: The top of the text is placed closest to the anchor.
  - `bottom`: The bottom of the text is placed closest to the anchor.
  - `topLeft`: The top left corner of the text is placed closest to the anchor.
  - `topRight`: The top right corner of the text is placed closest to the anchor.
  - `bottomLeft`: The bottom left corner of the text is placed closest to the anchor.
  - `bottomRight`: The bottom right corner of the text is placed closest to the anchor.

-}
textVariableAnchor : Expression CameraExpression FormattedText -> LayerAttr Symbol
textVariableAnchor =
    Expression.encode >> Layout "text-variable-anchor"


{-| Value to use for a text label. Layout property. Defaults to `""`.
-}
textField : Expression any FormattedText -> LayerAttr Symbol
textField =
    Expression.encode >> Layout "text-field"



-- Raster


{-| Controls the intensity of light emitted on the source features. Paint property.

Should be greater than or equal to `0`.
Units in intensity. Defaults to `0`. Requires `lights`.

-}
rasterEmissiveStrength : Expression CameraExpression Float -> LayerAttr Raster
rasterEmissiveStrength =
    Expression.encode >> Paint "raster-emissive-strength"


{-| Defines a color map by which to colorize a raster layer, parameterized by the `["RasterValue"]` expression and evaluated at 256 uniformly spaced steps over the range specified by `rasterColorRange`. Paint property.
-}
rasterColor : Expression CameraExpression Color -> LayerAttr Raster
rasterColor =
    Expression.encode >> Paint "raster-color"


{-| Displayed band of raster array source layer. Defaults to the first band if not set. Paint property. Requires `source` to be `raster-array`.
-}
rasterArrayBand : Expression CameraExpression String -> LayerAttr Raster
rasterArrayBand =
    Expression.encode >> Paint "raster-array-band"


{-| Fade duration when a new tile is added. Paint property.

Should be greater than or equal to `0`.
Units in milliseconds. Defaults to `300`.

-}
rasterFadeDuration : Expression CameraExpression Float -> LayerAttr Raster
rasterFadeDuration =
    Expression.encode >> Paint "raster-fade-duration"


{-| Increase or reduce the brightness of the image. The value is the maximum brightness. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
rasterBrightnessMax : Expression CameraExpression Float -> LayerAttr Raster
rasterBrightnessMax =
    Expression.encode >> Paint "raster-brightness-max"


{-| Increase or reduce the brightness of the image. The value is the minimum brightness. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`.

-}
rasterBrightnessMin : Expression CameraExpression Float -> LayerAttr Raster
rasterBrightnessMin =
    Expression.encode >> Paint "raster-brightness-min"


{-| Increase or reduce the contrast of the image. Paint property.

Should be between `-1` and `1` inclusive. Defaults to `0`.

-}
rasterContrast : Expression CameraExpression Float -> LayerAttr Raster
rasterContrast =
    Expression.encode >> Paint "raster-contrast"


{-| Increase or reduce the saturation of the image. Paint property.

Should be between `-1` and `1` inclusive. Defaults to `0`.

-}
rasterSaturation : Expression CameraExpression Float -> LayerAttr Raster
rasterSaturation =
    Expression.encode >> Paint "raster-saturation"


{-| Rotates hues around the color wheel. Paint property.
Units in degrees. Defaults to `0`.
-}
rasterHueRotate : Expression CameraExpression Float -> LayerAttr Raster
rasterHueRotate =
    Expression.encode >> Paint "raster-hue-rotate"


{-| Specifies an uniform elevation from the ground, in meters. Paint property.

Should be greater than or equal to `0`. Defaults to `0`.

-}
rasterElevation : Expression CameraExpression Float -> LayerAttr Raster
rasterElevation =
    Expression.encode >> Paint "raster-elevation"


{-| The opacity at which the image will be drawn. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
rasterOpacity : Expression CameraExpression Float -> LayerAttr Raster
rasterOpacity =
    Expression.encode >> Paint "raster-opacity"


{-| The resampling/interpolation method to use for overscaling, also known as texture magnification filter Paint property. Defaults to `linear`.

  - `linear`: (Bi)linear filtering interpolates pixel values using the weighted average of the four closest original source pixels creating a smooth but blurry look when overscaled
  - `nearest`: Nearest neighbor filtering interpolates pixel values using the nearest original source pixel creating a sharp but pixelated look when overscaled

-}
rasterResampling : Expression CameraExpression { linear : Supported, nearest : Supported } -> LayerAttr Raster
rasterResampling =
    Expression.encode >> Paint "raster-resampling"


{-| When `rasterColor` is active, specifies the combination of source RGB channels used to compute the raster value. Computed using the equation `mix.R*Src.R+Mix.G*Src.G+Mix.B*Src.B+Mix.A`. The first three components specify the mix of source red, green, and blue channels, respectively. The fourth component serves as a constant offset and is _not_ multipled by source alpha. Source alpha is instead carried through and applied as opacity to the colorized result. Default value corresponds to RGB luminosity. Paint property. Defaults to `0.2126,0.7152,0.0722,0`. Requires `rasterColor`.
-}
rasterColorMix : Expression CameraExpression (Array Float) -> LayerAttr Raster
rasterColorMix =
    Expression.encode >> Paint "raster-color-mix"


{-| When `rasterColor` is active, specifies the range over which `rasterColor` is tabulated. Units correspond to the computed raster value via `rasterColorMix`. For `rasterarray` sources, if `rasterColorRange` is unspecified, the source's stated data range is used. Paint property. Requires `rasterColor`.
-}
rasterColorRange : Expression CameraExpression (Array Float) -> LayerAttr Raster
rasterColorRange =
    Expression.encode >> Paint "raster-color-range"



-- RasterParticle


{-| Defines a coefficient for a time period at which particles will restart at a random position, to avoid degeneration (empty areas without particles). Paint property.

Should be between `0` and `1` inclusive. Defaults to `0.8`.

-}
rasterParticleResetRateFactor : Expression CameraExpression Float -> LayerAttr RasterParticle
rasterParticleResetRateFactor =
    Expression.encode >> Paint "raster-particle-reset-rate-factor"


{-| Defines a coefficient for the speed of particles’ motion. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0.2`.

-}
rasterParticleSpeedFactor : Expression CameraExpression Float -> LayerAttr RasterParticle
rasterParticleSpeedFactor =
    Expression.encode >> Paint "raster-particle-speed-factor"


{-| Defines a color map by which to colorize a raster particle layer, parameterized by the `["RasterParticleSpeed"]` expression and evaluated at 256 uniformly spaced steps over the range specified by `rasterParticleMaxSpeed`. Paint property.
-}
rasterParticleColor : Expression CameraExpression Color -> LayerAttr RasterParticle
rasterParticleColor =
    Expression.encode >> Paint "raster-particle-color"


{-| Defines defines the opacity coefficient applied to the faded particles in each frame. In practice, this property controls the length of the particle tail. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0.98`.

-}
rasterParticleFadeOpacityFactor : Expression CameraExpression Float -> LayerAttr RasterParticle
rasterParticleFadeOpacityFactor =
    Expression.encode >> Paint "raster-particle-fade-opacity-factor"


{-| Defines the amount of particles per tile. Paint property.

Should be greater than or equal to `1`. Defaults to `512`.

-}
rasterParticleCount : Expression CameraExpression Float -> LayerAttr RasterParticle
rasterParticleCount =
    Expression.encode >> Paint "raster-particle-count"


{-| Defines the maximum speed for particles. Velocities with magnitudes equal to or exceeding this value are clamped to the max value. Paint property.

Should be greater than or equal to `1`. Defaults to `1`.

-}
rasterParticleMaxSpeed : Expression CameraExpression Float -> LayerAttr RasterParticle
rasterParticleMaxSpeed =
    Expression.encode >> Paint "raster-particle-max-speed"


{-| Displayed band of raster array source layer Paint property.
-}
rasterParticleArrayBand : Expression CameraExpression String -> LayerAttr RasterParticle
rasterParticleArrayBand =
    Expression.encode >> Paint "raster-particle-array-band"


{-| Specifies an uniform elevation from the ground, in meters. Paint property.

Should be greater than or equal to `0`. Defaults to `0`.

-}
rasterParticleElevation : Expression CameraExpression Float -> LayerAttr RasterParticle
rasterParticleElevation =
    Expression.encode >> Paint "raster-particle-elevation"



-- Hillshade


{-| Controls the intensity of light emitted on the source features. Paint property.

Should be greater than or equal to `0`.
Units in intensity. Defaults to `0`. Requires `lights`.

-}
hillshadeEmissiveStrength : Expression CameraExpression Float -> LayerAttr Hillshade
hillshadeEmissiveStrength =
    Expression.encode >> Paint "hillshade-emissive-strength"


{-| Direction of light source when map is rotated. Paint property. Defaults to `viewport`.

  - `map`: The hillshade illumination is relative to the north direction.
  - `viewport`: The hillshade illumination is relative to the top of the viewport.

-}
hillshadeIlluminationAnchor : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr Hillshade
hillshadeIlluminationAnchor =
    Expression.encode >> Paint "hillshade-illumination-anchor"


{-| Intensity of the hillshade Paint property.

Should be between `0` and `1` inclusive. Defaults to `0.5`.

-}
hillshadeExaggeration : Expression CameraExpression Float -> LayerAttr Hillshade
hillshadeExaggeration =
    Expression.encode >> Paint "hillshade-exaggeration"


{-| The direction of the light source used to generate the hillshading with 0 as the top of the viewport if `hillshadeIlluminationAnchor` is set to `viewport` and due north if `hillshadeIlluminationAnchor` is set to `map` and no 3d lights enabled. If `hillshadeIlluminationAnchor` is set to `map` and 3d lights enabled, the direction from 3d lights is used instead. Paint property.

Should be between `0` and `359` inclusive. Defaults to `335`.

-}
hillshadeIlluminationDirection : Expression CameraExpression Float -> LayerAttr Hillshade
hillshadeIlluminationDirection =
    Expression.encode >> Paint "hillshade-illumination-direction"


{-| The shading color of areas that face away from the light source. Paint property. Defaults to `#000000`.
-}
hillshadeShadowColor : Expression CameraExpression Color -> LayerAttr Hillshade
hillshadeShadowColor =
    Expression.encode >> Paint "hillshade-shadow-color"


{-| The shading color of areas that faces towards the light source. Paint property. Defaults to `#FFFFFF`.
-}
hillshadeHighlightColor : Expression CameraExpression Color -> LayerAttr Hillshade
hillshadeHighlightColor =
    Expression.encode >> Paint "hillshade-highlight-color"


{-| The shading color used to accentuate rugged terrain like sharp cliffs and gorges. Paint property. Defaults to `#000000`.
-}
hillshadeAccentColor : Expression CameraExpression Color -> LayerAttr Hillshade
hillshadeAccentColor =
    Expression.encode >> Paint "hillshade-accent-color"



-- Background


{-| Controls the intensity of light emitted on the source features. Paint property.

Should be greater than or equal to `0`.
Units in intensity. Defaults to `0`. Requires `lights`.

-}
backgroundEmissiveStrength : Expression CameraExpression Float -> LayerAttr Background
backgroundEmissiveStrength =
    Expression.encode >> Paint "background-emissive-strength"


{-| Name of image in sprite to use for drawing an image background. For seamless patterns, image width and height must be a factor of two (2, 4, 8, ..., 512). Note that zoom-dependent expressions will be evaluated only at integer zoom levels. Paint property.
-}
backgroundPattern : Expression CameraExpression String -> LayerAttr Background
backgroundPattern =
    Expression.encode >> Paint "background-pattern"


{-| Orientation of background layer. Paint property. Defaults to `map`.

  - `map`: The background is aligned to the plane of the map.
  - `viewport`: The background is aligned to the plane of the viewport, covering the whole screen. Note: This mode disables the automatic reordering of the layer when terrain or globe projection is used.

-}
backgroundPitchAlignment : Expression CameraExpression { map : Supported, viewport : Supported } -> LayerAttr Background
backgroundPitchAlignment =
    Expression.encode >> Paint "background-pitch-alignment"


{-| The color with which the background will be drawn. Paint property. Defaults to `#000000`. Disabled by `backgroundPattern`.
-}
backgroundColor : Expression CameraExpression Color -> LayerAttr Background
backgroundColor =
    Expression.encode >> Paint "background-color"


{-| The opacity at which the background will be drawn. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
backgroundOpacity : Expression CameraExpression Float -> LayerAttr Background
backgroundOpacity =
    Expression.encode >> Paint "background-opacity"



-- Sky


{-| A color applied to the atmosphere sun halo. The alpha channel describes how strongly the sun halo is represented in an atmosphere sky layer. Paint property. Defaults to `white`. Requires `skyType` to be `atmosphere`.
-}
skyAtmosphereHaloColor : Expression CameraExpression Color -> LayerAttr Sky
skyAtmosphereHaloColor =
    Expression.encode >> Paint "sky-atmosphere-halo-color"


{-| A color used to tweak the main atmospheric scattering coefficients. Using white applies the default coefficients giving the natural blue color to the atmosphere. This color affects how heavily the corresponding wavelength is represented during scattering. The alpha channel describes the density of the atmosphere, with 1 maximum density and 0 no density. Paint property. Defaults to `white`. Requires `skyType` to be `atmosphere`.
-}
skyAtmosphereColor : Expression CameraExpression Color -> LayerAttr Sky
skyAtmosphereColor =
    Expression.encode >> Paint "sky-atmosphere-color"


{-| Defines a radial color gradient with which to color the sky. The color values can be interpolated with an expression using `skyRadialProgress`. The range [0, 1] for the interpolant covers a radial distance (in degrees) of [0, `skyGradientRadius`] centered at the position specified by `skyGradientCenter`. Paint property. Defaults to `interpolate,Linear,SkyRadialProgress,0.8,#87ceeb,1,White`. Requires `skyType` to be `gradient`.
-}
skyGradient : Expression CameraExpression Color -> LayerAttr Sky
skyGradient =
    Expression.encode >> Paint "sky-gradient"


{-| Intensity of the sun as a light source in the atmosphere (on a scale from 0 to a 100). Setting higher values will brighten up the sky. Paint property.

Should be between `0` and `100` inclusive. Defaults to `10`. Requires `skyType` to be `atmosphere`.

-}
skyAtmosphereSunIntensity : Expression CameraExpression Float -> LayerAttr Sky
skyAtmosphereSunIntensity =
    Expression.encode >> Paint "sky-atmosphere-sun-intensity"


{-| Position of the gradient center [a azimuthal angle, p polar angle]. The azimuthal angle indicates the position of the gradient center relative to 0° north, where degrees proceed clockwise. The polar angle indicates the height of the gradient center, where 0° is directly above, at zenith, and 90° at the horizon. Paint property.

Should be between `0,0` and `360,180` inclusive.
Units in degrees. Defaults to `0,0`. Requires `skyType` to be `gradient`.

-}
skyGradientCenter : Expression CameraExpression (Array Float) -> LayerAttr Sky
skyGradientCenter =
    Expression.encode >> Paint "sky-gradient-center"


{-| Position of the sun center [a azimuthal angle, p polar angle]. The azimuthal angle indicates the position of the sun relative to 0° north, where degrees proceed clockwise. The polar angle indicates the height of the sun, where 0° is directly above, at zenith, and 90° at the horizon. When this property is ommitted, the sun center is directly inherited from the light position. Paint property.

Should be between `0,0` and `360,180` inclusive.
Units in degrees. Requires `skyType` to be `atmosphere`.

-}
skyAtmosphereSun : Expression CameraExpression (Array Float) -> LayerAttr Sky
skyAtmosphereSun =
    Expression.encode >> Paint "sky-atmosphere-sun"


{-| The angular distance (measured in degrees) from `skyGradientCenter` up to which the gradient extends. A value of 180 causes the gradient to wrap around to the opposite direction from `skyGradientCenter`. Paint property.

Should be between `0` and `180` inclusive. Defaults to `90`. Requires `skyType` to be `gradient`.

-}
skyGradientRadius : Expression CameraExpression Float -> LayerAttr Sky
skyGradientRadius =
    Expression.encode >> Paint "sky-gradient-radius"


{-| The opacity of the entire sky layer. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
skyOpacity : Expression CameraExpression Float -> LayerAttr Sky
skyOpacity =
    Expression.encode >> Paint "sky-opacity"


{-| The type of the sky Paint property. Defaults to `atmosphere`.

  - `gradient`: Renders the sky with a gradient that can be configured with `skyGradientRadius` and `skyGradient`.
  - `atmosphere`: Renders the sky with a simulated atmospheric scattering algorithm, the sun direction can be attached to the light position or explicitly set through `skyAtmosphereSun`.

-}
skyType : Expression CameraExpression { gradient : Supported, atmosphere : Supported } -> LayerAttr Sky
skyType =
    Expression.encode >> Paint "sky-type"



-- Model


{-| An array for configuring the fade-out effect for the front cutoff of content on pitched map views. It contains three values: start, range and final opacity. The start parameter defines the point at which the fade-out effect begins, with smaller values causing the effect to start earlier. The range parameter specifies how long the fade-out effect will last. A value of 0.0 for range makes content disappear immediately without a fade-out effect. The final opacity determines content opacity at the end of the fade-out effect. A value of 1.0 for final opacity means that the cutoff is completely disabled. Paint property.

Should be between `0,0,0` and `1,1,1` inclusive. Defaults to `0,0,1`.

-}
modelFrontCutoff : Expression CameraExpression (Array Float) -> LayerAttr Model
modelFrontCutoff =
    Expression.encode >> Paint "model-front-cutoff"


{-| Defines rendering behavior of model in respect to other 3D scene objects. Paint property. Defaults to `common3d`.

  - `common3d`: Integrated to 3D scene, using depth testing, along with terrain, fill-extrusions and custom layer.
  - `locationIndicator`: Displayed over other 3D content, occluded by terrain.

-}
modelType : Expression CameraExpression { common3d : Supported, locationIndicator : Supported } -> LayerAttr Model
modelType =
    Expression.encode >> Paint "model-type"


{-| Emissive strength multiplier along model height (gradient begin, gradient end, value at begin, value at end, gradient curve power (logarithmic scale, curve power = pow(10, val)). Paint property. Defaults to `1,1,1,1,0`.
-}
modelHeightBasedEmissiveStrengthMultiplier : Expression any (Array Float) -> LayerAttr Model
modelHeightBasedEmissiveStrengthMultiplier =
    Expression.encode >> Paint "model-height-based-emissive-strength-multiplier"


{-| Enable/Disable shadow casting for this layer Paint property. Defaults to `true`.
-}
modelCastShadows : Expression CameraExpression Bool -> LayerAttr Model
modelCastShadows =
    Expression.encode >> Paint "model-cast-shadows"


{-| Enable/Disable shadow receiving for this layer Paint property. Defaults to `true`.
-}
modelReceiveShadows : Expression CameraExpression Bool -> LayerAttr Model
modelReceiveShadows =
    Expression.encode >> Paint "model-receive-shadows"


{-| Intensity of model-color (on a scale from 0 to 1) in color mix with original 3D model's colors. Higher number will present a higher model-color contribution in mix. Expressions that depend on measure-light are not supported when using GeoJSON or vector tile as the model layer source. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`.

-}
modelColorMixIntensity : Expression any Float -> LayerAttr Model
modelColorMixIntensity =
    Expression.encode >> Paint "model-color-mix-intensity"


{-| Intensity of the ambient occlusion if present in the 3D model. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
modelAmbientOcclusionIntensity : Expression CameraExpression Float -> LayerAttr Model
modelAmbientOcclusionIntensity =
    Expression.encode >> Paint "model-ambient-occlusion-intensity"


{-| Material roughness. Material is fully smooth for value 0, and fully rough for value 1. Affects only layers using batched-model source. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
modelRoughness : Expression any Float -> LayerAttr Model
modelRoughness =
    Expression.encode >> Paint "model-roughness"


{-| Model to render. It can be either a string referencing an element to the models root property or an internal or external URL Layout property. Defaults to `""`. Requires `source` to be `geojson`, or `vector`.
-}
modelId : Expression any String -> LayerAttr Model
modelId =
    Expression.encode >> Layout "model-id"


{-| Strength of the emission. There is no emission for value 0. For value 1.0, only emissive component (no shading) is displayed and values above 1.0 produce light contribution to surrounding area, for some of the parts (e.g. doors). Expressions that depend on measure-light are only supported as a global layer value (and not for each feature) when using GeoJSON or vector tile as the model layer source. Paint property.

Should be between `0` and `5` inclusive.
Units in intensity. Defaults to `0`.

-}
modelEmissiveStrength : Expression any Float -> LayerAttr Model
modelEmissiveStrength =
    Expression.encode >> Paint "model-emissive-strength"


{-| The opacity of the model layer. Except for zoom, expressions that are data-driven are not supported if using GeoJSON or vector tile as the model layer source. Paint property.

Should be between `0` and `1` inclusive. Defaults to `1`.

-}
modelOpacity : Expression any Float -> LayerAttr Model
modelOpacity =
    Expression.encode >> Paint "model-opacity"


{-| The rotation of the model in euler angles [lon, lat, z]. Paint property.
Units in degrees. Defaults to `0,0,0`.
-}
modelRotation : Expression any (Array Float) -> LayerAttr Model
modelRotation =
    Expression.encode >> Paint "model-rotation"


{-| The scale of the model. Expressions that are zoom-dependent are not supported if using GeoJSON or vector tile as the model layer source. Paint property. Defaults to `1,1,1`.
-}
modelScale : Expression any (Array Float) -> LayerAttr Model
modelScale =
    Expression.encode >> Paint "model-scale"


{-| The tint color of the model layer. model-color-mix-intensity (defaults to 0) defines tint(mix) intensity - this means that, this color is not used unless model-color-mix-intensity gets value greater than 0. Expressions that depend on measure-light are not supported when using GeoJSON or vector tile as the model layer source. Paint property. Defaults to `#Ffffff`.
-}
modelColor : Expression any Color -> LayerAttr Model
modelColor =
    Expression.encode >> Paint "model-color"


{-| The translation of the model in meters in form of [longitudal, latitudal, altitude] offsets. Paint property. Defaults to `0,0,0`.
-}
modelTranslation : Expression any (Array Float) -> LayerAttr Model
modelTranslation =
    Expression.encode >> Paint "model-translation"


{-| This parameter defines the range for the fade-out effect before an automatic content cutoff on pitched map views. The automatic cutoff range is calculated according to the minimum required zoom level of the source and layer. The fade range is expressed in relation to the height of the map view. A value of 1.0 indicates that the content is faded to the same extent as the map's height in pixels, while a value close to zero represents a sharp cutoff. When the value is set to 0.0, the cutoff is completely disabled. Note: The property has no effect on the map if terrain is enabled. Paint property.

Should be between `0` and `1` inclusive. Defaults to `0`.

-}
modelCutoffFadeRange : Expression CameraExpression Float -> LayerAttr Model
modelCutoffFadeRange =
    Expression.encode >> Paint "model-cutoff-fade-range"
