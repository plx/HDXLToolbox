import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain5CollectionStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
@AddChainCollectionStorageVariableComponents
@AddChainCollectionStorageFixedComponents
@AddArity5ChainCollectionStorageImplementation
internal final class Chain5CollectionStorage<A,B,C,D,E>
where
A: Collection,
B: Collection<A.Element>,
C: Collection<A.Element>,
D: Collection<A.Element>,
E: Collection<A.Element>
{ }

extension Chain5CollectionStorage: @unchecked Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable
{ }
