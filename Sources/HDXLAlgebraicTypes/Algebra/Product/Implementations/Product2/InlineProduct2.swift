import Foundation
import SwiftUI
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: InlineProduct2 - Definition
// -------------------------------------------------------------------------- //

/// Product-2 that stores all values "inline" as a struct.
/// Generally the preferred implementation for arity-2, unless one-or-both types
/// are huge structs; in that case, measurement may be required.
@frozen
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

extension InlineProduct2: Sendable where A: Sendable, B: Sendable { }
extension InlineProduct2: Equatable where A: Equatable, B: Equatable { }
extension InlineProduct2: Comparable where A: Comparable, B: Comparable { }
extension InlineProduct2: Hashable where A: Hashable, B: Hashable { }
extension InlineProduct2: Encodable where A: Encodable, B: Encodable { }
extension InlineProduct2: Decodable where A: Decodable, B: Decodable { }
extension InlineProduct2: CustomStringConvertible { }
extension InlineProduct2: CustomDebugStringConvertible { }

extension InlineProduct2: AdditiveArithmetic where A: AdditiveArithmetic, B: AdditiveArithmetic { }
extension InlineProduct2: VectorArithmetic where A: VectorArithmetic, B: VectorArithmetic { }

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

