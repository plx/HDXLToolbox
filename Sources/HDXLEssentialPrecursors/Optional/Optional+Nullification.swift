import Foundation

extension Optional {

  /// In-place sets `self` to `nil`, returning `true` iff this was actually a mutation.
  ///
  /// - returns: `true` iff `self` *was* `.some(_)`.
  ///
  /// - postcondition: `self == .none`
  ///
  @inlinable
  @discardableResult
  mutating public func formNullification() -> Bool {
    guard case .some(_) = self else {
      return false
    }
    self = .none
    return true
  }
  
  /// Conditionally sets `self` to `nil` *iff* `condition()` evaluates to `true`,
  /// returning `true` iff we actually performed such a nullification.
  ///
  /// This is equivalent to `if condition() { self = nil }`, but with the advantage
  /// of only evaluating `condition` iff `self` is non-`nil`. This is motivated
  /// by cases wherein (a) we cache an expensive-to-calculate property as `_foo: Foo?`,
  /// (b) we want to nullify `_foo` in response to *some* changes in other properties,
  /// but (c) determining *if* a change requires nullifying `_foo` is, itself,
  /// somewhat expensive (e.g. expensive-enough to be worth skipping when we can).
  ///
  /// Enter this method: we can say "nullify this *when* this condition is met"
  /// and, in turn, only evaluate that condition when we're *not already `nil`*
  ///
  /// - parameter condition: The lazily-evaluated condition determining if we *should* set `self = nil`
  ///
  /// - returns: `true` iff `self` *was* `.some(_)` but became `.none`.
  ///
  /// - postcondition: `self == .none` iff `condition()` is `true`.
  ///
  /// - seealso: `formNullification(unless:)` for the inverse-sense version.
  ///
  @inlinable
  @discardableResult
  mutating public func formNullification(
    when condition: @autoclosure () -> Bool
  ) -> Bool {
    guard
      case .some(_) = self,
      condition()
    else {
      return false
    }
    self = .none
    return true
  }
  
  /// Conditionally sets `self` to `nil` *iff* `condition()` evaluates to `false`,
  /// returning `true` iff we actually performed such a nullification.
  ///
  /// This is equivalent to `if !condition() { self = nil }`, but with the advantage
  /// of only evaluating `condition` iff `self` is non-`nil`. This is motivated
  /// by cases wherein (a) we cache an expensive-to-calculate property as `_foo: Foo?`,
  /// (b) we want to nullify `_foo` in response to *some* changes in other properties,
  /// but (c) determining *if* a change requires nullifying `_foo` is, itself,
  /// somewhat expensive (e.g. expensive-enough to be worth skipping when we can).
  ///
  /// Enter this method: we can say "nullify this *unless* this condition is met"
  /// and, in turn, only evaluate that condition when we're *not already `nil`*
  ///
  /// - parameter condition: The lazily-evaluated condition determining if we should preserve-or-nullify `self`.
  ///
  /// - returns: `true` iff `self` *was* `.some(_)` but became `.none`.
  ///
  /// - postcondition: `self == .none` iff `condition()` is `false`.
  ///
  /// - seealso: `formNullification(when:)` for the inverse-sense equivalent.
  ///
  @inlinable
  @discardableResult
  mutating public func formNullification(
    unless condition: @autoclosure () -> Bool
  ) -> Bool {
    guard
      case .some(_) = self,
      !condition()
    else {
      return false
    }
    self = .none
    return true
  }
  
}
