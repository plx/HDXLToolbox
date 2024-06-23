import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Sum5
// -------------------------------------------------------------------------- //

/// Provides an arity-5 implementation of an "anonymous sum".
@frozen
public enum Sum5<A,B,C,D,E> {
  
  case a(A)
  case b(B)
  case c(C)
  case d(D)
  case e(E)
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension Sum5: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable
{ }

extension Sum5: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable
{ }

extension Sum5: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable
{ }

extension Sum5: Encodable
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable,
E: Encodable
{ }

extension Sum5: Decodable
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable,
E: Decodable
{ }


// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension Sum5: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable
{

  public typealias ID = Sum5<A.ID, B.ID, C.ID, D.ID, E.ID>
  
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
    case .e(let e):
      .e(e.id)
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Sum5 : CustomStringConvertible {
  
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
    case .e(let value):
      ".e(\(String(describing: value)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Sum5 : CustomDebugStringConvertible {
  
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
    case .e(let value):
      "\(String(reflecting: Self.self)).e(\(String(reflecting: value)))"
    }
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: - Convenience Constructors
// -------------------------------------------------------------------------- //

extension Sum5 {
  
  /// Constructs a `Sum5` by lazily-evaluating its arguments from left-to-right and using the first non-nil value discovered (if any).
  @inlinable
  public static func firstNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?,
    _ d: @autoclosure () -> D?,
    _ e: @autoclosure () -> E?
  ) -> Self? {
    if let a = a() {
      .a(a)
    } else if let b = b() {
      .b(b)
    } else if let c = c() {
      .c(c)
    } else if let d = d() {
      .d(d)
    } else if let e = e() {
      .e(e)
    } else {
      nil
    }
  }
  
  /// Constructs a `Sum5` by lazily-evaluating its arguments from right-to-left and using the first non-nil value discovered (if any).
  @inlinable
  public static func finalNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?,
    _ d: @autoclosure () -> D?,
    _ e: @autoclosure () -> E?
  ) -> Self? {
    if let e = e() {
      .e(e)
    } else if let d = d() {
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

extension Sum5 {
  
  public typealias Position = Arity9Position
  
  @inlinable
  public var occupiedPosition: Position {
    switch self {
    case .a: .a
    case .b: .b
    case .c: .c
    case .d: .d
    case .e: .e
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

extension Sum5 {
  
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

  /// Returns `true` iff `self` is `.e(_)`; `false` otherwise.
  @inlinable
  public var hasEValue: Bool {
    occupiedPosition == .e
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Value-Access
// -------------------------------------------------------------------------- //

extension Sum5 {
  
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

  /// Directly returns the value when `self` is `.e(value)`; `nil` otherwise.
  @inlinable
  public var eValue: E? {
    switch self {
    case .e(let value):
      value
    default:
      nil
    }
  }

}
