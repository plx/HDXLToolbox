import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain3Collection
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
@AddArity3AlgebraicProductLikeBacking
@AddAlgebraicProductLikeStringification(caption: "chain-of")
public struct Chain3Collection<A,B,C>
where
A: Collection,
B: Collection<A.Element>,
C: Collection<A.Element>
{ }
