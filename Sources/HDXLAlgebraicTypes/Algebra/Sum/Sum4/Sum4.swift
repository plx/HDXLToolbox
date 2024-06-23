import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Sum4
// -------------------------------------------------------------------------- //

/// Provides an arity-4 implementation of an "anonymous sum".
@frozen
public enum Sum4<A,B,C,D> {
  
  case a(A)
  case b(B)
  case c(C)
  case d(D)
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension Sum4: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable
{ }

extension Sum4: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable
{ }

extension Sum4: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable
{ }

extension Sum4: Encodable
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable
{ }

extension Sum4: Decodable
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable
{ }


// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension Sum4: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable
{

  public typealias ID = Sum4<A.ID, B.ID, C.ID, D.ID>
  
  @inlinable
  public var id: ID {
    switch self {
    case .a(let a):
      .a(a.id)
    case .b(let b):
      .b(b.id)
    case .c(let c):
      .c(c.id)
    case .d(let d):
      .d(d.id)
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Sum4 : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    switch self {
    case .a(let value):
      ".a(\(String(describing: value)))"
    case .b(let value):
      ".b(\(String(describing: value)))"
    case .c(let value):
      ".c(\(String(describing: value)))"
    case .d(let value):
      ".d(\(String(describing: value)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Sum4 : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    switch self {
    case .a(let value):
      "\(String(reflecting: Self.self)).a(\(String(reflecting: value)))"
    case .b(let value):
      "\(String(reflecting: Self.self)).b(\(String(reflecting: value)))"
    case .c(let value):
      "\(String(reflecting: Self.self)).c(\(String(reflecting: value)))"
    case .d(let value):
      "\(String(reflecting: Self.self)).d(\(String(reflecting: value)))"
    }
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: - Convenience Constructors
// -------------------------------------------------------------------------- //

extension Sum4 {
  
  /// Constructs a `Sum4` by lazily-evaluating its arguments from left-to-right and using the first non-nil value discovered (if any).
  @inlinable
  public static func firstNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?,
    _ d: @autoclosure () -> D?
  ) -> Self? {
    if let a = a() {
      .a(a)
    } else if let b = b() {
      .b(b)
    } else if let c = c() {
      .c(c)
    } else if let d = d() {
      .d(d)
    } else {
      nil
    }
  }
  
  /// Constructs a `Sum4` by lazily-evaluating its arguments from right-to-left and using the first non-nil value discovered (if any).
  @inlinable
  public static func finalNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?,
    _ d: @autoclosure () -> D?
  ) -> Self? {
    if let d = d() {
      .d(d)
    } else if let c = c() {
      .c(c)
    } else if let b = b() {
      .b(b)
    } else if let a = a() {
      .a(a)
    } else {
      nil
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Position Access
// -------------------------------------------------------------------------- //

extension Sum4 {
  
  public typealias Position = Arity9Position
  
  @inlinable
  public var occupiedPosition: Position {
    switch self {
    case .a: .a
    case .b: .b
    case .c: .c
    case .d: .d
    }
  }
  
  /// `true` iff `position` is `self`'s occupied position.
  @inlinable
  public func isOccupied(at position: Position) -> Bool {
    occupiedPosition == position
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Has-Value
// -------------------------------------------------------------------------- //

extension Sum4 {
  
  /// Returns `true` iff `self` is `.a(_)`; `false` otherwise.
  @inlinable
  public var hasAValue: Bool {
    occupiedPosition == .a
  }
  
  /// Returns `true` iff `self` is `.b(_)`; `false` otherwise.
  @inlinable
  public var hasBValue: Bool {
    occupiedPosition == .b
  }

  /// Returns `true` iff `self` is `.c(_)`; `false` otherwise.
  @inlinable
  public var hasCValue: Bool {
    occupiedPosition == .c
  }
  
  /// Returns `true` iff `self` is `.d(_)`; `false` otherwise.
  @inlinable
  public var hasDValue: Bool {
    occupiedPosition == .d
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Value-Access
// -------------------------------------------------------------------------- //

extension Sum4 {
  
  /// Directly returns the value when `self` is `.a(value)`; `nil` otherwise.
  @inlinable
  public var aValue: A? {
    switch self {
    case .a(let value):
      value
    default:
      nil
    }
  }
  
  /// Directly returns the value when `self` is `.b(value)`; `nil` otherwise.
  @inlinable
  public var bValue: B? {
    switch self {
    case .b(let value):
      value
    default:
      nil
    }
  }

  /// Directly returns the value when `self` is `.c(value)`; `nil` otherwise.
  @inlinable
  public var cValue: C? {
    switch self {
    case .c(let value):
      value
    default:
      nil
    }
  }
  
  /// Directly returns the value when `self` is `.d(value)`; `nil` otherwise.
  @inlinable
  public var dValue: D? {
    switch self {
    case .d(let value):
      value
    default:
      nil
    }
  }

}
