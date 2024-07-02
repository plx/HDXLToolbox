import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain6Collection
// -------------------------------------------------------------------------- //

/// A collection providing the contents of its constituent collections, one after the other.
@frozen
@COWWrapper
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyCodable
@ConditionallyRandomAccessCollection
@AddChainCollectionFixedComponents
@AddArity6AlgebraicProductLikeBacking
@AddAlgebraicProductLikeStringification(caption: "chain-of")
public struct Chain6Collection<A,B,C,D,E,F>
where
A: Collection,
B: Collection,
C: Collection,
D: Collection,
E: Collection,
F: Collection,
A.Element == B.Element,
A.Element == C.Element,
A.Element == D.Element,
A.Element == E.Element,
A.Element == F.Element
{ }
