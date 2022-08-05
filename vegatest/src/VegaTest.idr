module VegaTest

import Language.JSON
import Idris2JupyterVega.VegaLite

export
barChart : String -> List (String, Double) -> VegaLite
barChart description vals = TopLevelSpec_0 $ MkTopLevelUnitSpec
    {Schema = Just "https://vega.github.io/schema/vega-lite/v5.json"}
    (Data_0 $ Data_0 $ DataSource_1 $ MkInlineData $ InlineDataset_3 $ map (\(name, x) => JObject [("a", JString name), ("b", JNumber x)]) vals)
    {description = Just description}
    {encoding = Just $ MkFacetedEncoding
        {x = Just $ PositionDef_0 $ MkPositionFieldDef
            {axis = Just $ Axis_0 $ MkAxis {labelAngle = Just $ LabelAngle_0 0}}
            {field = Just $ Field_0 "a"}
            {type = Just StandardTypeNominal}
        }
        {y = Just $ PositionDef_0 $ MkPositionFieldDef
            {field = Just $ Field_0 "b"}
            {type = Just StandardTypeQuantitative}
        }
    }
    (AnyMark_2 MarkBar)
