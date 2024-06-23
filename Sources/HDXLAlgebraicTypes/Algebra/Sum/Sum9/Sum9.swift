import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Sum9
// -------------------------------------------------------------------------- //

/// Provides an arity-9 implementation of an "anonymous sum".
@frozen
public enum Sum9<A,B,C,D,E,F,G,H,I> {
  
  case a(A)
  case b(B)
  case c(C)
  case d(D)
  case e(E)
  case f(F)
  case g(G)
  case h(H)
  case i(I)
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension Sum9: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable,
F: Sendable,
G: Sendable,
H: Sendable,
I: Sendable
{ }

extension Sum9: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable,
F: Equatable,
G: Equatable,
H: Equatable,
I: Equatable
{ }

extension Sum9: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable,
F: Hashable,
G: Hashable,
H: Hashable,
I: Hashable
{ }

extension Sum9: Encodable
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable,
E: Encodable,
F: Encodable,
G: Encodable,
H: Encodable,
I: Encodable
{ }

extension Sum9: Decodable
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable,
E: Decodable,
F: Decodable,
G: Decodable,
H: Decodable,
I: Decodable
{ }


// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension Sum9: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable,
G: Identifiable,
H: Identifiable,
I: Identifiable
{

  public typealias ID = Sum9<A.ID, B.ID, C.ID, D.ID, E.ID, F.ID, G.ID, H.ID, I.ID>
  
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
    case .i(let i):
        .i(i.id)
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Sum9 : CustomStringConvertible {
  
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
    case .i(let value):
      ".i(\(String(describing: value)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Sum9 : CustomDebugStringConvertible {
  
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
    case .i(let value):
      "\(String(reflecting: Self.self)).i(\(String(reflecting: value)))"
    }
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: - Convenience Constructors
// -------------------------------------------------------------------------- //

extension Sum9 {
  
  /// Constructs a `Sum9` by lazily-evaluating its arguments from left-to-right and using the first non-nil value discovered (if any).
  @inlinable
  public static func firstNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?,
    _ d: @autoclosure () -> D?,
    _ e: @autoclosure () -> E?,
    _ f: @autoclosure () -> F?,
    _ g: @autoclosure () -> G?,
    _ h: @autoclosure () -> H?,
    _ i: @autoclosure () -> I?
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
    } else if let i = i() {
      .i(i)
    } else {
      nil
    }
  }
  
  /// Constructs a `Sum9` by lazily-evaluating its arguments from right-to-left and using the first non-nil value discovered (if any).
  @inlinable
  public static func finalNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?,
    _ d: @autoclosure () -> D?,
    _ e: @autoclosure () -> E?,
    _ f: @autoclosure () -> F?,
    _ g: @autoclosure () -> G?,
    _ h: @autoclosure () -> H?,
    _ i: @autoclosure () -> I?
  ) -> Self? {
    if let i = i() {
      .i(i)
    } else if let h = h() {
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

extension Sum9 {
  
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
    case .i: .i
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

extension Sum9 {
  
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

  /// Returns `true` iff `self` is `.i(_)`; `false` otherwise.
  @inlinable
  public var hasIValue: Bool {
    occupiedPosition == .i
  }

}

// -------------------------------------------------------------------------- //
// MARK: - Value-Access
// -------------------------------------------------------------------------- //

extension Sum9 {
  
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

  /// Directly returns the value when `self` is `.i(value)`; `nil` otherwise.
  @inlinable
  public var iValue: I? {
    switch self {
    case .i(let value):
      value
    default:
      nil
    }
  }

}
