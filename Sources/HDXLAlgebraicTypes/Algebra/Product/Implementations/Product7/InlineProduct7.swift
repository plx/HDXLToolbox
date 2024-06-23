import Foundation
import SwiftUI
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: InlineProduct7
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "inline" as a struct.
/// Generally the preferred implementation for arity-2, unless one-or-both types
/// are huge structs; in that case, measurement may be required.
@frozen
public struct InlineProduct7<A,B,C,D,E,F,G> {
  
  public var a: A
  public var b: B
  public var c: C
  public var d: D
  public var e: E
  public var f: F
  public var g: G
  
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F,
    _ g: G
  ) {
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    self.e = e
    self.f = f
    self.g = g
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension InlineProduct7: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable,
F: Sendable,
G: Sendable
{ }

extension InlineProduct7: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable,
F: Equatable,
G: Equatable
{ }

extension InlineProduct7: Comparable
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable,
F: Comparable,
G: Comparable
{ }

extension InlineProduct7: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable,
F: Hashable,
G: Hashable
{ }

extension InlineProduct7: Encodable
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable,
E: Encodable,
F: Encodable,
G: Encodable
{ }

extension InlineProduct7: Decodable
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable,
E: Decodable,
F: Decodable,
G: Decodable
{ }

extension InlineProduct7: CustomStringConvertible { }
extension InlineProduct7: CustomDebugStringConvertible { }

extension InlineProduct7: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic,
F: AdditiveArithmetic,
G: AdditiveArithmetic
{ }

extension InlineProduct7: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic,
F: VectorArithmetic,
G: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension InlineProduct7: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable,
G: Identifiable

{
  public typealias ID = InlineProduct7<
    A.ID,
    B.ID,
    C.ID,
    D.ID,
    E.ID,
    F.ID,
    G.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct7
// -------------------------------------------------------------------------- //

extension InlineProduct7 : AlgebraicProduct7 {
  
  public typealias ArityPosition = Arity7Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { true }

}

