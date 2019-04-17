module OnlyInExposing exposing (foo, bar)

{-| OnlyInExposing

@docs foo

-}

-- API --

{-| Do a foo thing
-}
foo : String
foo = "foo"

{-| Do a bar thing
-}
bar : String
bar = "bar"