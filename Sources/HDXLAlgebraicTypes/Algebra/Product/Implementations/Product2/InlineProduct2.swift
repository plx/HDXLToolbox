import Foundation
import SwiftUI
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// -------------------------------------------------------------------------- //
// MARK: InlineProduct2 - Definition
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
public struct InlineProduct2<A,B> {
  
  public var a: A
  public var b: B
  
  @inlinable
  public init(
    _ a: A,
    _ b: B
  ) {
    self.a = a
    self.b = b
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension InlineProduct2: CustomStringConvertible { }
extension InlineProduct2: CustomDebugStringConvertible { }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension InlineProduct2: Identifiable where A: Identifiable, B: Identifiable {
  public typealias ID = InlineProduct2<A.ID, B.ID>
}

// -------------------------------------------------------------------------- //
// MARK: - AlgebraicProduct2
// -------------------------------------------------------------------------- //

extension InlineProduct2 : AlgebraicProduct2 {
  
  public typealias ArityPosition = Arity2Position

  @inlinable
  public static var withDerivationShouldEnsureUniqueCopyByDefault: Bool { true }

}

