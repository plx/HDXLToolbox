import Foundation

// -------------------------------------------------------------------------- //
// MARK: AsynchronousRepresentativeProbeProviding
// -------------------------------------------------------------------------- //

/// ``AsynchronousRepresentativeProbeProviding`` is analogous to [`CaseIterable`](https://developer.apple.com/documentation/swift/caseiterable) for types that
/// *cannot* supply a collection of all possible values but *can* nevertheless provide some collection
/// of "reasonably-representative" values.
///
/// As a conceptual example, consider e.g. a hypothetical `HumanGivenName` type:
///
/// - providing "all possible" human given names isn't realistic
/// - providing a "reasonably-representative" assortment of names is doable (albeit would still require *a lot* of names, naturally)
///
/// When implementing ``AsynchronousRepresentativeProbeProviding``, you should aim to include some combination of:
///
/// - any particularly well-known/standard/default choices
/// - any reasonable "typical/standard" values
/// - any easily-foreseable "tricky cases" (empty collections, 'edge cases', and so on)
///
/// - seealso: `RepresentativeProbeProvider`
///
public protocol AsynchronousRepresentativeProbeProviding : Sendable {
  
  /// A collection of "representative values".
  associatedtype AsynchronousRepresentativeProbes: Sendable & AsyncSequence<Self, Never>
  
  /// Retrieves a collection of "examples useful for testing."
  ///
  /// - note: Name chosen for anlaogy with ``CaseIterable.allCases``.
  static var allAsynchronousRepresentativeProbes: AsynchronousRepresentativeProbes { get }
  
}

// -------------------------------------------------------------------------- //
// MARK: - RepresentativeProbeProviding
// -------------------------------------------------------------------------- //

extension AsynchronousRepresentativeProbeProviding where Self: RepresentativeProbeProviding  {
  
  @inlinable
  public static var allAsynchronousRepresentativeProbes: some Sendable & AsyncSequence<Self, Never> {
    AsyncStream { continuation in
      defer { continuation.finish() }
      for element in allRepresentativeProbes {
        continuation.yield(element)
      }
    }
  }
  
}
