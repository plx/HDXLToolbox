import Foundation

// ------------------------------------------------------------------------- //
// MARK: ObjectDictionaryValuesIndex
// ------------------------------------------------------------------------- //

@frozen
public struct ObjectDictionaryValuesIndex<Key, Value> where Key: AnyObject {
  
  @usableFromInline
  internal typealias Index = Dictionary<ObjectWrapper<Key>, Value>.Values.Index
  
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

extension ObjectDictionaryValuesIndex: Sendable where Key: Sendable, Value: Sendable { }
extension ObjectDictionaryValuesIndex: Equatable { }

// ------------------------------------------------------------------------- //
// MARK: - Comparable
// ------------------------------------------------------------------------- //

extension ObjectDictionaryValuesIndex: Comparable {
  
  @inlinable
  public static func < (
    lhs: ObjectDictionaryValuesIndex<Key, Value>,
    rhs: ObjectDictionaryValuesIndex<Key, Value>
  ) -> Bool {
    lhs.index < rhs.index
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionaryValuesIndex: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describing: index)
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionaryValuesIndex: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(index: \(String(reflecting: index)))"
  }
  
}
