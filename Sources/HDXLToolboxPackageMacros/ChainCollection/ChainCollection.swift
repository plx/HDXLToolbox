import Foundation
import SwiftUI
import HDXLEssentialPrecursors

@attached(
  extension,
  conformances: Collection, BidirectionalCollection,
  names:
    named(Element),
    named(Index),
    named(count),
    named(isEmpty),
    named(startIndex),
    named(endIndex),
    named(subscript(_:)),
    named(index(after:)),
    named(index(before:)),
    named(index(_:offsetBy:)),
    named(index(_:offsetBy:limitedBy:)),
    named(distance(from:to:)),
    named(position(forLinearIndex:)),
    named(linearIndex(forPosition:)),
    named(linearIndex(forIndex:)),
    named(index(forLinearIndex:)),
    named(contains(_:)),
    named(min()),
    named(max())
)
//@attached(member, names: arbitrary)
package macro AddChainCollectionFixedComponents() = #externalMacro(
  module: "HDXLToolboxPackageMacrosPlugin",
  type: "AddChainCollectionFixedComponentsMacro"
)

