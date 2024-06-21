import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: HomogenousInterposeSequenceElement - Definition
// ------------------------------------------------------------------------- //

/// This type captures the result of a forgetful transformation *from* an interposition sequence element
/// to a sequence of identically-typed values that *nevertheless* retain some record of their origin (as e.g.
/// either (a) derived-from an `.element` or (b) derived-from an `.interposition`. This is analogous
/// to ``HeterogeneousInterposeSequenceElement`` with the modification that both cases have payloads
/// of identical type.
///
/// As with that type, the point is to expliclty capture intermediate results within a chain of transformations *from*
/// an interposition sequence all the way *to* some homogeneously-typed final result (e.g. a `View` of some kind,
/// or some other similar, anticipatable destination).
///
/// - seealso: ``InterposeSequence`` for the sequence that vends values of this type/
/// - seealso: ``InterposeSequenceElement`` for the elements of the interpose sequence itself
/// - seealso: ``InterposeSequenceElementType`` for the corresopnding case-enumeration.
/// - seealso: ``HeterogeneousInterposeSequenceElement`` for intermediate results of heterogeneous type
///
@frozen
public enum HomogeneousInterposeSequenceElement<Element> {
  
  /// Case for when we have a value derived-from an element of the base sequence.
  case element(Element)
  
  /// Case for when we have a value dervied-from an interposition of elements from the base sequence.
  case interposition(Element)
  
}

// ------------------------------------------------------------------------- //
// MARK: - Primary API
// ------------------------------------------------------------------------- //

extension HomogeneousInterposeSequenceElement {
  
  /// What type of interpose-element type we are.
  @inlinable
  public var interposeSequenceElementType: InterposeSequenceElementType {
    switch self {
    case .element:
      .element
    case .interposition:
      .interposition
    }
  }
  
  /// ``true`` iff we're an `.element`-type element.
  @inlinable
  public var isElement: Bool {
    interposeSequenceElementType == .element
  }
  
  /// ``true`` iff we're an `.interposition`-type element.
  @inlinable
  public var isInterposition: Bool {
    interposeSequenceElementType == .interposition
  }
  
  @inlinable
  public var underlyingValue: Element {
    switch self {
    case .element(let value):
      value
    case .interposition(let value):
      value
    }
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - Mapping API
// ------------------------------------------------------------------------- //

extension HomogeneousInterposeSequenceElement {
  
  /// Returns the result "re-heterogenizing" a homogeneous interpose-sequence value by applying
  /// a distinct, distinctly-typed transformation to each case.
  @inlinable
  public func reheterogenize<T,V>(
    elementType: T.Type,
    interpositionType: V.Type,
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Element) throws -> V
  ) rethrows -> HeterogeneousInterposeSequenceElement<T,V> {
    switch self {
    case .element(let element):
      .element(try elementTransformation(element))
    case .interposition(let interposition):
      .interposition(try interpositionTransformation(interposition))
    }
  }
  
  /// Returns the result of applying `transformation` to the underlying value.
  @inlinable
  public func homogeneousMap<T>(
    _ transformation: (Element) throws -> T
  ) rethrows -> HomogeneousInterposeSequenceElement<T> {
    switch self {
    case .element(let element):
      .element(try transformation(element))
    case .interposition(let interposition):
      .interposition(try transformation(interposition))
    }
  }

  /// Returns the (unwrapped) result of applying `transformation` to the underlying value.
  @inlinable
  public func homogeneousMapValue<T>(
    _ transformation: (Element) throws -> T
  ) rethrows -> T {
    switch self {
    case .element(let element):
      try transformation(element)
    case .interposition(let interposition):
      try transformation(interposition)
    }
  }
  
  /// Returns the result of applying a possibly-distinct transformation for each "branch" of this enumeration.
  @inlinable
  public func distinctMap<T>(
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Element) throws -> T
  ) rethrows -> HomogeneousInterposeSequenceElement<T> {
    switch self {
    case .element(let element):
      .element(try elementTransformation(element))
    case .interposition(let interposition):
      .interposition(try interpositionTransformation(interposition))
    }
  }
  
  /// Returns the (unwrapped) result of transforming ``underlyingValue`` by possibly-distinct transformations for each case.
  @inlinable
  public func distinctMapValue<T>(
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Element) throws -> T
  ) rethrows -> T {
    switch self {
    case .element(let element):
      try elementTransformation(element)
    case .interposition(let interposition):
      try interpositionTransformation(interposition)
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension HomogeneousInterposeSequenceElement: Sendable where Element: Sendable { }
extension HomogeneousInterposeSequenceElement: Equatable where Element: Equatable { }
extension HomogeneousInterposeSequenceElement: Hashable where Element: Hashable { }
extension HomogeneousInterposeSequenceElement: Encodable where Element: Encodable { }
extension HomogeneousInterposeSequenceElement: Decodable where Element: Decodable { }

// ------------------------------------------------------------------------- //
// MARK: - CaseIterable
// ------------------------------------------------------------------------- //

extension HomogeneousInterposeSequenceElement: CaseIterable where Element: CaseIterable {
  public static var allCases: [HomogeneousInterposeSequenceElement<Element>] {
    var result: [HomogeneousInterposeSequenceElement<Element>] = []
    let allElements = Element.allCases
    result.reserveCapacity(2 * allElements.count)
    result.appendLazyApplication(
      of: Self.element(_:),
      to: allElements
    )
    result.appendLazyApplication(
      of: Self.interposition(_:),
      to: allElements
    )
    return result
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Identifiable
// ------------------------------------------------------------------------- //

extension HomogeneousInterposeSequenceElement: Identifiable where Element: Identifiable {
  public typealias ID = HomogeneousInterposeSequenceElement<Element.ID>
  
  @inlinable
  public var id: ID {
    switch self {
    case .element(let element):
      .element(element.id)
    case .interposition(let interposition):
      .interposition(interposition.id)
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension HomogeneousInterposeSequenceElement: CustomStringConvertible {
  @inlinable
  public var description: String {
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

extension HomogeneousInterposeSequenceElement: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    switch self {
    case .element(let element):
      "\(String(reflecting: type(of: self))).element(\(String(reflecting: element)))"
    case .interposition(let interposition):
      "\(String(reflecting: type(of: self))).interposition(\(String(reflecting: interposition)))"
    }
  }
}
