import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// MARK: Keywise Set Operations


// ------------------------------------------------------------------------- //
// MARK: - Out-of-Place
// ------------------------------------------------------------------------- //

extension KeyedSet {
  
  /// - seealso: ``restrictedKeywiseUnion(_:)``
  @inlinable
  public func keywiseUnion(_ other: Self) -> Self {
    pedanticAssert(hasConsistentInternalState)
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty else { return other}
    guard !other.isEmpty else { return self }
    
    let (smaller, larger) = smallerThenLarger(
      storage,
      other.storage
    )
    
    var result: Storage = larger
    for (key, valueSet) in smaller {
      switch larger[key] {
      case .none:
        result[key] = valueSet
      case .some(let existingValueSet):
        result[key] = existingValueSet.union(valueSet)
      }
    }
    
    pedanticAssert(Self.storageIsValid(result))
    return Self(storage: result)
  }
  
  /// - seealso: ``keywiseUnion(_:)``
  @inlinable
  public func restrictedKeywiseUnion(_ other: Self) -> Self {
    pedanticAssert(hasConsistentInternalState)
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty && !other.isEmpty else { return self }
    
    var result: Storage = storage
    for (key, valueSet) in storage {
      guard case .some(let otherValueSet) = other.storage[key] else {
        continue
      }
      
      result[key] = valueSet.union(otherValueSet)
    }
    
    pedanticAssert(Self.storageIsValid(result))
    return Self(storage: result)
  }
  
  @inlinable
  public func keywiseIntersection(with other: Self) -> Self {
    pedanticAssert(hasConsistentInternalState)
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty else { return self }
    guard !other.isEmpty else { return other }
    
    let (smaller, larger) = smallerThenLarger(
      self.storage,
      other.storage
    )

    var result: Storage = [:]
    for (key, valueSet) in smaller {
      guard
        case .some(let otherValueSet) = larger[key],
        let nonEmptyIntersection = valueSet.nonEmptyIntersection(
          with: otherValueSet
        )
      else {
        continue
      }
      
      result[key] = nonEmptyIntersection
    }
    
    pedanticAssert(Self.storageIsValid(result))
    return Self(storage: result)
  }
  
  @inlinable
  public func keywiseSubtracting(_ other: Self) -> Self {
    pedanticAssert(hasConsistentInternalState)
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty && !other.isEmpty else { return self }
    
    var result: Storage = [:]
    
    for (key, valueSet) in storage {
      guard
        let otherValueSet = other.storage[key]
      else {
        continue
      }
      
      let resultForKey = valueSet.subtracting(otherValueSet)
      guard !resultForKey.isEmpty else {
        continue
      }
      
      result[key] = resultForKey
    }
    
    pedanticAssert(Self.storageIsValid(result))
    return Self(storage: result)
  }
  
  /// - seealso: ``restrictedKeywiseSymmetricDifference(_:)``
  @inlinable
  public func keywiseSymmetricDifference(_ other: Self) -> Self {
    pedanticAssert(hasConsistentInternalState)
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty else { return other}
    guard !other.isEmpty else { return self }
    
    let (smaller, larger) = smallerThenLarger(
      self.storage,
      other.storage
    )
    
    var result: Storage = larger
    for (key, valueSet) in smaller {
      switch larger[key] {
      case .none:
        result[key] = valueSet
      case .some(let existingValueSet):
        let resultForKey = valueSet.symmetricDifference(existingValueSet)
        switch resultForKey.isEmpty {
        case true:
          result.removeValue(forKey: key)
        case false:
          result[key] = resultForKey
        }
      }
    }
    
    pedanticAssert(Self.storageIsValid(result))
    return Self(storage: result)
  }

  
  /// - seealso: ``keywiseSymmetricDifference(_:)``
  @inlinable
  public func restrictedKeywiseSymmetricDifference(_ other: Self) -> Self {
    pedanticAssert(hasConsistentInternalState)
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty && !other.isEmpty else { return self }
    
    var result: Storage = storage
    for (key, valueSet) in storage {
      guard case .some(let otherValueSet) = other.storage[key] else {
        continue
      }
      
      let resultForKey = valueSet.symmetricDifference(otherValueSet)
      switch resultForKey.isEmpty {
      case false:
        result[key] = resultForKey
      case true:
        result.removeValue(forKey: key)
      }
    }
    
    pedanticAssert(Self.storageIsValid(result))
    return Self(storage: result)
  }

}

// ------------------------------------------------------------------------- //
// MARK: - In-Place
// ------------------------------------------------------------------------- //

extension KeyedSet {
  
  /// - seealso: ``formRestrictedKeywiseUnion(_:)``
  @inlinable
  public mutating func formKeywiseUnion(_ other: Self) {
    pedanticAssert(other.hasConsistentInternalState)
    guard !other.isEmpty else { return }
    withValidation { (storage) in
      switch storage.isEmpty {
      case true:
        storage = other.storage
      case false:
        for (key, valueSet) in other.storage {
          storage[
            key,
            default: []
          ].formUnion(valueSet)
        }
      }
    }
  }
  
  /// - seealso: ``keywiseUnion(_:)``
  @inlinable
  public mutating func formRestrictedKeywiseUnion(_ other: Self) {
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty && !other.isEmpty else { return }
    withValidation { 
      (storage)
      in
      storage.inPlaceCompleteMutationWithoutRemoval {
        (key, valueSet)
        in
        if let otherValueSet = other.storage[key] {
          valueSet.formUnion(otherValueSet)
        }
      }
    }
  }
  
  @inlinable
  public mutating func formKeywiseIntersection(with other: Self) {
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty else { return }
    guard
      !other.isEmpty,
      let keysInCommon = Set(
        nonEmptyIntersectionOf: keys,
        with: other.keys
      )
    else {
      resetStorage(keepingCapacity: false)
      return
    }
    
    withValidation { 
      (storage)
      in
      var replacementStorage: Storage = [:]
      // TODO: measure if we should try reserving capacity?
      for keyInCommon in keysInCommon {
        guard
          let valueSet = storage[keyInCommon],
          let otherValueSet = other.storage[keyInCommon],
          let nonEmptyIntersection = valueSet.nonEmptyIntersection(
            with: otherValueSet
          )
        else {
          continue
        }
        
        replacementStorage[keyInCommon] = nonEmptyIntersection
      }
      
      storage = replacementStorage
    }
  }
  
  @inlinable
  public mutating func keywiseSubtract(_ other: Self) {
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty && !other.isEmpty else { return }
    withValidation { 
      (storage)
      in
      storage.inPlaceCompleteMutationWithAutomaticEmptyRemoval {
        (key, valueSet)
        in
        if let otherValueSet = other.storage[key] {
          valueSet.subtract(otherValueSet)
        }
      }
    }
  }
  
  /// - seealso: ``formRestrictedKeywiseSymmetricDifference(_:)``
  @inlinable
  public mutating func formKeywiseSymmetricDifference(_ other: Self) {
    pedanticAssert(other.hasConsistentInternalState)
    guard !other.isEmpty else { return }
    guard !isEmpty else {
      self = other
      return
    }
    
    withValidation { (storage) in
      for (key, otherValueSet) in other.storage {
        switch storage[key] {
        case .none:
          storage[key] = otherValueSet
        case .some(let valueSet):
          storage[key] = valueSet.nonEmptySymmetricDifference(with: otherValueSet)
        }
      }
    }
  }

  
  /// - seealso: ``formKeywiseSymmetricDifference(_:)``
  @inlinable
  public mutating func formRestrictedKeywiseSymmetricDifference(_ other: Self) {
    pedanticAssert(other.hasConsistentInternalState)
    guard !isEmpty && !other.isEmpty else { return }
    
    withValidation { (storage) in
      for key in Array(storage.keys) {
        guard let otherValueSet = other.storage[key] else {
          continue
        }
        formNonEmptySymmetricDifference(
          of: &storage[key],
          with: otherValueSet
        )
      }
    }
  }

}
