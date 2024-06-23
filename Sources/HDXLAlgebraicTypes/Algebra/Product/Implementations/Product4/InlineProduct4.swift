import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: InlineProduct4
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
public struct InlineProduct4<A,B,C,D> {
  
  public var a: A
  public var b: B
  public var c: C
  public var d: D
  
  @inlinable
  public init(
    _ a: A,
    _ b: B,
    _ c: C,
    _ d: D
  ) {
    self.a = a
    self.b = b
    self.c = c
    self.d = d
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension InlineProduct4: CustomStringConvertible { }
extension InlineProduct4: CustomDebugStringConvertible { }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension InlineProduct4: Identifiable
where
A: Identifiable,
B: Identifiable,
C: Identifiable,
D: Identifiable
{
  public typealias ID = InlineProduct4<
    A.ID,
    B.ID,
    C.ID,
    D.ID
  >
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct4
// -------------------------------------------------------------------------- //

extension InlineProduct4 : AlgebraicProduct4 {
  
  public typealias ArityPosition = Arity4Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { true }

}

