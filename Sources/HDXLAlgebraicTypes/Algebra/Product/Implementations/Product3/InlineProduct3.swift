import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: InlineProduct3
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

extension InlineProduct3: CustomStringConvertible { }
extension InlineProduct3: CustomDebugStringConvertible { }

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

