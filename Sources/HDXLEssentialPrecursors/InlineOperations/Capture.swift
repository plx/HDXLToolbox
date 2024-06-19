import Foundation

///
/// The motivation is to avoid needing to break up logic that *could otherwise have been*
/// written entirely as a single sequential guard-let chain, e.g.:
///
/// ```swift
/// // we'd like to write this, but can't, b/c some steps are non-optional:
/// guard
///   let foo = item(at: indexPath) as? ItemType,                       // ok b/c `item(at: indexPath) as? ItemType` has type `ItemType?`
///   let delegate = foo.delegate,                                      // ok b/c "foo.delegate" has type `FooDelegate?`
///   let disposition = delegate.disposition(for: foo, towards: probe)  // *not ok* b/c `disposition` has type `Disposition`
///   let response = foo.handle(probe: probe, disposition: disposition) // ok b/c response is `Response?`
/// else {
///   return false
/// }
///
/// return response.isSuccess
/// ```
///
/// ...but we *can* write it that way, if we want, by instead writing the problematic line like this:
///
/// ```swift
/// let disposition = capture(of: delegate.disposition(for: foo, towards: probe))
/// ```
///
/// There's a trade-off here:
///
/// - nice: we can write a lot more code as straight-line chains within a guard block
/// - not-nice: it's a bit clunky and also non-obvious
@inlinable
public func capture<T>(of value: T) -> T? {
  value
}

