import Foundation

extension Optional {
    
  /// In-place sets `self` to `nil`, while returning the previously-wrapped value (if any).
  ///
  /// - returns: Our wrapped value iff we had one; `nil` otherwise.
  ///
  /// - postcondition: `self == .none`
  ///
  @inlinable
  public mutating func removeValue() -> Wrapped? {
    guard let value = self else {
      return nil
    }
    self = .none
    return value
  }

  /// For non-`nil` values will (a) return the underlying value and (b) set `self`
  /// to `nil`, but if and only if `condition` is satisfied; a no-op on `nil`.
  ///
  /// This is intend to be a *convenient* way to avoid unnecessary evaluation of
  /// a possibly-expensive `condition` *without* cluttering the call-site with a conditional.
  ///
  /// - parameter condition: A lazily-evaluated condition that determines *if* we should remove our underlying value.
  ///
  /// - returns: Our wrapped value iff we had one *and* `condition` evaluates to `true`; `nil` otherwise.
  ///
  @inlinable
  public mutating func removeValue(
    when condition: @autoclosure () -> Bool
  ) -> Wrapped? {
    guard
      let value = self,
      condition()
    else {
      return nil
    }
    self = .none
    return value
  }

  /// For non-`nil` values will (a) return the underlying value and (b) set `self`
  /// to `nil`, but if and only if `condition` is *not* satisfied; a no-op on `nil`.
  ///
  /// This is intend to be a *convenient* way to avoid unnecessary evaluation of
  /// a possibly-expensive `condition` *without* cluttering the call-site with a conditional.
  ///
  /// - parameter condition: A lazily-evaluated condition that determines *if* we should remove our underlying value.
  ///
  /// - returns: Our wrapped value iff we had one *and* `condition` evaluates to `false`; `nil` otherwise.
  ///
  @inlinable
  public mutating func removeValue(
    unless condition: @autoclosure () -> Bool
  ) -> Wrapped? {
    guard
      let value = self,
      !condition()
    else {
      return nil
    }
    self = .none
    return value
  }

}
