import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain5CollectionIndex
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
@AddChainCollectionIndexFixedComponents
@AddArity5SumLikeIndexInitialization
@AddChainCollectionIndexCaseIterable
public struct Chain5CollectionIndex<A,B,C,D,E>
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable
{ }
