import Foundation

/// Returns `value`, but *demoted* to an optional.
///
/// ## Motivation
///
/// The motivation is to avoid breaking up logic that *could otherwise have been*
/// written entirely as a single sequential chain within a `guard` statement.
///
/// For example, let's say you wanted to write this:
///
/// ```swift
/// guard
///   let foo = item(at: indexPath) as? ItemType,                       // ok b/c `item(at: indexPath) as? ItemType` has type `ItemType?`
///   let delegate = foo.delegate,                                      // ok b/c "foo.delegate" has type `FooDelegate?`
///   let disposition = delegate.disposition(for: foo, towards: probe)  // *not ok* b/c `disposition` has type `Disposition`
///   disposition.isCompatible(with: currentCircumstances),             // ok b/c `disposition.isCompatible(with:)` has type `Bool`
///   let response = foo.handle(probe: probe, disposition: disposition) // ok b/c response is `Response?`
/// else {
///   return false
/// }
///
/// return response.isSuccess
/// ```
///
/// ...but couldn't, b/c `delegate.disposition(for:towards:)` returns a non-optional `Disposition`.
///
/// You could break this chain up into two distinct steps...or you could use `capture(of:)`, instead, like so:
///
/// ```swift
/// guard
///   let foo = item(at: indexPath) as? ItemType,                                    // ok b/c `item(at: indexPath) as? ItemType` has type `ItemType?`
///   let delegate = foo.delegate,                                                   // ok b/c "foo.delegate" has type `FooDelegate?`
///   let disposition = capture(of: delegate.disposition(for: foo, towards: probe)), // ok b/c `capture(of:)` has type `Disposition?` here
///   disposition.isCompatible(with: currentCircumstances),                          // ok b/c `disposition.isCompatible(with:)` has type `Bool`
///   let response = foo.handle(probe: probe, disposition: disposition)              // ok b/c response is `Response?`
/// else {
///   return false
/// }
///
/// return response.isSuccess
/// ```
@inlinable
public func capture<T>(of value: T) -> T? {
  value
}

