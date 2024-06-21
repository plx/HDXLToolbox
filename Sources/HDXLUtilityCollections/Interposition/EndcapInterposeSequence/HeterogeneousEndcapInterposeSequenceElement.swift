import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousEndcapInterposeSequenceElement - Definition
// ------------------------------------------------------------------------- //

/// This type captures the result of what I'd call the slightly-forgetful transformation *from* an interposition
/// sequence element *to* heterogeneously-typed values that *do* remember whether or not they were
/// derived-from elements-or-interpositions but *do not* (necessarily) remember the original values from
/// which they were derived.
///
/// Put differently, the interposition-sequence itself has a fixed element type wherein:
///
/// - `.element` always has as payload an `Element` from the base sequence
/// - `.interposition` always has as payload an `Interposition` in-between two elements from base sequence
///
/// Now, however, let's say you want to apply the following transformation:
///
/// - `.element` => `some View` that's specific-to base elements
/// - `.interposition` => `some View` that's specific to interpositions
///
/// ...without (yet) either:
///
/// - applying type-erasure to homogeneize everything down to `AnyView` (or whatever)
/// - fully-applying all modifiers/auxiliary decorators/etc. all-at-once
/// - losing track of which values came from `.element`s vs `.interposition`s.
///
/// That's where this type comes into play: it is intended to capture the results of such intermediate
/// transformations *without* forcing either (a) premature type-erasure or (b) an all-at-once approach
/// or (c) throwing away information vis-a-vis where we obtained our values.
///
///
/// - seealso: ``EndcapInterposeSequence`` for the sequence that vends values of this type
/// - seealso: ``EndcapinterposeSequenceElementType`` for the corresponding case-enumeration.
/// - seealso: ``EndcapInterposeSequenceElement`` for the primary endcap-interposition-sequence-element representation
/// - seealso: ``HomogeneousEndcapInterposeSequenceElement`` for the homogeneous equivalent to this type
///
@frozen
public enum HeterogeneousEndcapInterposeSequenceElement<Intro, Element, Interposition, Outro> {
  /// Case for when we have a value derived-from the intro endcap.
  case intro(Intro)
  
  /// Case for when we have a value derived-from an element of the base sequence.
  case element(Element)
  
  /// Case for when we have a value derived-from an interposition of elements from the base sequence.
  case interposition(Interposition)
  
  /// Case for when we have a value derived-from the outro endcap.
  case outro(Outro)
}

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousEndcapInterposeSequenceElement - Primary API
// ------------------------------------------------------------------------- //

extension HeterogeneousEndcapInterposeSequenceElement {
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

extension HeterogeneousEndcapInterposeSequenceElement {
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
  
}

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousEndcapInterposeSequenceElement - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension HeterogeneousEndcapInterposeSequenceElement: Sendable where Intro: Sendable, Element: Sendable, Interposition: Sendable, Outro: Sendable { }
extension HeterogeneousEndcapInterposeSequenceElement: Equatable where Intro: Equatable, Element: Equatable, Interposition: Equatable, Outro: Equatable { }
extension HeterogeneousEndcapInterposeSequenceElement: Hashable where Intro: Hashable, Element: Hashable, Interposition: Hashable, Outro: Hashable { }
extension HeterogeneousEndcapInterposeSequenceElement: Encodable where Intro: Encodable, Element: Encodable, Interposition: Encodable, Outro: Encodable { }
extension HeterogeneousEndcapInterposeSequenceElement: Decodable where Intro: Decodable, Element: Decodable, Interposition: Decodable, Outro: Decodable { }

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousEndcapInterposeSequenceElement - CaseIterable
// ------------------------------------------------------------------------- //

extension HeterogeneousEndcapInterposeSequenceElement: CaseIterable where Intro: CaseIterable, Element: CaseIterable, Interposition: CaseIterable, Outro: CaseIterable {
  public static var allCases: [HeterogeneousEndcapInterposeSequenceElement<Intro, Element, Interposition, Outro>] {
    var result: [HeterogeneousEndcapInterposeSequenceElement<Intro, Element, Interposition, Outro>] = []
    let allIntros = Intro.allCases
    let allElements = Element.allCases
    let allInterpositions = Interposition.allCases
    let allOutros = Outro.allCases
    result.reserveCapacity(
      allIntros.count
      +
      allElements.count
      +
      allInterpositions.count
      +
      allOutros.count
    )
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
      to: allInterpositions
    )
    result.appendLazyApplication(
      of: Self.outro(_:),
      to: allOutros
    )
    return result
  }
}

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousEndcapInterposeSequenceElement - Identifiable
// ------------------------------------------------------------------------- //

extension HeterogeneousEndcapInterposeSequenceElement: Identifiable where Intro: Identifiable, Element: Identifiable, Interposition: Identifiable, Outro: Identifiable {
  public typealias ID = HeterogeneousEndcapInterposeSequenceElement<Intro.ID, Element.ID, Interposition.ID, Outro.ID>
  
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
// MARK: HeterogeneousEndcapInterposeSequenceElement - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension HeterogeneousEndcapInterposeSequenceElement: CustomStringConvertible {
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
// MARK: HeterogeneousEndcapInterposeSequenceElement - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension HeterogeneousEndcapInterposeSequenceElement: CustomDebugStringConvertible {
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
