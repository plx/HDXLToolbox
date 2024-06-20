import Foundation

// -------------------------------------------------------------------------- //
// MARK: AsynchronousRepresentativeProbeProvider
// -------------------------------------------------------------------------- //

///
public protocol AsynchronousRepresentativeProbeProvider<Element> : Sendable {
  
  /// The type for-which we're providing representative probes.
  associatedtype Element
  
  /// A collection of "representative values".
  associatedtype AsynchronousRepresentativeProbes: Sendable & AsyncSequence<Element, Never>
  
  /// The representative probes we're providing.
  var asynchronousRepresentativeProbes: AsynchronousRepresentativeProbes { get }
  
}
