import Json.Decode as D

-- MODEL

type Tree
    = Node Question
    | Leaf Recommendation


type alias Question =
    { text : String
    , choices : List Choice
    }

type alias Choice =
    { text : String
    , result : Tree
    }

type alias Recommendation =
    { title : String
    }

type alias Source =
    { name : String
    , url : String
    }

-- DECODERS

questionDecoder : D.Decoder Question
questionDecoder =
    D.map2 Question
        (D.field "text" D.string)
        (D.field "choices" (D.list choiceDecoder))


choiceDecoder : D.Decoder Choice
choiceDecoder =
    D.map2 Choice
        (D.field "text" D.string)
        (D.field "result" treeDecoder)

recommendationDecoder : D.Decoder Recommendation
recommendationDecoder =
    D.map Recommendation
        (D.field "title" D.string)

treeDecoder : D.Decoder Tree
treeDecoder =
    D.oneOf [ D.map Node questionDecoder , D.map Leaf recommendationDecoder ]