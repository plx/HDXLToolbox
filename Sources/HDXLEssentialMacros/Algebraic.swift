import Foundation
import SwiftUI
import HDXLEssentialPrecursors

@attached(peer, names: arbitrary)
public macro ResettableLazyCalculation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ResettableLazyCalculationMacro"
)

@attached(
  extension,
  conformances: CustomStringConvertible, CustomDebugStringConvertible,
  names: named(description), named(debugDescription)
)
package macro AddAlgebraicProductLikeStringification(caption: String) = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddAlgebraicProductLikeStringificationMacro"
)

// MARK: Arity 2

@attached(
  member,
  names:
    named(Storage), named(storage), named(init(storage:)),
  named(init(_:_:)),
  named(a),
  named(b)
)
package macro AddArity2AlgebraicProductLikeBacking() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddAlgebraicProductLikeStorageAndForwardingMacro"
)

// MARK: Arity 3

@attached(
  member,
  names:
    named(Storage), named(storage), named(init(storage:)),
  named(init(_:_:_:)),
  named(a),
  named(b),
  named(c)
)
package macro AddArity3AlgebraicProductLikeBacking() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddAlgebraicProductLikeStorageAndForwardingMacro"
)

// MARK: Arity 4

@attached(
  member,
  names:
    named(Storage), named(storage), named(init(storage:)),
  named(init(_:_:_:_:)),
  named(a),
  named(b),
  named(c),
  named(d)
)
package macro AddArity4AlgebraicProductLikeBacking() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddAlgebraicProductLikeStorageAndForwardingMacro"
)

// MARK: Arity 5

@attached(
  member,
  names:
    named(Storage), named(storage), named(init(storage:)),
  named(init(_:_:_:_:_:)),
  named(a),
  named(b),
  named(c),
  named(d),
  named(e)
)
package macro AddArity5AlgebraicProductLikeBacking() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddAlgebraicProductLikeStorageAndForwardingMacro"
)

// MARK: Arity 6

@attached(
  member,
  names:
    named(Storage), named(storage), named(init(storage:)),
  named(init(_:_:_:_:_:_:)),
  named(a),
  named(b),
  named(c),
  named(d),
  named(e),
  named(f)
)
package macro AddArity6AlgebraicProductLikeBacking() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddAlgebraicProductLikeStorageAndForwardingMacro"
)

// MARK: Arity 7

@attached(
  member,
  names:
    named(Storage), named(storage), named(init(storage:)),
  named(init(_:_:_:_:_:_:_:)),
  named(a),
  named(b),
  named(c),
  named(d),
  named(e),
  named(f),
  named(g)
)
package macro AddArity7AlgebraicProductLikeBacking() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddAlgebraicProductLikeStorageAndForwardingMacro"
)

// MARK: Arity 8

@attached(
  member,
  names:
    named(Storage), named(storage), named(init(storage:)),
  named(init(_:_:_:_:_:_:_:_:)),
  named(a),
  named(b),
  named(c),
  named(d),
  named(e),
  named(f),
  named(g),
  named(h)
)
package macro AddArity8AlgebraicProductLikeBacking() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddAlgebraicProductLikeStorageAndForwardingMacro"
)

// MARK: Arity 9

@attached(
  member,
  names:
    named(Storage), named(storage), named(init(storage:)),
    named(init(_:_:_:_:_:_:_:_:_:)),
    named(a),
    named(b),
    named(c),
    named(d),
    named(e),
    named(f),
    named(g),
    named(h),
    named(i)
)
package macro AddArity9AlgebraicProductLikeBacking() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddAlgebraicProductLikeStorageAndForwardingMacro"
)
