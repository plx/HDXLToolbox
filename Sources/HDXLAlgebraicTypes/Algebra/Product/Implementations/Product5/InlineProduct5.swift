import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: InlineProduct5
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "inline" as a struct.
/// Generally the preferred implementation for arity-2, unless one-or-both types
/// are huge structs; in that case, measurement may be required.
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
@ConditionallyAdditiveArithmetic
@ConditionallyVectorArithmetic
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

extension InlineProduct5: CustomStringConvertible { }
extension InlineProduct5: CustomDebugStringConvertible { }

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

