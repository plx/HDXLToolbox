import Foundation

// -------------------------------------------------------------------------- //
// MARK: RepresentativeProbeProvider
// -------------------------------------------------------------------------- //

/// ``RepresentativeProbeProviding`` is analogous to ``CaseIterable`` for types that
/// *cannot* supply a collection of all possible values but *can* nevertheless provide some collection
/// of "reasonably-representative" values.
///
/// As a conceptual example, consider e.g. a hypothetical `HumanGivenName` type:
///
/// - providing "all possible" human given names isn't realistic
/// - providing a "reasonably-representative" assortment of names is doable (albeit would still require *a lot* of names, naturally)
///
/// When implementing ``RepresentativeProbeProviding``, you should aim to include some combination of:
///
/// - any particularly well-known/standard/default choices
/// - any reasonable "typical/standard" values
/// - any easily-foreseable "tricky cases" (empty collections, 'edge cases', and so on)
///
public protocol RepresentativeProbeProvider<Element> {
  
  /// The type for-which we're providing representative probes.
  associatedtype Element
  
  /// A collection of "representative values".
  associatedtype RepresentativeProbes: Collection<Element>
  
  /// The representative probes we're providing.
  var representativeProbes: RepresentativeProbes { get }
  
}
