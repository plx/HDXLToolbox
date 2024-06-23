import Foundation
import SwiftUI
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: InlineProduct9
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "inline" as a struct.
/// Generally the preferred implementation for arity-2, unless one-or-both types
/// are huge structs; in that case, measurement may be required.
@frozen
public struct InlineProduct9<A,B,C,D,E,F,G,H,I> {
  
  public var a: A
  public var b: B
  public var c: C
  public var d: D
  public var e: E
  public var f: F
  public var g: G
  public var h: H
  public var i: I

  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G,
    _ h: H,
    _ i: I
  ) {
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    self.e = e
    self.f = f
    self.g = g
    self.h = h
    self.i = i
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension InlineProduct9: Sendable
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

extension InlineProduct9: Equatable
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

extension InlineProduct9: Comparable
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable,
G: Comparable,
H: Comparable,
I: Comparable
{ }

extension InlineProduct9: Hashable
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

extension InlineProduct9: Encodable
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

extension InlineProduct9: Decodable
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

extension InlineProduct9: CustomStringConvertible { }
extension InlineProduct9: CustomDebugStringConvertible { }

extension InlineProduct9: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic,
F: AdditiveArithmetic,
G: AdditiveArithmetic,
H: AdditiveArithmetic,
I: AdditiveArithmetic
{ }

extension InlineProduct9: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic,
F: VectorArithmetic,
G: VectorArithmetic,
H: VectorArithmetic,
I: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension InlineProduct9: Identifiable
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
  public typealias ID = InlineProduct9<
    A.ID,
    B.ID,
    C.ID,
    D.ID,
    E.ID,
    F.ID,
    G.ID,
    H.ID,
    I.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct9
// -------------------------------------------------------------------------- //

extension InlineProduct9 : AlgebraicProduct9 {
  
  public typealias ArityPosition = Arity9Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { true }

}

