import Foundation
import SwiftUI
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: InlineProduct3
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "inline" as a struct.
/// Generally the preferred implementation for arity-2, unless one-or-both types
/// are huge structs; in that case, measurement may be required.
@frozen
public struct InlineProduct3<A,B,C> {
  
  public var a: A
  public var b: B
  public var c: C
  
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C
  ) {
    self.a = a
    self.b = b
    self.c = c
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension InlineProduct3: Sendable
where
A: Sendable,
B: Sendable,
C: Sendable
{ }

extension InlineProduct3: Equatable
where
A: Equatable,
B: Equatable,
C: Equatable
{ }

extension InlineProduct3: Comparable
where
A: Comparable,
B: Comparable,
C: Comparable
{ }

extension InlineProduct3: Hashable
where
A: Hashable,
B: Hashable,
C: Hashable
{ }

extension InlineProduct3: Encodable
where
A: Encodable,
B: Encodable,
C: Encodable
{ }

extension InlineProduct3: Decodable
where
A: Decodable,
B: Decodable,
C: Decodable
{ }

extension InlineProduct3: CustomStringConvertible { }
extension InlineProduct3: CustomDebugStringConvertible { }

extension InlineProduct3: AdditiveArithmetic
where
A: AdditiveArithmetic,
B: AdditiveArithmetic,
C: AdditiveArithmetic
{ }

extension InlineProduct3: VectorArithmetic
where
A: VectorArithmetic,
B: VectorArithmetic,
C: VectorArithmetic
{ }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension InlineProduct3: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable
{
  public typealias ID = InlineProduct3<
    A.ID,
    B.ID,
    C.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct3
// -------------------------------------------------------------------------- //

extension InlineProduct3 : AlgebraicProduct3 {
  
  public typealias ArityPosition = Arity3Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { true }

}

