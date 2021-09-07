module Jupyter.Plugins

import public Data.DPair
import public Data.List.Quantifiers

import Jupyter.Response

%default total

-- For some reason this doesn't work inline
stringResponse : JupyterResponse String
stringResponse = %search

export
parseResponse : (0 types : List Type)
             -> All Idris2Response types
             => All JupyterResponse types
             => String
             -> IO $ Exists $ \type => (JupyterResponse type, type)
parseResponse [] @{[]} @{[]} rawResponse = pure $ Evidence String (stringResponse, rawResponse)
parseResponse (plugin :: rest) @{_ :: _} @{j :: _} rawResponse = do
    case parse {a = plugin} rawResponse of
        Nothing => parseResponse rest rawResponse
        Just response => pure $ Evidence _ (j, response)
