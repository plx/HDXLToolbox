import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: InterpositionElement
// ------------------------------------------------------------------------- //

@frozen
public struct InterpositionElement<Element> {
  public var precedingElement: Element
  public var subsequentElement: Element
  
  @inlinable
  public init(
    precedingElement: Element,
    subsequentElement: Element
  ) {
    self.precedingElement = precedingElement
    self.subsequentElement = subsequentElement
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Primary API
// ------------------------------------------------------------------------- //

extension InterpositionElement {
  
  @inlinable
  public func componentMap<T>(
    componentType: T.Type,
    _ transformation: (Element) throws -> T
  ) rethrows -> InterpositionElement<T> {
    InterpositionElement<T>(
      precedingElement: try transformation(precedingElement),
      subsequentElement: try transformation(subsequentElement)
    )
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension InterpositionElement: Sendable where Element: Sendable { }
extension InterpositionElement: Equatable where Element: Equatable { }
extension InterpositionElement: Hashable where Element: Hashable { }
extension InterpositionElement: Encodable where Element: Encodable { }
extension InterpositionElement: Decodable where Element: Decodable { }

// ------------------------------------------------------------------------- //
// MARK: - Comparable
// ------------------------------------------------------------------------- //

extension InterpositionElement: Comparable where Element: Comparable {
  
  @inlinable
  public static func < (
    lhs: InterpositionElement<Element>,
    rhs: InterpositionElement<Element>
  ) -> Bool {
    ComparisonResult.coalescing(
      lhs.precedingElement <=> rhs.precedingElement,
      lhs.subsequentElement <=> rhs.subsequentElement
    ).impliesLessThan
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CaseIterable
// ------------------------------------------------------------------------- //

extension InterpositionElement: CaseIterable where Element: CaseIterable {
  @inlinable
  public static var allCases: [InterpositionElement<Element>] {
    var result: [InterpositionElement<Element>] = []
    let allElements = Element.allCases
    let elementCount = allElements.count
    result.reserveCapacity(elementCount * elementCount)
    for precedingElement in allElements {
      for subsequentElement in allElements {
        result.append(
          InterpositionElement(
            precedingElement: precedingElement,
            subsequentElement: subsequentElement
          )
        )
      }
    }
    return result
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Identifiable
// ------------------------------------------------------------------------- //

extension InterpositionElement: Identifiable where Element: Identifiable {
  public typealias ID = InterpositionElement<Element.ID>
  
  @inlinable
  public var id: ID {
    ID(
      precedingElement: precedingElement.id,
      subsequentElement: subsequentElement.id
    )
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension InterpositionElement: CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(
      describingLabeledTuple: (
        ("precedingElement", precedingElement),
        ("subsequentElement", subsequentElement)
      )
    )
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension InterpositionElement: CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(
      forConstructorOf: Self.self,
      arguments: (
        ("precedingElement", precedingElement),
        ("subsequentElement", subsequentElement)
      )
    )
  }
}
