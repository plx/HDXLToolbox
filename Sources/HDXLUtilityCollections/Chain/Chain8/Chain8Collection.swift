import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain8Collection
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
@AddArity8AlgebraicProductLikeBacking
@AddAlgebraicProductLikeStringification(caption: "chain-of")
public struct Chain8Collection<A,B,C,D,E,F,G,H>
where
A: Collection,
B: Collection<A.Element>,
C: Collection<A.Element>,
D: Collection<A.Element>,
E: Collection<A.Element>,
F: Collection<A.Element>,
G: Collection<A.Element>,
H: Collection<A.Element>
{ }

