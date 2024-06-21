import Foundation

extension Optional {
  
  /// Returns the result of applying `extractor` to the wrapped value (if any),
  /// setting `self = .none` before returning. Essentially a "simultaneous map-and-nullify".
  ///
  /// - parameter extractor: The closure to apply to our wrapped value, if any.
  ///
  /// - returns: Either `extractor(wrappedValue)` or `nil`, depending on `self`.
  /// - throws: Will `rethrow` any errors thrown by `extractor`.
  ///
  /// - postcondition: `self == .none` iff `extractor` does not throw an error.
  ///
  /// - note: Leaves `self` unchanged when `extractor` throws an error.
  ///
  @inlinable
  mutating public func performExtraction<R>(
    using extractor: (Wrapped) throws -> R
  ) rethrows -> R? {
    guard let wrapped = self else {
      return nil
    }
    let result = try extractor(wrapped)
    self = .none
    return result
  }

  /// Returns the result of applying `extractor` to the wrapped value (if any),
  /// setting `self = .none` before returning...but only if `condition` evaluates
  /// to `true`. Essentially a "simultaneous-and-conditional map-and-nullify".
  ///
  /// - parameter condition: A lazily-evaluated condition determining if we should extract.
  /// - parameter extractor: The closure to apply to our wrapped value, if any.
  ///
  /// - returns: Either `extractor(wrappedValue)` or `nil`, depending on `self`.
  /// - throws: Will `rethrow` any errors thrown by `extractor`.
  ///
  /// - note: Leaves `self` unchanged when `extractor` throws an error.
  ///
  @inlinable
  mutating public func performExtraction<R>(
    when condition: @autoclosure () -> Bool,
    using extractor: (Wrapped) throws -> R
  ) rethrows -> R? {
    guard
      let wrapped = self,
      condition()
    else {
      return nil
    }
    let result = try extractor(wrapped)
    self = .none
    return result
  }

  /// Returns the result of applying `extractor` to the wrapped value (if any),
  /// setting `self = .none` before returning...but only if `condition` evaluates
  /// to `false`. Essentially a "simultaneous-and-conditional map-and-nullify".
  ///
  /// - parameter condition: A lazily-evaluated condition determining if we should extract.
  /// - parameter extractor: The closure to apply to our wrapped value, if any.
  ///
  /// - returns: Either `extractor(wrappedValue)` or `nil`, depending on `self`.
  /// - throws: Will `rethrow` any errors thrown by `extractor`.
  ///
  /// - note: Leaves `self` unchanged when `extractor` throws an error.
  ///
  @inlinable
  mutating public func performExtraction<R>(
    unless condition: @autoclosure () -> Bool,
    using extractor: (Wrapped) throws -> R
  ) rethrows -> R? {
    guard
      let wrapped = self,
      !condition()
    else {
      return nil
    }
    let result = try extractor(wrapped)
    self = .none
    return result
  }

}
