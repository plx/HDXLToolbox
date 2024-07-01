import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Chain2CollectionIndex
// -------------------------------------------------------------------------- //

@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyEncodable
@ConditionallyDecodable
@StorageComparable
@StorageCustomStringConvertible
@StorageCustomDebugStringConvertible
@AddChainIndexFixedComponents
@AddArity2SumLikeIndexInitialization
@AddChainCollectionIndexCaseIterable
public struct Chain2CollectionIndex<A,B>
where
A: Comparable,
B: Comparable
{ }
