module Mapbox.Helpers exposing (..)

import Json.Encode as Encode exposing (Value)


encodePair : (b -> Value) -> ( b, b ) -> Value
encodePair encoder ( a, b ) =
    Encode.list encoder [ a, b ]
