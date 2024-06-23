import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: InlineProduct7
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

extension InlineProduct7: CustomStringConvertible { }
extension InlineProduct7: CustomDebugStringConvertible { }

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

