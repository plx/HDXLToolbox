import Foundation
import HDXLEssentialPrecursors

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousInterposeSequenceElement - Definition
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
/// - seealso: ``InterposeSequence`` for the sequence that vends values of this type/
/// - seealso: ``interposeSequenceElementType`` for the corresopnding case-enumeration.
///
@frozen
public enum HeterogeneousInterposeSequenceElement<Element, Interposition> {
  /// Case for when we have an element from the base sequence.
  case element(Element)
  
  /// Case for when we have an interposition of elements from the base sequence.
  case interposition(Interposition)
}

// ------------------------------------------------------------------------- //
// MARK: - Primary API
// ------------------------------------------------------------------------- //

extension HeterogeneousInterposeSequenceElement {
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
}

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousInterposeSequenceElement - Mapping API
// ------------------------------------------------------------------------- //

extension HeterogeneousInterposeSequenceElement {
  /// Returns the result of applying heterogeneously-typed, per-"branch" transformations.
  @inlinable
  public func heterogeneousMap<T,V>(
    elementType: T.Type,
    interpositionType: V.Type,
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Interposition) throws -> V
  ) rethrows -> HeterogeneousInterposeSequenceElement<T,V> {
    switch self {
    case .element(let element):
      .element(try elementTransformation(element))
    case .interposition(let interposition):
      .interposition(try interpositionTransformation(interposition))
    }
  }
  
  /// Returns the result of applying distinct, per-"branch" transformations to some homogeneous destination type.
  @inlinable
  public func homogeneousMap<T>(
    homogeneousType: T.Type,
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Interposition) throws -> T
  ) rethrows -> HomogeneousInterposeSequenceElement<T> {
    switch self {
    case .element(let element):
      .element(try elementTransformation(element))
    case .interposition(let interposition):
      .interposition(try interpositionTransformation(interposition))
    }
  }
  
  /// Returns the (unwrapped) result of applying distinct, per-"branch" transformations to some homogeneous destination type.
  @inlinable
  public func homogeneousMapValue<T>(
    homogeneousType: T.Type,
    elementTransformation: (Element) throws -> T,
    interpositionTransformation: (Interposition) throws -> T
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
// MARK: HeterogeneousInterposeSequenceElement - Synthesized Conformances
// ------------------------------------------------------------------------- //

extension HeterogeneousInterposeSequenceElement: Sendable where Element: Sendable, Interposition: Sendable { }
extension HeterogeneousInterposeSequenceElement: Equatable where Element: Equatable, Interposition: Equatable { }
extension HeterogeneousInterposeSequenceElement: Hashable where Element: Hashable, Interposition: Hashable { }
extension HeterogeneousInterposeSequenceElement: Encodable where Element: Encodable, Interposition: Encodable { }
extension HeterogeneousInterposeSequenceElement: Decodable where Element: Decodable, Interposition: Decodable { }

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousInterposeSequenceElement - CaseIterable
// ------------------------------------------------------------------------- //

extension HeterogeneousInterposeSequenceElement: CaseIterable where Element: CaseIterable, Interposition: CaseIterable {
  public static var allCases: [HeterogeneousInterposeSequenceElement<Element, Interposition>] {
    var result: [HeterogeneousInterposeSequenceElement<Element, Interposition>] = []
    let allElements = Element.allCases
    let allInterpositions = Interposition.allCases
    result.reserveCapacity(allElements.count + allInterpositions.count)
    result.appendLazyApplication(
      of: Self.element(_:),
      to: allElements
    )
    result.appendLazyApplication(
      of: Self.interposition(_:),
      to: allInterpositions
    )
    return result
  }
}

// ------------------------------------------------------------------------- //
// MARK: HeterogeneousInterposeSequenceElement - Identifiable
// ------------------------------------------------------------------------- //

extension HeterogeneousInterposeSequenceElement: Identifiable where Element: Identifiable, Interposition: Identifiable {
  public typealias ID = HeterogeneousInterposeSequenceElement<Element.ID, Interposition.ID>
  
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
// MARK: HeterogeneousInterposeSequenceElement - CustomStringConvertible
// ------------------------------------------------------------------------- //

extension HeterogeneousInterposeSequenceElement: CustomStringConvertible {
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
// MARK: HeterogeneousInterposeSequenceElement - CustomDebugStringConvertible
// ------------------------------------------------------------------------- //

extension HeterogeneousInterposeSequenceElement: CustomDebugStringConvertible {
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
