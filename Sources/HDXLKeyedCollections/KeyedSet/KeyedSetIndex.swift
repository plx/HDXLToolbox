import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: KeyedSetIndex
// ------------------------------------------------------------------------- //

@frozen
public struct KeyedSetIndex<Key, Value> where Key: Hashable, Value: Hashable {
  
  @usableFromInline
  internal typealias WrappedIndex = [Key: Set<Value>].Index
  
  @usableFromInline
  internal var index: WrappedIndex
  
  @inlinable
  internal init(index: WrappedIndex) {
    self.index = index
  }
  
  @inlinable
  internal init?(possibleIndex: WrappedIndex?) {
    guard let index = possibleIndex else {
      return nil
    }
    self.init(index: index)
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension KeyedSetIndex: Sendable where Key: Sendable, Value: Sendable { }
extension KeyedSetIndex: Equatable { }
extension KeyedSetIndex: Hashable { }

// ------------------------------------------------------------------------- //
// MARK: - Comparable
// ------------------------------------------------------------------------- //

extension KeyedSetIndex: Comparable {
  
  @inlinable
  public static func < (
    lhs: KeyedSetIndex<Key, Value>,
    rhs: KeyedSetIndex<Key, Value>
  ) -> Bool {
    lhs.index <= rhs.index
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension KeyedSetIndex: CustomStringConvertible {
  
  public var description: String {
    String(describing: index)
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension KeyedSetIndex: CustomDebugStringConvertible {
  
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(index: \(String(reflecting: index))"
  }
}
