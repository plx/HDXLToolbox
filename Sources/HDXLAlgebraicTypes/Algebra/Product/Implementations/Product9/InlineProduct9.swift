import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: InlineProduct9
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

extension InlineProduct9: CustomStringConvertible { }
extension InlineProduct9: CustomDebugStringConvertible { }

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

