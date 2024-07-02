import Foundation
import HDXLEssentialPrecursors
import HDXLEssentialMacros

// ------------------------------------------------------------------------- //
// MARK: InterposeSequenceElement - Definition
// ------------------------------------------------------------------------- //

/// This is the primary element type provided-by ``InterposeSequence``. It directly models the
/// semantics of an ``InterposeSequence``, in that the interpose-sequence elements will be either
/// elements from the base sequence *or* interpositons of said elements.
///
/// - Note: in principal these types could be consolidated-down to a single generic (+ some typealiases). In practice I like keeping them separate to keep the semantics clearer...but may revisit this in the future.
///
/// - seealso: ``InterposeSequence`` for the sequence that vends values of this type/
/// - seealso: ``InterposeSequenceElementType`` for the corresopnding case-enumeration.
///
@frozen
@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyEncodable
@ConditionallyDecodable
public enum InterposeSequenceElement<Element> {
  public typealias Interposition = InterpositionElement<Element>

  /// Case for when we have an element from the base sequence.
  case element(Element)
  
  /// Case for when we have an interposition of elements from the base sequence.
  case interposition(Interposition)
}

// ------------------------------------------------------------------------- //
// MARK: - Primary API
// ------------------------------------------------------------------------- //

extension InterposeSequenceElement {
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
// MARK: - Mapping API
// ------------------------------------------------------------------------- //

extension InterposeSequenceElement {
  
  /// Returns the result of applying distinctly-typed transformations to each "branch" of this enumeration.
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
  
  /// Returns the result of mapping each "branch" of `self` to a value with a common type/
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
  
  /// Returns the (unwrapped) result of mapping each "branch" of `self` to a value with a common type/
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
  
  /// Returns the result of applying a component-level map to each "branch" of `self`.
  @inlinable
  public func componentMap<T>(
    componentType: T.Type,
    _ transformation: (Element) throws -> T
  ) rethrows -> InterposeSequenceElement<T> {
    switch self {
    case .element(let element):
      .element(try transformation(element))
    case .interposition(let interposition):
      .interposition(
        try interposition.componentMap(
          componentType: componentType,
          transformation
        )
      )
    }
  }
  
}

// ------------------------------------------------------------------------- //
// MARK: - CaseIterable
// ------------------------------------------------------------------------- //

extension InterposeSequenceElement: CaseIterable where Element: CaseIterable {
  public static var allCases: [InterposeSequenceElement<Element>] {
    var result: [InterposeSequenceElement<Element>] = []
    let allElements = Element.allCases
    let elementCount = allElements.count
    result.reserveCapacity((1 + elementCount) * elementCount)
    result.appendLazyApplication(
      of: Self.element(_:),
      to: allElements
    )
    result.appendLazyApplication(
      of: Self.interposition(_:),
      to: Interposition.allCases
    )
    return result
  }
}

// ------------------------------------------------------------------------- //
// MARK: - Identifiable
// ------------------------------------------------------------------------- //

extension InterposeSequenceElement: Identifiable where Element: Identifiable {
  public typealias ID = InterposeSequenceElement<Element.ID>
  
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

extension InterposeSequenceElement: CustomStringConvertible {
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

extension InterposeSequenceElement: CustomDebugStringConvertible {
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
