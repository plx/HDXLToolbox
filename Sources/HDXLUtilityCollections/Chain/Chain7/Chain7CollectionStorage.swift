import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain7CollectionStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
@AddChainCollectionStorageVariableComponents
@AddChainCollectionStorageFixedComponents
@AddArity7ChainCollectionStorageImplementation
internal final class Chain7CollectionStorage<A,B,C,D,E,F,G>
where
A: Collection,
B: Collection<A.Element>,
C: Collection<A.Element>,
D: Collection<A.Element>,
E: Collection<A.Element>,
F: Collection<A.Element>,
G: Collection<A.Element>
{ }

extension Chain7CollectionStorage: @unchecked Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable,
F: Sendable,
G: Sendable
{ }
