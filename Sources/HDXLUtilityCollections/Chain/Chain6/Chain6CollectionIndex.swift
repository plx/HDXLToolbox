import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
import HDXLAlgebraicTypes
import HDXLEssentialMacros
import HDXLToolboxPackageMacros

// -------------------------------------------------------------------------- //
// MARK: Chain6CollectionIndex
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
@AddArity6SumLikeIndexInitialization
@AddChainCollectionIndexCaseIterable
public struct Chain6CollectionIndex<A,B,C,D,E,F>
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable
{ }
