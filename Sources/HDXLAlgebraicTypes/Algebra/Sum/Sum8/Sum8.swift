import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Sum8
// -------------------------------------------------------------------------- //

/// Provides an arity-8 implementation of an "anonymous sum".
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
public enum Sum8<A,B,C,D,E,F,G,H> {
  
  case a(A)
  case b(B)
  case c(C)
  case d(D)
  case e(E)
  case f(F)
  case g(G)
  case h(H)
  
}

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension Sum8: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable,
G: Identifiable,
H: Identifiable
{

  public typealias ID = Sum8<A.ID, B.ID, C.ID, D.ID, E.ID, F.ID, G.ID, H.ID>
  
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
    case .f(let f):
      .f(f.id)
    case .g(let g):
      .g(g.id)
    case .h(let h):
      .h(h.id)
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Sum8 : CustomStringConvertible {
  
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
    case .f(let value):
      ".f(\(String(describing: value)))"
    case .g(let value):
      ".g(\(String(describing: value)))"
    case .h(let value):
      ".h(\(String(describing: value)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Sum8 : CustomDebugStringConvertible {
  
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
    case .f(let value):
      "\(String(reflecting: Self.self)).f(\(String(reflecting: value)))"
    case .g(let value):
      "\(String(reflecting: Self.self)).g(\(String(reflecting: value)))"
    case .h(let value):
      "\(String(reflecting: Self.self)).h(\(String(reflecting: value)))"
    }
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: - Convenience Constructors
// -------------------------------------------------------------------------- //

extension Sum8 {
  
  /// Constructs a `Sum8` by lazily-evaluating its arguments from left-to-right and using the first non-nil value discovered (if any).
  @inlinable
  public static func firstNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?,
    _ d: @autoclosure () -> D?,
    _ e: @autoclosure () -> E?,
    _ f: @autoclosure () -> F?,
    _ g: @autoclosure () -> G?,
    _ h: @autoclosure () -> H?
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
    } else if let f = f() {
      .f(f)
    } else if let g = g() {
      .g(g)
    } else if let h = h() {
      .h(h)
    } else {
      nil
    }
  }
  
  /// Constructs a `Sum8` by lazily-evaluating its arguments from right-to-left and using the first non-nil value discovered (if any).
  @inlinable
  public static func finalNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?,
    _ d: @autoclosure () -> D?,
    _ e: @autoclosure () -> E?,
    _ f: @autoclosure () -> F?,
    _ g: @autoclosure () -> G?,
    _ h: @autoclosure () -> H?
  ) -> Self? {
    if let h = h() {
      .h(h)
    } else if let g = g() {
      .g(g)
    } else if let f = f() {
      .f(f)
    } else if let e = e() {
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

extension Sum8 {
  
  public typealias Position = Arity9Position
  
  @inlinable
  public var occupiedPosition: Position {
    switch self {
    case .a: .a
    case .b: .b
    case .c: .c
    case .d: .d
    case .e: .e
    case .f: .f
    case .g: .b
    case .h: .h
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

extension Sum8 {
  
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
  
  /// Returns `true` iff `self` is `.f(_)`; `false` otherwise.
  @inlinable
  public var hasFValue: Bool {
    occupiedPosition == .f
  }

  /// Returns `true` iff `self` is `.g(_)`; `false` otherwise.
  @inlinable
  public var hasGValue: Bool {
    occupiedPosition == .g
  }
  
  /// Returns `true` iff `self` is `.h(_)`; `false` otherwise.
  @inlinable
  public var hasHValue: Bool {
    occupiedPosition == .h
  }

}

// -------------------------------------------------------------------------- //
// MARK: - Value-Access
// -------------------------------------------------------------------------- //

extension Sum8 {
  
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

  /// Directly returns the value when `self` is `.f(value)`; `nil` otherwise.
  @inlinable
  public var fValue: F? {
    switch self {
    case .f(let value):
      value
    default:
      nil
    }
  }

  /// Directly returns the value when `self` is `.g(value)`; `nil` otherwise.
  @inlinable
  public var gValue: G? {
    switch self {
    case .g(let value):
      value
    default:
      nil
    }
  }

  /// Directly returns the value when `self` is `.h(value)`; `nil` otherwise.
  @inlinable
  public var hValue: H? {
    switch self {
    case .h(let value):
      value
    default:
      nil
    }
  }

}
