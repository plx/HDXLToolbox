import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: ObjectSetIndex - Definition
// -------------------------------------------------------------------------- //

/// `newtype`-like wrapper for `Set.Index` values being used-by an `ObjectSet`.
@frozen
public struct ObjectSetIndex<T:AnyObject> {
  
  @usableFromInline
  internal typealias Wrapper = ObjectWrapper<T>
  
  @usableFromInline
  internal typealias Index = Set<Wrapper>.Index
  
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

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension ObjectSetIndex: Sendable where T: Sendable { }
extension ObjectSetIndex: Equatable { }
extension ObjectSetIndex: Hashable { }

// -------------------------------------------------------------------------- //
// MARK: - Comparable
// -------------------------------------------------------------------------- //

extension ObjectSetIndex : Comparable {
  
  @inlinable
  public static func < (
    lhs: ObjectSetIndex<T>,
    rhs: ObjectSetIndex<T>
  ) -> Bool {
    lhs.index < rhs.index
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: ObjectSetIndex - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension ObjectSetIndex : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describing: index)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: ObjectSetIndex - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension ObjectSetIndex : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "ObjectSetIndex<\(String(reflecting: T.self))>(index: \(String(reflecting: index)))"
  }
  
}
