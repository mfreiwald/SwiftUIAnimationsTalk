import SwiftUI
import DeckUI

let MatchedGeometryEffectDoku = Slide {
    Columns {
        Column {
            Documentation("matchedGeometryEffect(id:in:properties:anchor:isSource:)",
                          description: "Defines a group of views with synchronized geometry using an identifier and namespace that you provide.",
                          code: """
func matchedGeometryEffect<ID>(
    id: ID,
    in namespace: Namespace.ID,
    properties: MatchedGeometryProperties = .frame,
    anchor: UnitPoint = .center,
    isSource: Bool = true
) -> some View where ID : Hashable
"""
            )
        }
    }
}
