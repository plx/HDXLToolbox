import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: HomogeneousEndcapInterposeSequenceElement - Definition
// ------------------------------------------------------------------------- //

/// This type captures the result of a partially-forgetful mapping down to some common underlying type
/// that, nevertheless, doesn't entirely forget the source of the associated values.
///
/// - seealso: ``EndcapInterposeSequence`` for the sequence that vends values of this type
/// - seealso: ``EndcapinterposeSequenceElementType`` for the corresponding case-enumeration.
/// - seealso: ``EndcapInterposeSequenceElement`` for the primary endcap-interposition-sequence-element representation 
/// - seealso: ``HeterogeneousEndcapInterposeSequenceElement`` for the heterogeneous equivalent to this type
///
@frozen
public enum HomogeneousEndcapInterposeSequenceElement<Element> {
  /// Case for when we have a value derived-from the intro endcap.
  case intro(Element)
  
  /// Case for when we have a value derived-from an element of the base sequence.
  case element(Element)
  
  /// Case for when we have a value derived-from an interposition of elements from the base sequence.
  case interposition(Element)
  
  /// Case for when we have a value derived-from the outro endcap.
  case outro(Element)
}

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousEndcapInterposeSequenceElement - Primary API
// ------------------------------------------------------------------------- //

extension HomogeneousEndcapInterposeSequenceElement {
  /// What type of interpose-element type we are.
  @inlinable
  public var endcapInterposeSequenceElementType: EndcapInterposeSequenceElementType {
    switch self {
    case .intro:
      .intro
    case .element:
      .element
    case .interposition:
      .interposition
    case .outro:
      .outro
    }
  }
  
  /// ``true`` iff we're an `.intro`-type element.
  @inlinable
  public var isIntro: Bool {
    endcapInterposeSequenceElementType == .intro
  }
  
  /// ``true`` iff we're an `.element`-type element.
  @inlinable
  public var isElement: Bool {
    endcapInterposeSequenceElementType == .element
  }
  
  /// ``true`` iff we're an `.interposition`-type element.
  @inlinable
  public var isInterposition: Bool {
    endcapInterposeSequenceElementType == .interposition
  }
  
  /// ``true`` iff we're an `.outro`-type element.
  @inlinable
  public var isOutro: Bool {
    endcapInterposeSequenceElementType == .outro
  }
}

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousEndcapInterposeSequenceElement - Mapping API
// ------------------------------------------------------------------------- //

extension HomogeneousEndcapInterposeSequenceElement {
  /// Returns the result of applying heterogeneously-typed, per-"branch" transformations.
  @inlinable
  public func reheterogenize<A,B,C,D>(
    introType: A.Type,
    elementType: B.Type,
    interpositionType: C.Type,
    outroType: D.Type,
    introTransformation: (Element) throws -> A,
    elementTransformation: (Element) throws -> B,
    interpositionTransformation: (Element) throws -> C,
    outroTransformation: (Element) throws -> D
  ) rethrows -> HeterogeneousEndcapInterposeSequenceElement<A,B,C,D> {
    switch self {
    case .intro(let intro):
      .intro(try introTransformation(intro))
    case .element(let element):
      .element(try elementTransformation(element))
    case .interposition(let interposition):
      .interposition(try interpositionTransformation(interposition))
    case .outro(let outro):
      .outro(try outroTransformation(outro))
    }
  }
  
  /// Returns the result of applying distinct, per-"branch" transformations to some homogeneous destination type.
  @inlinable
  public func homogeneousMap<T>(
    homogeneousType: T.Type,
    _ transformation: (Element) throws -> T
  ) rethrows -> HomogeneousEndcapInterposeSequenceElement<T> {
    switch self {
    case .intro(let intro):
      .intro(try transformation(intro))
    case .element(let element):
      .element(try transformation(element))
    case .interposition(let interposition):
      .interposition(try transformation(interposition))
    case .outro(let outro):
      .outro(try transformation(outro))
    }
  }

  /// Returns the result of applying distinct, per-"branch" transformations to some homogeneous destination type.
  @inlinable
  public func homogeneousMapValue<T>(
    homogeneousType: T.Type,
    _ transformation: (Element) throws -> T
  ) rethrows -> T {
    switch self {
    case .intro(let intro):
      try transformation(intro)
    case .element(let element):
      try transformation(element)
    case .interposition(let interposition):
      try transformation(interposition)
    case .outro(let outro):
      try transformation(outro)
    }
  }

  /// Returns the result of applying distinct, per-"branch" transformations to some homogeneous destination type.
  @inlinable
  public func distinctMap<T>(
    homogeneousType: T.Type,
    introTransformation: (Element) throws -> T,
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Element) throws -> T,
    outroTransformation: (Element) throws -> T
  ) rethrows -> HomogeneousEndcapInterposeSequenceElement<T> {
    switch self {
    case .intro(let intro):
      .intro(try introTransformation(intro))
    case .element(let element):
      .element(try elementTransformation(element))
    case .interposition(let interposition):
      .interposition(try interpositionTransformation(interposition))
    case .outro(let outro):
      .outro(try outroTransformation(outro))
    }
  }
  
  /// Returns the (unwrapped) result of applying distinct, per-"branch" transformations to some homogeneous destination type.
  @inlinable
  public func distinctMapValue<T>(
    homogeneousType: T.Type,
    introTransformation: (Element) throws -> T,
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Element) throws -> T,
    outroTransformation: (Element) throws -> T
  ) rethrows -> T {
    switch self {
    case .intro(let intro):
      try introTransformation(intro)
    case .element(let element):
      try elementTransformation(element)
    case .interposition(let interposition):
      try interpositionTransformation(interposition)
    case .outro(let outro):
      try outroTransformation(outro)
    }
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: HomogeneousEndcapInterposeSequenceElement - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension HomogeneousEndcapInterposeSequenceElement: Sendable where Element: Sendable { }
extension HomogeneousEndcapInterposeSequenceElement: Equatable where Element: Equatable { }
extension HomogeneousEndcapInterposeSequenceElement: Hashable where Element: Hashable { }
extension HomogeneousEndcapInterposeSequenceElement: Encodable where Element: Encodable { }
extension HomogeneousEndcapInterposeSequenceElement: Decodable where Element: Decodable { }

// ------------------------------------------------------------------------- //
// MARK: HomogeneousEndcapInterposeSequenceElement - CaseIterable
// ------------------------------------------------------------------------- //

extension HomogeneousEndcapInterposeSequenceElement: CaseIterable where Element: CaseIterable {
  public static var allCases: [HomogeneousEndcapInterposeSequenceElement<Element>] {
    var result: [HomogeneousEndcapInterposeSequenceElement<Element>] = []
    let allElements = Element.allCases
    result.reserveCapacity(
      4 * allElements.count
    )
    result.appendLazyApplication(
      of: Self.intro(_:),
      to: allElements
    )
    result.appendLazyApplication(
      of: Self.element(_:),
      to: allElements
    )
    result.appendLazyApplication(
      of: Self.interposition(_:),
      to: allElements
    )
    result.appendLazyApplication(
      of: Self.outro(_:),
      to: allElements
    )
    return result
  }
}

// ------------------------------------------------------------------------- //
// MARK: HomogeneousEndcapInterposeSequenceElement - Identifiable
// ------------------------------------------------------------------------- //

extension HomogeneousEndcapInterposeSequenceElement: Identifiable where Element: Identifiable {
  public typealias ID = HomogeneousEndcapInterposeSequenceElement<Element.ID>
  
  @inlinable
  public var id: ID {
    switch self {
    case .intro(let intro):
      .intro(intro.id)
    case .element(let element):
      .element(element.id)
    case .interposition(let interposition):
      .interposition(interposition.id)
    case .outro(let outro):
      .outro(outro.id)
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: HomogeneousEndcapInterposeSequenceElement - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension HomogeneousEndcapInterposeSequenceElement: CustomStringConvertible {
  @inlinable
  public var description: String {
    switch self {
    case .intro(let intro):
      ".intro(\(String(describing: intro)))"
    case .element(let element):
      ".element(\(String(describing: element)))"
    case .interposition(let interposition):
      ".interposition(\(String(describing: interposition)))"
    case .outro(let outro):
      ".outro(\(String(describing: outro)))"
    }
  }
}

// ------------------------------------------------------------------------- //
// MARK: HomogeneousEndcapInterposeSequenceElement - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension HomogeneousEndcapInterposeSequenceElement: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    switch self {
    case .intro(let intro):
      "\(String(reflecting: type(of: self))).interposition(\(String(reflecting: intro)))"
    case .element(let element):
      "\(String(reflecting: type(of: self))).element(\(String(reflecting: element)))"
    case .interposition(let interposition):
      "\(String(reflecting: type(of: self))).interposition(\(String(reflecting: interposition)))"
    case .outro(let outro):
      "\(String(reflecting: type(of: self))).outro(\(String(reflecting: outro)))"
    }
  }
}
