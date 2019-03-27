import Json.Decode as D

-- MODEL

type Tree
    = Node Question
    | Leaf RecommendationData


type alias Question =
    { text : String
    , choices : List Choice
    }

type alias Choice =
    { text : String
    , result : Tree
    }

type alias RecommendationData =
    { title : String
    , availableOn : List Source
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


sourceDecoder : D.Decoder Source
sourceDecoder =
    D.map2 Source
        (D.field "name" D.string)
        (D.field "url" D.string)


recommendationDecoder : D.Decoder RecommendationData
recommendationDecoder =
    D.map2 RecommendationData
        (D.field "title" D.string)
        (D.field "available_on" (D.list sourceDecoder))


choiceDecoder : D.Decoder Choice
choiceDecoder =
    D.map2 Choice
        (D.field "text" D.string)
        (D.field "result" treeDecoder)


treeDecoder : D.Decoder Tree
treeDecoder =
    D.oneOf [ D.map Node questionDecoder , D.map Leaf recommendationDecoder ]