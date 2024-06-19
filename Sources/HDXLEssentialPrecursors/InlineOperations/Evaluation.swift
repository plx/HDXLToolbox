import Foundation

/// Transparently calls `closure`.
///
/// Exists b/c *in some cases* I think this is more-readable, e.g.:
///
/// ```swift
/// // this is OK:
/// let foo = {
///   /* some long-ish code here*/
/// }()
///
/// // but sometimes this reads easier:
/// let foo = evaluate {
///   /* some long-ish code here*/
/// }
/// ```
///
@inlinable
@inline(__always)
public func evaluate<T>(_ closure: () throws -> T) rethrows -> T {
  try closure()
}

/// Transparently calls `closure`.
///
/// Exists b/c *in some cases* I think this is more-readable, e.g.:
///
/// ```swift
/// // this is OK:
/// let foo = await {
///   /* some long-ish code here*/
/// }()
///
/// // but sometimes this reads easier:
/// let foo = await evaluate {
///   /* some long-ish code here*/
/// }
/// ```
///
@inlinable
@inline(__always)
public func evaluate<T>(_ closure: () async throws -> T) async rethrows -> T {
  try await closure()
}
