import Foundation

// -------------------------------------------------------------------------- //
// MARK: StaticRepresentativeProbeProvider
// -------------------------------------------------------------------------- //

@frozen
public struct StaticRepresentativeProbeProvider<Element> where Element: RepresentativeProbeProviding {
  
  @inlinable
  package init(forType type: Element.Type) { }
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension StaticRepresentativeProbeProvider : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "representative-probes for: \(String(describing: Element.self))"
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension StaticRepresentativeProbeProvider : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(reflecting: Self.self)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - RepresentativeProbeProvider
// -------------------------------------------------------------------------- //

extension StaticRepresentativeProbeProvider: RepresentativeProbeProvider {

  public typealias RepresentativeProbes = Element.RepresentativeProbes
  
  @inlinable
  public var representativeProbes: RepresentativeProbes {
    Element.allRepresentativeProbes
  }
}
