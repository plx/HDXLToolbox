import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: Sum3
// -------------------------------------------------------------------------- //

/// Provides an arity-4 implementation of an "anonymous sum".
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
public enum Sum3<A,B,C> {
  
  case a(A)
  case b(B)
  case c(C)
  
}

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension Sum3: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable
{

  public typealias ID = Sum3<A.ID, B.ID, C.ID>
  
  @inlinable
  public var id: ID {
    switch self {
    case .a(let a):
      .a(a.id)
    case .b(let b):
      .b(b.id)
    case .c(let c):
      .c(c.id)
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension Sum3 : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    switch self {
    case .a(let value):
      ".a(\(String(describing: value)))"
    case .b(let value):
      ".b(\(String(describing: value)))"
    case .c(let value):
      ".c(\(String(describing: value)))"
    }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension Sum3 : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    switch self {
    case .a(let value):
      "\(String(reflecting: Self.self)).a(\(String(reflecting: value)))"
    case .b(let value):
      "\(String(reflecting: Self.self)).b(\(String(reflecting: value)))"
    case .c(let value):
      "\(String(reflecting: Self.self)).c(\(String(reflecting: value)))"
    }
  }
  
}


// -------------------------------------------------------------------------- //
// MARK: - Convenience Constructors
// -------------------------------------------------------------------------- //

extension Sum3 {
  
  /// Constructs a `Sum3` by lazily-evaluating its arguments from left-to-right and using the first non-nil value discovered (if any).
  @inlinable
  public static func firstNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?
  ) -> Self? {
    if let a = a() {
      .a(a)
    } else if let b = b() {
      .b(b)
    } else if let c = c() {
      .c(c)
    } else {
      nil
    }
  }
  
  /// Constructs a `Sum3` by lazily-evaluating its arguments from right-to-left and using the first non-nil value discovered (if any).
  @inlinable
  public static func finalNonNil(
    _ a: @autoclosure () -> A?,
    _ b: @autoclosure () -> B?,
    _ c: @autoclosure () -> C?
  ) -> Self? {
    if let c = c() {
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

extension Sum3 {
  
  public typealias Position = Arity9Position
  
  @inlinable
  public var occupiedPosition: Position {
    switch self {
    case .a: .a
    case .b: .b
    case .c: .c
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

extension Sum3 {
  
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
    
}

// -------------------------------------------------------------------------- //
// MARK: - Value-Access
// -------------------------------------------------------------------------- //

extension Sum3 {
  
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
  
}
