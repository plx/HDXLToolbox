import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain7CollectionIndex
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
@AddArity7SumLikeIndexInitialization
@AddChainCollectionIndexCaseIterable
public struct Chain7CollectionIndex<A,B,C,D,E,F,G>
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable,
G: Comparable
{ }
