main x =
    case x of
        False ->
            main True
        
        True ->
            {}