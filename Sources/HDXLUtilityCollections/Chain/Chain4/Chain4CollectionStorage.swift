import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
@AddChainCollectionStorageVariableComponents
@AddChainCollectionStorageFixedComponents
@AddArity4ChainCollectionStorageImplementation
internal final class Chain4CollectionStorage<A,B,C,D>
where
A: Collection,
B: Collection<A.Element>,
C: Collection<A.Element>,
D: Collection<A.Element>
{ }

extension Chain4CollectionStorage: @unchecked Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable
{ }
