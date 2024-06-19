import Foundation
import HDXLCollectionSupport

// ------------------------------------------------------------------------- //
// MARK: ObjectDictionaryIndex
// ------------------------------------------------------------------------- //

@frozen
public struct ObjectDictionaryIndex<Key, Value> where Key: AnyObject {
  
  @usableFromInline
  internal typealias Index = Dictionary<ObjectWrapper<Key>, Value>.Index
  
  @usableFromInline
  internal var index: Index
  
  @inlinable
  internal init(index: Index) {
    self.index = index
  }
  
  @inlinable
  internal init?(possibleIndex: Index?) {
    guard let index = possibleIndex else {
      return nil
    }
    self.init(index: index)
  }

}

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension ObjectDictionaryIndex : Sendable where Key: Sendable, Value: Sendable { }
extension ObjectDictionaryIndex : Equatable { }
extension ObjectDictionaryIndex : Hashable { }

// ------------------------------------------------------------------------- //
// MARK: - Comparable
// ------------------------------------------------------------------------- //

extension ObjectDictionaryIndex : Comparable {
  
  @inlinable
  public static func < (
    lhs: ObjectDictionaryIndex<Key, Value>,
    rhs: ObjectDictionaryIndex<Key, Value>
  ) -> Bool {
    lhs.index < rhs.index
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionaryIndex : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describing: index)
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionaryIndex : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(index: \(String(reflecting: index)))"
  }
  
}
