import Foundation
import SwiftUI
import HDXLEssentialPrecursors

@attached(
  extension,
  conformances: Sendable, Equatable, Hashable, Encodable, Decodable, CloneableObject,
  names: named(==), named(hash(into:)), named(encode(to:)), named(init(from:)), named(obtainClone()), named(position(before:)), named(contains(_:)), named(min()), named(max())
)
//@attached(member, names: arbitrary)
package macro AddChainCollectionStorageImplementation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionStorageImplementationMacro"
)


@freestanding(
  declaration,
  names: arbitrary
)
public macro DeclareChainCollectionStorage(arity: Int) = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "DeclareChainCollectionStorageMacro"
)

@attached(
  member,
  names:
    named(calculateIsEmpty()), 
    named(calculateCount()),
    named(calculateFirstPosition()),
    named(calculateFinalPosition()),
    named(firstPosition(after:)),
    named(finalPosition(before:)),
    named(position(after:)),
    named(subscript(_:)),
    named(distance(from:to:)),
    named(position(_:offsetBy:)),
    named(resetCaches()),
    named(Index),
    named(Position),
    named(Element),
    named(ArityPosition),
    named(ConstituentTuple),
    named(constituentTuple),
    named(init(constituentTuple:)),
    named(AlgebraicProductRepresentation),
    named(algebraicProductRepresentation),
    named(init(algebraicProductRepresentation:)),
    named(withMutatedAlgebraicProductRepresentation(_:)),
    named(position(forLinearPosition:)),
    named(linearPosition(forPosition:)),
    named(startIndex),
    named(endIndex)
)
package macro AddFixedChainCollectionStorageComponents() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddFixedChainCollectionStorageComponentsMacro"
)

// MARK: Arity-2

@attached(
  member,
  names:
    named(a),
    named(calculateRangeForA()),
    named(firstPositionAfterA),
    named(finalPositionBeforeA),
    named(with(a:)),
    named(b),
    named(calculateRangeForB()),
    named(firstPositionAfterB),
    named(finalPositionBeforeB),
    named(with(b:)),
    named(init(_:_:))
)
package macro AddArity2ChainCollectionStorageImplementation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionStorageImplementationMacro"
)

// MARK: Arity-3

@attached(
  member,
  names:
    named(a),
  named(calculateRangeForA()),
  named(firstPositionAfterA),
  named(finalPositionBeforeA),
  named(with(a:)),
  named(b),
  named(calculateRangeForB()),
  named(firstPositionAfterB),
  named(finalPositionBeforeB),
  named(with(b:)),
  named(c),
  named(calculateRangeForC()),
  named(firstPositionAfterC),
  named(finalPositionBeforeC),
  named(with(c:)),
  named(init(_:_:_:))
)
package macro AddArity3ChainCollectionStorageImplementation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionStorageImplementationMacro"
)

// MARK: Arity-4

@attached(
  member,
  names:
    named(a),
  named(calculateRangeForA()),
  named(firstPositionAfterA),
  named(finalPositionBeforeA),
  named(with(a:)),
  named(b),
  named(calculateRangeForB()),
  named(firstPositionAfterB),
  named(finalPositionBeforeB),
  named(with(b:)),
  named(c),
  named(calculateRangeForC()),
  named(firstPositionAfterC),
  named(finalPositionBeforeC),
  named(with(c:)),
  named(d),
  named(calculateRangeForD()),
  named(firstPositionAfterD),
  named(finalPositionBeforeD),
  named(with(d:)),
  named(init(_:_:_:_:))
)
package macro AddArity4ChainCollectionStorageImplementation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionStorageImplementationMacro"
)

// MARK: Arity-5

@attached(
  member,
  names:
    named(a),
  named(calculateRangeForA()),
  named(firstPositionAfterA),
  named(finalPositionBeforeA),
  named(with(a:)),
  named(b),
  named(calculateRangeForB()),
  named(firstPositionAfterB),
  named(finalPositionBeforeB),
  named(with(b:)),
  named(c),
  named(calculateRangeForC()),
  named(firstPositionAfterC),
  named(finalPositionBeforeC),
  named(with(c:)),
  named(d),
  named(calculateRangeForD()),
  named(firstPositionAfterD),
  named(finalPositionBeforeD),
  named(with(d:)),
  named(e),
  named(calculateRangeForE()),
  named(firstPositionAfterE),
  named(finalPositionBeforeE),
  named(with(e:)),
  named(init(_:_:_:_:_:))
)
package macro AddArity5ChainCollectionStorageImplementation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionStorageImplementationMacro"
)

// MARK: Arity-6

@attached(
  member,
  names:
    named(a),
  named(calculateRangeForA()),
  named(firstPositionAfterA),
  named(finalPositionBeforeA),
  named(with(a:)),
  named(b),
  named(calculateRangeForB()),
  named(firstPositionAfterB),
  named(finalPositionBeforeB),
  named(with(b:)),
  named(c),
  named(calculateRangeForC()),
  named(firstPositionAfterC),
  named(finalPositionBeforeC),
  named(with(c:)),
  named(d),
  named(calculateRangeForD()),
  named(firstPositionAfterD),
  named(finalPositionBeforeD),
  named(with(d:)),
  named(e),
  named(calculateRangeForE()),
  named(firstPositionAfterE),
  named(finalPositionBeforeE),
  named(with(e:)),
  named(f),
  named(calculateRangeForF()),
  named(firstPositionAfterF),
  named(finalPositionBeforeF),
  named(calculateFRange()),
  named(with(f:)),
  named(init(_:_:_:_:_:_:))
)
package macro AddArity6ChainCollectionStorageImplementation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionStorageImplementationMacro"
)

// MARK: Arity-7

@attached(
  member,
  names:
    named(a),
  named(calculateRangeForA()),
  named(firstPositionAfterA),
  named(finalPositionBeforeA),
  named(with(a:)),
  named(b),
  named(calculateRangeForB()),
  named(firstPositionAfterB),
  named(finalPositionBeforeB),
  named(with(b:)),
  named(c),
  named(calculateRangeForC()),
  named(firstPositionAfterC),
  named(finalPositionBeforeC),
  named(with(c:)),
  named(d),
  named(calculateRangeForD()),
  named(firstPositionAfterD),
  named(finalPositionBeforeD),
  named(with(d:)),
  named(e),
  named(calculateRangeForE()),
  named(firstPositionAfterE),
  named(finalPositionBeforeE),
  named(with(e:)),
  named(f),
  named(calculateRangeForF()),
  named(firstPositionAfterF),
  named(finalPositionBeforeF),
  named(calculateFRange()),
  named(with(f:)),
  named(g),
  named(calculateRangeForG()),
  named(firstPositionAfterG),
  named(finalPositionBeforeG),
  named(calculateGRange()),
  named(with(g:)),
  named(init(_:_:_:_:_:_:_:))
)
package macro AddArity7ChainCollectionStorageImplementation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionStorageImplementationMacro"
)

// MARK: Arity-8

@attached(
  member,
  names:
    named(a),
  named(calculateRangeForA()),
  named(firstPositionAfterA),
  named(finalPositionBeforeA),
  named(with(a:)),
  named(b),
  named(calculateRangeForB()),
  named(firstPositionAfterB),
  named(finalPositionBeforeB),
  named(with(b:)),
  named(c),
  named(calculateRangeForC()),
  named(firstPositionAfterC),
  named(finalPositionBeforeC),
  named(with(c:)),
  named(d),
  named(calculateRangeForD()),
  named(firstPositionAfterD),
  named(finalPositionBeforeD),
  named(with(d:)),
  named(e),
  named(calculateRangeForE()),
  named(firstPositionAfterE),
  named(finalPositionBeforeE),
  named(with(e:)),
  named(f),
  named(calculateRangeForF()),
  named(firstPositionAfterF),
  named(finalPositionBeforeF),
  named(calculateFRange()),
  named(with(f:)),
  named(g),
  named(calculateRangeForG()),
  named(firstPositionAfterG),
  named(finalPositionBeforeG),
  named(calculateGRange()),
  named(with(g:)),
  named(h),
  named(calculateRangeForH()),
  named(firstPositionAfterH),
  named(finalPositionBeforeH),
  named(calculateHRange()),
  named(with(h:)),
  named(init(_:_:_:_:_:_:_:_:))
)
package macro AddArity8ChainCollectionStorageImplementation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionStorageImplementationMacro"
)

// MARK: Arity-9

@attached(
  member,
  names:
    named(a),
    named(calculateRangeForA()),
    named(firstPositionAfterA),
    named(finalPositionBeforeA),
    named(with(a:)),
    named(b),
    named(calculateRangeForB()),
    named(firstPositionAfterB),
    named(finalPositionBeforeB),
    named(with(b:)),
    named(c),
    named(calculateRangeForC()),
    named(firstPositionAfterC),
    named(finalPositionBeforeC),
    named(with(c:)),
    named(d),
    named(calculateRangeForD()),
    named(firstPositionAfterD),
    named(finalPositionBeforeD),
    named(with(d:)),
    named(e),
    named(calculateRangeForE()),
    named(firstPositionAfterE),
    named(finalPositionBeforeE),
    named(with(e:)),
    named(f),
    named(calculateRangeForF()),
    named(firstPositionAfterF),
    named(finalPositionBeforeF),
    named(calculateFRange()),
    named(with(f:)),
    named(g),
    named(calculateRangeForG()),
    named(firstPositionAfterG),
    named(finalPositionBeforeG),
    named(calculateGRange()),
    named(with(g:)),
    named(h),
    named(calculateRangeForH()),
    named(firstPositionAfterH),
    named(finalPositionBeforeH),
    named(calculateHRange()),
    named(with(h:)),
    named(i),
    named(calculateRangeForI()),
    named(firstPositionAfterI),
    named(finalPositionBeforeI),
    named(with(i:)),
    named(init(_:_:_:_:_:_:_:_:_:))
)
package macro AddArity9ChainCollectionStorageImplementation() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionStorageImplementationMacro"
)
