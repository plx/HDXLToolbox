import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequenceElement
// ------------------------------------------------------------------------- //

/// This is the primary element type provided-by ``EndcapInterposeSequence``. It directly models the
/// semantics of an ``EndcapInterposeSequence``, in that the interpose-sequence elements will be either
/// elements from the base sequence *or* interpositons of said elements.
///
/// - Note: in principal these types could be consolidated-down to a single generic (+ some typealiases). In practice I like keeping them separate to keep the semantics clearer...but may revisit this in the future.
///
/// - seealso: ``EndcapInterposeSequence`` for the sequence that vends values of this type.
/// - seealso: ``EndcapInterposeSequenceElementType`` for the corresponding case-enumeration.
/// - seealso: ``HeterogeneousEndcapInterposeSequenceElement`` for the corresponding heterogeneously-typed derived value.
/// - seealso: ``HomogeneousEndcapInterposeSequenceElement`` for the corresponding homogeneously-typed derived value.
///
@frozen
public enum EndcapInterposeSequenceElement<Intro,Element,Outro> {
  public typealias Interposition = InterpositionElement<Element>

  /// Corresponds to the lead-in element.
  case intro(Intro)
  
  /// Corresponds to an element from the base sequence.
  case element(Element)
  
  /// Corresponds to an interposition between two elements from the base sequence.
  case interposition(Interposition)
  
  /// Corresponds to the lead-out element.
  case outro(Outro)
  
}

// ------------------------------------------------------------------------- //
// MARK: - Primary API
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElement {
  @inlinable
  public var endcapInterposeSequenceElementType: EndcapInterposeSequenceElementType {
    switch self {
    case .intro:
      return .intro
    case .element:
      return .element
    case .interposition:
      return .interposition
    case .outro:
      return .outro
    }
  }

  @inlinable
  public var isIntro: Bool {
    endcapInterposeSequenceElementType == .intro
  }

  @inlinable
  public var isElement: Bool {
    endcapInterposeSequenceElementType == .element
  }
  
  @inlinable
  public var isInterposition: Bool {
    endcapInterposeSequenceElementType == .interposition
  }
  
  @inlinable
  public var isOutro: Bool {
    endcapInterposeSequenceElementType == .outro
  }
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequenceElement - Mapping API
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElement {
  
  /// Returns the result of applying heterogeneously-typed, per-"branch" transformations.
  @inlinable
  public func heterogeneousMap<A,B,C,D>(
    introType: A.Type,
    elementType: B.Type,
    interpositionType: C.Type,
    outroType: D.Type,
    introTransformation: (Intro) throws -> A,
    elementTransformation: (Element) throws -> B,
    interpositionTransformation: (Interposition) throws -> C,
    outroTransformation: (Outro) throws -> D
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
    introTransformation: (Intro) throws -> T,
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Interposition) throws -> T,
    outroTransformation: (Outro) throws -> T
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
  public func homogeneousMapValue<T>(
    homogeneousType: T.Type,
    introTransformation: (Intro) throws -> T,
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Interposition) throws -> T,
    outroTransformation: (Outro) throws -> T
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
  
  /// Returns the result of applying a component-level map to each "branch" of `self`.
  @inlinable
  public func componentMap<T>(
    componentType: T.Type,
    _ transformation: (Element) throws -> T
  ) rethrows -> EndcapInterposeSequenceElement<Intro, T, Outro> {
    switch self {
    case .intro(let intro):
      .intro(intro)
    case .element(let element):
      .element(try transformation(element))
    case .interposition(let interposition):
      .interposition(
        try interposition.componentMap(
          componentType: componentType,
          transformation
        )
      )
    case .outro(let outro):
      .outro(outro)
    }
  }

}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequenceElement - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElement: Sendable where Intro: Sendable, Element: Sendable, Outro: Sendable { }
extension EndcapInterposeSequenceElement: Equatable where Intro: Equatable, Element: Equatable, Outro: Equatable { }
extension EndcapInterposeSequenceElement: Hashable where Intro: Hashable, Element: Hashable, Outro: Hashable { }
extension EndcapInterposeSequenceElement: Encodable where Intro: Encodable, Element: Encodable, Outro: Encodable { }
extension EndcapInterposeSequenceElement: Decodable where Intro: Decodable, Element: Decodable, Outro: Decodable { }

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequenceElement - CaseIterable
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElement: CaseIterable where Intro: CaseIterable, Element: CaseIterable, Outro: CaseIterable {
  public static var allCases: [EndcapInterposeSequenceElement<Intro, Element, Outro>] {
    var result: [EndcapInterposeSequenceElement<Intro, Element, Outro>] = []
    let allIntros = Intro.allCases
    let allElements = Element.allCases
    let allOutros = Outro.allCases
    let elementCount = allElements.count
    result.reserveCapacity(allIntros.count + ((1 + elementCount) * elementCount) + allOutros.count)
    result.appendLazyApplication(
      of: Self.intro(_:),
      to: allIntros
    )
    result.appendLazyApplication(
      of: Self.element(_:),
      to: allElements
    )
    result.appendLazyApplication(
      of: Self.interposition(_:),
      to: Interposition.allCases
    )
    result.appendLazyApplication(
      of: Self.outro(_:),
      to: allOutros
    )
    return result
  }
}

// ------------------------------------------------------------------------- //
// MARK: EndcapInterposeSequenceElement - Identifiable
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElement: Identifiable where Intro: Identifiable, Element: Identifiable, Outro: Identifiable {
  public typealias ID = EndcapInterposeSequenceElement<Intro.ID, Element.ID, Outro.ID>
  
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
// MARK: EndcapInterposeSequenceElement - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElement: CustomStringConvertible {
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
// MARK: EndcapInterposeSequenceElement - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension EndcapInterposeSequenceElement: CustomDebugStringConvertible {
  @inlinable
  public var debugDescription: String {
    switch self {
    case .intro(let intro):
      "\(String(reflecting: type(of: self))).intro(\(String(reflecting: intro)))"
    case .element(let element):
      "\(String(reflecting: type(of: self))).element(\(String(reflecting: element)))"
    case .interposition(let interposition):
      "\(String(reflecting: type(of: self))).interposition(\(String(reflecting: interposition)))"
    case .outro(let outro):
      "\(String(reflecting: type(of: self))).outro(\(String(reflecting: outro)))"
    }
  }
}
