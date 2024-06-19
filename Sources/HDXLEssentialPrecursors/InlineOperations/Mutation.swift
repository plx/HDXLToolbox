import Foundation

// MARK: `mutation(of:using:)`

/// Returns the result of mutating a copy of `value` using `work`.
///
/// In other words, this encapsulates the "copy, mutate, use" pattern.
///
/// ```swift
/// // instead of this:
/// var target = original
/// target.foo = bar
/// target.baz = quux
///
/// // you can do this:
/// let target = mutation(of: original) {
///   $0.foo = bar
///   $0.baz = quux
/// }
/// ```
///
/// ...where it's helpful to do so.
///
/// - parameter value: The value that serves as a starting point for your mutations.
/// - parameter work: A closure to be applied-to the copy of `value` you're mutating.
///
/// - returns: The result of mutating a *copy* of `value` using `work`.
///
/// - note: For *value types* this does mutate a copy. For *reference* types this mutates the original--sometimes that's ok, just be aware of what you're doing.
///
/// - seealso: ``CloneableReference``.
///
@inlinable
public func mutation<T>(
  of value: T,
  using work: (inout T) throws -> Void
) rethrows -> T {
  var v = value
  try work(&v)
  return v
}

/// Returns the result of mutating a copy of `value` using `work`.
///
/// In other words, this encapsulates the "copy, mutate, use" pattern.
///
/// ```swift
/// // instead of this:
/// var target = original
/// target.foo = bar
/// target.baz = quux
///
/// // you can do this:
/// let target = mutation(of: original) {
///   $0.foo = bar
///   $0.baz = quux
/// }
/// ```
///
/// ...where it's helpful to do so.
///
/// - parameter value: The value that serves as a starting point for your mutations.
/// - parameter work: A closure to be applied-to the copy of `value` you're mutating.
///
/// - returns: The result of mutating a *copy* of `value` using `work`.
///
/// - note: For *value types* this does mutate a copy. For *reference* types this mutates the original--sometimes that's ok, just be aware of what you're doing.
///
/// - seealso: ``CloneableReference``.
///
@inlinable
public func mutation<T>(
  of value: T,
  using work: (inout T) async throws -> Void
) async rethrows -> T {
  var v = value
  try await work(&v)
  return v
}

/// Extracts a value from `value` while also potentially mutating `value`.
///
/// Note that (a) `extractor` can mutate `value` and (b) we make no attempt,
/// whatsoever, to guard against leaving `value` in a "half-mutated" state. In
/// other words, if your extractor has 2 steps, step 1 succeeds, but an error is
/// thrown during step 2, then `value` is going to have step 1 applied but perhaps
/// not step 2.
///
/// If you need to guard against, you can use `revertingMutatingExtraction(from:using:)`.
///
/// - parameter value: The value from-which we extract our result.
/// - parameter extractor: The closure with-which we attempt to extract our result.
///
/// - returns: The value extracted-from `value.`
/// - throws: Will `rethrow` any errors thrown-by `extractor`.
///
/// - seealso: ``revertingMutatingExtraction(from:using:)``
///
@inlinable
public func mutatingExtraction<T,R>(
  from value: inout T,
  using extractor: (inout T) throws -> R
) rethrows -> R {
  return try extractor(&value)
}


/// Attempts to extract a value from `value` while also *potentially* mutating
/// `value`; will only *apply* mutations to `value` iff `extractor` produces a
/// value without throwing.
///
/// In greater detail, this function (1) gets a copy of `value`, (2) attempts to
/// extract a value from that copy, and then either (3.a) replaces `value` with
/// that mutated copy *and* returns the extracted value or (3.b) leaves `value`
/// unchanged and rethrows the error thrown-by `extractor`.
///
/// - parameter value: The source from-which to extract our value.
/// - parameter extractor: Close with-which we extract our value.
///
/// - returns: The extracted value.
/// - throws: This rethrows whatever `extractor` throws.
///
/// - invariant: Either (a) `extractor` completes, `value` is mutated, and we return an `R` or (b) `extractor` throws and `value` is unchanged.
///
/// - seealso: ``mutatingExtraction(from:using:)``
///
@inlinable
public func revertingMutatingExtraction<T,R>(
  from value: inout T,
  using extractor: (inout T) throws -> R
) rethrows -> R {
  var result = value
  let output = try extractor(&result)
  value = result
  return output
}

