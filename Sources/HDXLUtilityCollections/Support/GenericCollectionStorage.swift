import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

@usableFromInline
@propertyWrapper
@frozen
internal struct GenericCollectionStorage<C:Collection> {
  
  @inlinable
  internal var projectedValue: GenericCollectionStorage<C> {
    get {
      self
    }
    set {
      self = newValue
    }
  }
  
  @inlinable
  internal mutating func resetCaches() {
    _count = nil
    _firstSubscriptableIndex = nil
    _finalSubscriptableIndex = nil
  }
  
  @inlinable
  internal mutating func fullyPopulateCaches() {
    let _ = count
    let _ = firstSubscriptableIndex
    let _ = finalSubscriptableIndex
  }
  
  @inlinable
  internal var hasFullyPopulatedCaches: Bool {
    guard
      nil != _count,
      nil != _firstSubscriptableIndex,
      nil != _finalSubscriptableIndex
    else {
      return false
    }
    return true
  }
  
  @usableFromInline
  internal var _wrappedValue: C
  
  @inlinable
  internal var wrappedValue: C {
    get {
      _wrappedValue
    }
    set {
      _wrappedValue = newValue
      resetCaches()
    }
  }
  
  @inlinable
  internal init(wrappedValue: C) {
    _wrappedValue = wrappedValue
  }
  
  @usableFromInline
  internal var _count: Int? = nil
  
  @inlinable
  internal var count: Int {
    mutating get {
      _count.obtainAssuredValue(
        fallback: _wrappedValue.count
      )
    }
  }
  
  @usableFromInline
  internal var _firstSubscriptableIndex: C.Index?? = nil
  
  @inlinable
  internal var firstSubscriptableIndex: C.Index? {
    mutating get {
      _firstSubscriptableIndex.obtainAssuredValue(
        fallback: _wrappedValue.firstSubscriptableIndex
      )
    }
  }
  
  @usableFromInline
  internal var _finalSubscriptableIndex: C.Index?? = nil
  
  @inlinable
  internal var finalSubscriptableIndex: C.Index? {
    mutating get {
      _finalSubscriptableIndex.obtainAssuredValue(
        fallback: _wrappedValue.finalSubscriptableIndex
      )
    }
  }
  
  @usableFromInline
  internal var subscriptableIndexRange: ClosedRange<C.Index>? {
    mutating get {
      guard
        let first = firstSubscriptableIndex,
        let final = finalSubscriptableIndex
      else {
        return nil
      }
      return first...final
    }
  }
  
  @inlinable
  internal mutating func subscriptableIndex(after index: C.Index) -> C.Index? {
    guard
      !_wrappedValue.isEmpty,
      let finalSubscriptableIndex = finalSubscriptableIndex,
      index < finalSubscriptableIndex
    else {
      return nil
    }
    
    return _wrappedValue.index(after: index)
  }
  
  @inlinable
  internal mutating func nextSubscriptableIndex(
    after index: C.Index,
    updating context: inout ProductIndexAdvancementContext
  ) -> C.Index {
    precondition(!_wrappedValue.isEmpty)
    switch context {
    case .shouldHoldPosition:
      return index
    case .shouldAttemptAdvancement:
      if let next = subscriptableIndex(after: index) {
        context = .shouldHoldPosition
        return next
      } else {
        context = .shouldAttemptAdvancement
        guard let next = firstSubscriptableIndex else {
          preconditionFailure("Shouldn't use `nextSubscriptableIndex(after:updating:)` on collections w/`nil` for `firstSubscriptableIndex`")
        }
        return next
      }
    }
  }
  
  @inlinable
  internal mutating func subscriptableIndex(
    _ index: C.Index,
    offsetBy distance: Int
  ) -> C.Index? {
    guard !_wrappedValue.isEmpty else {
      return nil
    }
    if distance == 0 {
      return index
    } else if distance > 0, let finalSubscriptableIndex = finalSubscriptableIndex {
      let destination = _wrappedValue.index(
        index,
        offsetBy: distance
      )
      guard destination <= finalSubscriptableIndex else {
        return nil
      }
      return destination
    } else if distance < 0, let firstSubscriptableIndex = firstSubscriptableIndex {
      let destination = _wrappedValue.index(
        index,
        offsetBy: distance
      )
      guard destination >= firstSubscriptableIndex else {
        return nil
      }
      return destination
    } else {
      return nil
    }
  }
  
}

extension GenericCollectionStorage where C:BidirectionalCollection {
  
  @inlinable
  internal mutating func subscriptableIndex(before index: C.Index) -> C.Index? {
    guard
      !self._wrappedValue.isEmpty,
      let firstSubscriptableIndex = firstSubscriptableIndex,
      firstSubscriptableIndex < index
    else {
      return nil
    }
    return _wrappedValue.index(before: index)
  }
  
  @inlinable
  internal mutating func previousSubscriptableIndex(
    before index: C.Index,
    updating context: inout ProductIndexRetreatContext
  ) -> C.Index {
    precondition(!_wrappedValue.isEmpty)
    switch context {
    case .shouldHoldPosition:
      return index
    case .shouldAttemptRetreat:
      if let previous = subscriptableIndex(before: index) {
        context = .shouldHoldPosition
        return previous
      } else {
        context = .shouldAttemptRetreat
        guard let finalSubscriptableIndex = finalSubscriptableIndex else {
          preconditionFailure("Shouldn't use `previousSubscriptableIndex(before:updating:)` for empty collections!")
        }
        return finalSubscriptableIndex
      }
    }
  }
  
}

extension GenericCollectionStorage : Codable where C: Codable { }
extension GenericCollectionStorage : SingleValueCodable where C:Codable {
  
  @usableFromInline
  internal typealias SingleValueCodableRepresentation = C
  
  @inlinable
  internal var singleValueCodableRepresentation: SingleValueCodableRepresentation {
    _wrappedValue
  }
  
  @inlinable
  internal init(unsafeFromSingleValueCodableRepresentation singleValueCodableRepresentation: C) throws {
    self.init(wrappedValue: singleValueCodableRepresentation)
  }
  
}

