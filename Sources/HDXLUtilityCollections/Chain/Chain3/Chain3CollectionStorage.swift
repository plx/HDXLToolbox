import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain3CollectionStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
@AddChainCollectionStorageVariableComponents
@AddChainCollectionStorageFixedComponents
@AddArity3ChainCollectionStorageImplementation
internal final class Chain3CollectionStorage<A,B,C>
where
A: Collection,
B: Collection<A.Element>,
C: Collection<A.Element>
{ }

extension Chain3CollectionStorage: @unchecked Sendable
where
A: Sendable,
B: Sendable,
C: Sendable
{ }
