import Foundation

// ------------------------------------------------------------------------- //
// MARK: ObjectDictionaryKeysIndex
// ------------------------------------------------------------------------- //

@frozen
public struct ObjectDictionaryKeysIndex<Key, Value> where Key: AnyObject {
  
  @usableFromInline
  internal typealias Index = Dictionary<ObjectWrapper<Key>, Value>.Keys.Index
  
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

extension ObjectDictionaryKeysIndex: Sendable where Key: Sendable, Value: Sendable { }
extension ObjectDictionaryKeysIndex: Equatable { }

// ------------------------------------------------------------------------- //
// MARK: - Comparable
// ------------------------------------------------------------------------- //

extension ObjectDictionaryKeysIndex: Comparable {
  
  @inlinable
  public static func < (
    lhs: ObjectDictionaryKeysIndex<Key, Value>,
    rhs: ObjectDictionaryKeysIndex<Key, Value>
  ) -> Bool {
    lhs.index < rhs.index
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionaryKeysIndex: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describing: index)
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension ObjectDictionaryKeysIndex: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(index: \(String(reflecting: index)))"
  }
  
}
