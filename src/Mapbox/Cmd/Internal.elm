module Mapbox.Cmd.Internal exposing (..)

import Json.Encode exposing (Value)


{-| Options use phantom types to show which commands support them.
-}
type Option support
    = Option String Value


{-| -}
type Supported
    = Supported
