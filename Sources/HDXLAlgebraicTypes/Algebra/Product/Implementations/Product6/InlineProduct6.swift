import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: InlineProduct6
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
public struct InlineProduct6<A,B,C,D,E,F> {
  
  public var a: A
  public var b: B
  public var c: C
  public var d: D
  public var e: E
  public var f: F
  
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D,
    _ e: E,
    _ f: F
  ) {
    self.a = a
    self.b = b
    self.c = c
    self.d = d
    self.e = e
    self.f = f
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension InlineProduct6: CustomStringConvertible { }
extension InlineProduct6: CustomDebugStringConvertible { }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension InlineProduct6: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable,
E: Identifiable,
F: Identifiable

{
  public typealias ID = InlineProduct6<
    A.ID,
    B.ID,
    C.ID,
    D.ID,
    E.ID,
    F.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct6
// -------------------------------------------------------------------------- //

extension InlineProduct6 : AlgebraicProduct6 {
  
  public typealias ArityPosition = Arity6Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { true }

}

