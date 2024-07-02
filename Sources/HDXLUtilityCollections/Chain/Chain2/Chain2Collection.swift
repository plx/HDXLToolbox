import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain2Collection
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
@AddArity2AlgebraicProductLikeBacking
@AddAlgebraicProductLikeStringification(caption: "chain-of")
public struct Chain2Collection<A,B>
where
A: Collection,
B: Collection<A.Element>
{ }
