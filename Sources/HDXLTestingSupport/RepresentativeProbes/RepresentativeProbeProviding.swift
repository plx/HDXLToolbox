import Foundation

// -------------------------------------------------------------------------- //
// MARK: RepresentativeProbeProviding
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
/// - seealso: `RepresentativeProbeProvider`
///
public protocol RepresentativeProbeProviding {

  /// A collection of "representative values".
  associatedtype RepresentativeProbes: Collection<Self>

  /// Retrieves a collection of "examples useful for testing."
  ///
  /// - note: Name chosen for anlaogy with ``CaseIterable.allCases``.
  static var allRepresentativeProbes: RepresentativeProbes { get }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CaseIterable
// -------------------------------------------------------------------------- //

extension RepresentativeProbeProviding where Self: CaseIterable, RepresentativeProbes == AllCases  {
    
  @inlinable
  public static var allRepresentativeProbes: RepresentativeProbes { allCases }
  
}
