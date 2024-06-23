import Foundation
import SwiftUI
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: InlineProduct5
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "inline" as a struct.
/// Generally the preferred implementation for arity-2, unless one-or-both types
/// are huge structs; in that case, measurement may be required.
@frozen
public struct InlineProduct5<A,B,C,D,E> {
  
  public var a: A
  public var b: B
  public var c: C
  public var d: D
  public var e: E
  
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E
  ) {
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    self.e = e
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension InlineProduct5: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable,
D: Sendable,
E: Sendable
{ }

extension InlineProduct5: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable,
D: Equatable,
E: Equatable
{ }

extension InlineProduct5: Comparable
where
A: Comparable,
B: Comparable,
C: Comparable,
D: Comparable,
E: Comparable
{ }

extension InlineProduct5: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable,
D: Hashable,
E: Hashable
{ }

extension InlineProduct5: Encodable
where
A: Encodable,
B: Encodable,
C: Encodable,
D: Encodable,
E: Encodable
{ }

extension InlineProduct5: Decodable
where
A: Decodable,
B: Decodable,
C: Decodable,
D: Decodable,
E: Decodable
{ }

extension InlineProduct5: CustomStringConvertible { }
extension InlineProduct5: CustomDebugStringConvertible { }

extension InlineProduct5: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic,
D: AdditiveArithmetic,
E: AdditiveArithmetic
{ }

extension InlineProduct5: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic,
D: VectorArithmetic,
E: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension InlineProduct5: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable

{
  public typealias ID = InlineProduct5<
    A.ID,
    B.ID,
    C.ID,
    D.ID,
    E.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct5
// -------------------------------------------------------------------------- //

extension InlineProduct5 : AlgebraicProduct5 {
  
  public typealias ArityPosition = Arity5Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { true }

}

