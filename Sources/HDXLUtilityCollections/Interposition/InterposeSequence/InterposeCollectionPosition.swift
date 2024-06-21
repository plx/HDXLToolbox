import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: InterposeCollectionPosition
// ------------------------------------------------------------------------- //

@usableFromInline
internal enum InterposeCollectionPosition<Index> where Index: Comparable {
  
  @usableFromInline
  internal typealias Interposition = InterpositionElement<Index>
  
  case element(Index)
  case interposition(Interposition)
  
}

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension InterposeCollectionPosition: Sendable where Index: Sendable { }
extension InterposeCollectionPosition: Equatable { }
extension InterposeCollectionPosition: Hashable where Index: Hashable { }
extension InterposeCollectionPosition: Encodable where Index: Encodable { }
extension InterposeCollectionPosition: Decodable where Index: Decodable { }

// ------------------------------------------------------------------------- //
// MARK: - Comparable
// ------------------------------------------------------------------------- //

extension InterposeCollectionPosition: Comparable {
  @inlinable
  internal static func < (
    lhs: InterposeCollectionPosition<Index>,
    rhs: InterposeCollectionPosition<Index>
  ) -> Bool {
    switch (lhs, rhs) {
    case (.element(let lIndex), .element(let rIndex)):
      lIndex < rIndex
    case (.element(let lIndex), .interposition(let rInterposition)):
      lIndex <= rInterposition.precedingElement
    case (.interposition(let lInterposition), .element(let rIndex)):
      lInterposition.subsequentElement <= rIndex
    case (.interposition(let lInterposition), .interposition(let rInterposition)):
      lInterposition < rInterposition
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension InterposeCollectionPosition: CustomStringConvertible {
  @inlinable
  internal var description: String {
    switch self {
    case .element(let element):
      ".element(\(String(describing: element)))"
    case .interposition(let interposition):
      ".interposition(\(String(describing: interposition)))"
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension InterposeCollectionPosition: CustomDebugStringConvertible {
  @inlinable
  internal var debugDescription: String {
    switch self {
    case .element(let element):
      "\(String(reflecting: type(of: self))).element(\(String(reflecting: element)))"
    case .interposition(let interposition):
      "\(String(reflecting: type(of: self))).interposition(\(String(reflecting: interposition)))"
    }
  }
}
