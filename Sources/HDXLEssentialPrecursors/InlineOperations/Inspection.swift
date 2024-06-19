import Foundation

/// ## Inline-Inspection Utilities
///
/// The family of functions like ``inspection(of:)``, ``debugInspection(of:when:using)`` exist purely
/// to support a very narrowly-specific use case:
///
///
/// Let's say you have code with a long "stack" of guard-let  like this:
///
/// ```swift
/// func invertPolarity(
///   of shield: some Shield,
///   using modulator: some Modulator,
///   boostedVia powerSource: some PowerSource,
///   coordinatedBy computer: some ComputerSystem,
///   controlledVia device: some PersonalCommunicatorDevice
/// ) -> (some ProgramManagementHandle)? {
///   guard
///     let modulationAttachmentSite = shield.modulationAttachmentSite(
///       for: modulator
///     ),
///     let boosterAttachmentSite = shield.auxiliaryPowerInjectionSite(
///       for: powerSource
///     ),
///     let powerInjectionCoupling = PowerInjectionCoupling(
///       coupling: modulationAttachmentSite, boosterAttachmentSite
///     ),
///     let managementProgram = computer.managementProgram(
///       managing: powerInjectionCoupling
///     ),
///     managementProgram.launch()
///   else {
///     return nil
///   }
///
///   return device.managementHandle(for: managementProgram)
/// }
/// ```
///
/// Unfortunately, however, it's not working as-expected: you're giving it inputs that
/// should result in a non-nil value, but instead you're getting `nil`.
///
/// At this point, the "guard stack" syntax becomes awkward, b/c you must now choose
/// between some clunky-and-suboptimal options:
///
/// - set breakpoints and (clunkily) step through until you figure out what's going on
/// - (significantly) reorganize the code into individual conditionals, then add `print` statements (etc.)
///
///
///
/// - you're giving it inputs that should retu
///

/// Returns `value`.
///
/// Useless by itself, but makes sense in combination with `inspection(of:using:)`.
///
/// - parameter value: The value to inspect
///
/// - returns: `value`
///
/// - seealso: ``inspection(of:using:)``
/// - seealso: ``debugInspection(of:)``
/// - seealso: ``debugInspection(of:using:)``
///
@inlinable
@inline(__always)
public func inspection<T>(of value: T) -> T {
  value
}

/// Returns `value`.
///
/// Useless by itself, but makes sense in combination with `inspection(of:using:)`.
///
/// - parameter value: The value to inspect
///
/// - returns: `value`
///
/// - seealso: ``inspection(of:using:)``
/// - seealso: ``debugInspection(of:)``
/// - seealso: ``debugInspection(of:using:)``
///
@inlinable
@inline(__always)
public func inspection<T>(
  of value: T,
  when condition: @autoclosure () -> Bool,
  using inspector: (T) throws -> Void
) rethrows -> T {
  if condition() {
    try inspector(value)
  }
  
  return value
}

/// Returns `value`.
///
/// Useless by itself, but makes sense in combination with `inspection(of:using:)`.
///
/// - parameter value: The value to inspect
///
/// - returns: `value`
///
/// - seealso: ``inspection(of:using:)``
/// - seealso: ``debugInspection(of:)``
/// - seealso: ``debugInspection(of:using:)``
///
@inlinable
@inline(__always)
public func inspection<T>(
  of value: T,
  unless condition: @autoclosure () -> Bool,
  using inspector: (T) throws -> Void
) rethrows -> T {
  if !condition() {
    try inspector(value)
  }
  
  return value
}

/// A way to "get a peek" at a value w/out needing to store it into a variable.
///
/// This exists to address a recurring issue with the "functional, few-variables"
/// style of code. If your code works, it's a great style; if your code doesn't
/// work, however, it's often necessary to rewrite it in a completely-different
/// style just to make it easier to debug.
///
/// Judicious use of `inspection` and `inspection(of:using:)`, however, allow
/// you to *temporarily* add logging (etc.) *without* a full-on restructuring.
///
/// Consider a situation like this:
///
/// ```swift
/// // nice if it works:
/// return Foo(
///   bar: Bar(a,b,c),
///   baz: Baz(e,f,g),
///   quux: Quux(h,i,j)
/// )
///
/// // ...but for debugging you may prefer this:
///
/// let bar = Bar(a,b,c)
/// let baz = Baz(e,f,g)
/// let quux = Quux(h,i,j)
/// let foo = Foo(
///   bar: bar,
///   baz: baz,
///   quux: quux
/// )
///
/// print("`bar`: \(bar)")
/// print("`baz`: \(baz)")
/// print("`quux`: \(quux)")
/// print("`Foo(bar,baz,quux)`: \(foo)")
/// return foo
/// ```
///
/// An *alternative* would be to make it like this:
///
/// ```swift
/// return inspection(
///   of: Foo(
///     bar: inspection(of: Bar(a,b,c)),
///     baz: inspection(of: Baz(e,f,g)),
///     quux: inspection(of: Quux(h,i,j))
///   )
/// )
///
/// // which can become this when debugging:
/// return inspection(
///   of: Foo(
///     bar: inspection(of: Bar(a,b,c)) { print("`bar`: \($0) },
///     baz: inspection(of: Baz(e,f,g)) { print("`baz`: \($0) },
///     quux: inspection(of: Quux(h,i,j)) { print("`quux`: \($0) }
///   )
/// ) { print("`foo`: \($0)") }
/// ```
///
/// It's *verbose*, but avoids the need to restructure your code to peek at values.
///
@inlinable
@inline(__always)
public func inspection<T>(
  of value: T,
  using inspector: (T) throws -> Void
) rethrows -> T {
  try inspector(value)
  return value
}

/// Returns `value`.
///
/// Counterpart to `debugInspection(of:using:)`, and useless in isolation.
///
/// - parameter value: The value to inspect
///
/// - returns: `value`
///
/// - seealso: `inspection(of:)`
/// - seealso: `inspection(of:using:)`
/// - seealso: `debugInspection(of:using:)`
///
@inlinable
@inline(__always)
public func debugInspection<T>(of value: T) -> T {
  return value
}

/// Returns `value`.
///
/// Counterpart to `debugInspection(of:when:using:)`, and useless in isolation.
///
/// - parameter value: The value to inspect
/// - parameter condition: Unused in this method--see `debugInspection(of:unless:using:)`.
///
/// - returns: `value`
///
/// - seealso: `inspection(of:unless:)`
/// - seealso: `debugInspection(of:using:)`
/// - seealso: `debugInspection(of:when:using:)`
/// - seealso: `debugInspection(of:unless:using:)`
///
@inlinable
@inline(__always)
public func debugInspection<T>(
  of value: T,
  when condition: @autoclosure () -> Bool
) -> T {
  return value
}

/// Returns `value`.
///
/// Counterpart to `debugInspection(of:unless:using:)`, and useless in isolation.
///
/// - parameter value: The value to inspect
/// - parameter condition: Unused in this method--see `debugInspection(of:unless:using:)`.
///
/// - returns: `value`
///
/// - seealso: `inspection(of:unless:)`
/// - seealso: `debugInspection(of:using:)`
/// - seealso: `debugInspection(of:when:using:)`
/// - seealso: `debugInspection(of:unless:using:)`
///
@inlinable
@inline(__always)
public func debugInspection<T>(
  of value: T,
  unless condition: @autoclosure () -> Bool
) -> T {
  return value
}

@inlinable
@inline(__always)
public func debugInspection<T>(
  of value: T,
  using inspector: (T) -> Void) -> T {
  #if DEBUG
  inspector(value)
  #endif
  return value
}

@inlinable
@inline(__always)
public func debugInspection<T>(
  of value: T,
  when condition: @autoclosure () -> Bool,
  using inspector: (T) throws -> Void
) rethrows -> T {
#if DEBUG
  return try inspection(
    of: value,
    when: condition(),
    using: inspector
  )
#else
  return value
#endif
}

/// Returns `value` after *potentially* calling `inspector(value)` on it.
///
/// This *always* returns `value`. In `DEBUG` builds, however, it'll also call
/// `inspector(value)`, but only iff `condition()` evaluates to `false`. In a
/// non-`DEBUG` build this returns `value` and *does not* evaluate `condition`.
///
/// - parameter value: The value to inspect
/// - parameter condition: In `DEBUG` builds, evaluated to detemrine *if* we should call `inspector`.
/// - parameter inspector: The closure to call when we examine `value`.
///
/// - returns: `value`
///
/// - seealso: ``inspection(of:unless:)``
/// - seealso: ``debugInspection(of:using:)``
/// - seealso: ``debugInspection(of:when:using:)``
/// - seealso: ``debugInspection(of:unless:using:)``
///
@inlinable
@inline(__always)
public func debugInspection<T>(
  of value: T,
  unless condition: @autoclosure () -> Bool,
  using inspector: (T) throws -> Void
) rethrows -> T {
#if DEBUG
    return try inspection(
      of: value,
      unless: condition(),
      using: inspector
    )
#else
    return value
#endif
}
