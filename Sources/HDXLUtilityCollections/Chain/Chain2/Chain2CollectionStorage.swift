import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionStorage - Definition
// -------------------------------------------------------------------------- //

@usableFromInline
@AddChainCollectionStorageVariableComponents
@AddChainCollectionStorageFixedComponents
@AddArity2ChainCollectionStorageImplementation
internal final class Chain2CollectionStorage<A,B>
where
A:Collection,
B:Collection,
A.Element == B.Element
{  }

// -------------------------------------------------------------------------- //
// MARK: - Sendable
// -------------------------------------------------------------------------- //

extension Chain2CollectionStorage: @unchecked Sendable
where
A: Sendable,
B: Sendable { }

