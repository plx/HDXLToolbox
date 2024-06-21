import Foundation

extension Optional {

  /// Equivalent-to `(self = self ?? fallback()); return self!)`: obtains a non-`nil`
  /// value from either `self` or `fallback()`, overwrites `self` with that value
  /// (if necessary), then returns that non-`nil` value.
  ///
  /// Motivated by the pervasive presence of properties that need in complicated
  /// Swift datatypes to be, at once, (1) conditionally-resettable, (2) lazily-(re)calculated,
  /// and (3) cached-for-efficiency. For such properties it's natural to write
  /// them out like so:
  ///
  /// ```swift
  /// internal var _foo: Foo? = nil
  /// public var foo: Foo {
  ///   get {
  ///     return self._foo.obtainAssuredValue(
  ///       fallback: self.expensiveFooConstruction()
  ///     )
  ///   }
  /// }
  /// ```
  ///
  /// ...wherein `_foo` gets nullified whenever its dependencies get mutated.
  ///
  /// A good example, here, comes from something like a cartesian-product collection
  /// wherein (a) the `count` of the product is the product of the component `count`s,
  /// (b) we can mutate the individual components at-will, and (c) we can't *assume*
  /// that components' implementation of `count` has constant cost (Swift allows
  /// for `O(n)` `count` implmementation): we nullify our `_count` whenever we
  /// mutate any component, we recalculate it whenever we need `count`, and so on.
  ///
  /// - parameter fallback: A lazily-evaluated source for our non-`nil` value.
  ///
  /// - returns: The equivalent-of `self ?? fallback()`.
  ///
  /// - postcondition: `self != nil`.
  ///
  /// - note: A verbose name chosen *deliberately* in order to avoid colliding with "nicer" names like `assured(by:)`.
  ///
  /// - seealso: `Optional.obtainWeaklyAssuredValue(fallback:)`
  ///
  @inlinable
  mutating public func obtainAssuredValue(
    fallback: @autoclosure () -> Wrapped
  ) -> Wrapped {
    switch self {
    case .some(let wrapped):
      return wrapped
    case .none:
      let value = fallback()
      self = .some(value)
      return value
    }
  }
  
  /// Equivalent-to `(self = self ?? fallback()); return self)`: obtains a possibly
  /// non-nil value from either `self` or `fallback()`, overwrites `self` with that value
  /// (if necessary and non-`nil`), and returns either that non-`nil` value or `nil`, as-appropriate.
  ///
  /// Motivated by the pervasive presence of properties that need in complicated
  /// Swift datatypes to be, at once, (1) conditionally-resettable, (2) lazily-(re)calculated,
  /// and (3) cached-for-efficiency. For such properties it's natural to write
  /// them out like so:
  ///
  /// ```swift
  /// internal var _foo: Foo? = nil
  /// public var foo: Foo? {
  ///   get {
  ///     return self._foo.obtainWeaklyAssuredValue(
  ///       fallback: self.expensiveFooConstruction()
  ///     )
  ///   }
  /// }
  /// ```
  ///
  /// ...wherein `_foo` gets nullified whenever its dependencies get mutated.
  ///
  /// Note that whereas the `obtainAssuredValue(fallback:)` is useful for properties
  /// that will always be non-`nil`--but ,say, change a lot *and* are expensive
  /// to recalculate--`obtainWeaklyAssuredValue(fallback:)` is suited for properties
  /// that *won't always be available* but will generally be "sticky" once non-nil.
  ///
  /// These show up a lot, in my experience, if you have UI-level code that walks
  /// up-or-down one of the UI hierarchies (views/view-controllers/responders, etc.).
  ///
  /// - parameter fallback: A lazily-evaluated source for a *possibly* non-`nil` value.
  ///
  /// - returns: The equivalent-of `self ?? fallback()`.
  ///
  /// - postcondition: `self != nil`.
  ///
  /// - note: A verbose name chosen *deliberately* in order to avoid colliding with "nicer" names like `assured(by:)`.
  ///
  /// - seealso: `Optional.obtainWeaklyAssuredValue(fallback:)`
  ///
  @inlinable
  mutating func obtainWeaklyAssuredValue(
    fallback: @autoclosure () -> Wrapped?
  ) -> Wrapped? {
    switch self {
    case .some(let wrapped):
      return wrapped
    case .none:
      switch fallback() {
      case .some(let wrapped):
        self = .some(wrapped)
        return wrapped
      case .none:
        return nil
      }
    }
  }
  
}
