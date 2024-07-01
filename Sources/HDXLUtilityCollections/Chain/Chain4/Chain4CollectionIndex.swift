import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Chain4CollectionIndex
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
@AddArity4SumLikeIndexInitialization
@AddChainCollectionIndexCaseIterable
public struct Chain4CollectionIndex<A,B,C,D>
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable
{ }
