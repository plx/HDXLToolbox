import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Chain9CollectionStorage - Definition
// -------------------------------------------------------------------------- //


@usableFromInline
@AddChainCollectionStorageImplementation
@AddFixedChainCollectionStorageComponents
@AddArity9ChainCollectionStorageImplementation
internal final class Chain9CollectionStorage<A,B,C,D,E,F,G,H,I>
where
A: Collection,
B: Collection<A.Element>,
C: Collection<A.Element>,
D: Collection<A.Element>,
E: Collection<A.Element>,
F: Collection<A.Element>,
G: Collection<A.Element>,
H: Collection<A.Element>,
I: Collection<A.Element>
{ }

extension Chain9CollectionStorage: @unchecked Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable,
F: Sendable,
G: Sendable,
H: Sendable,
I: Sendable
{ }
