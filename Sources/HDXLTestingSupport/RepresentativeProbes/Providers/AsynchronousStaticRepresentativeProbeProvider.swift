import Foundation

// -------------------------------------------------------------------------- //
// MARK: AsynchronousRepresentativeProbeProviding
// -------------------------------------------------------------------------- //

extension AsynchronousRepresentativeProbeProviding {
  
  @inlinable
  public static var asynchronousRepresentativeProbeProvider: some AsynchronousRepresentativeProbeProvider<Self> {
    AsynchronousStaticRepresentativeProbeProvider(forType: Self.self)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AsynchronousStaticRepresentativeProbeProvider
// -------------------------------------------------------------------------- //

@frozen
public struct AsynchronousStaticRepresentativeProbeProvider<Element> where Element: AsynchronousRepresentativeProbeProviding {
  
  @inlinable
  package init(forType type: Element.Type) { }
}

extension AsynchronousStaticRepresentativeProbeProvider: Sendable { }

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension AsynchronousStaticRepresentativeProbeProvider : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "representative-probes for: \(String(describing: Element.self))"
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension AsynchronousStaticRepresentativeProbeProvider : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    String(reflecting: Self.self)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - RepresentativeProbeProvider
// -------------------------------------------------------------------------- //

extension AsynchronousStaticRepresentativeProbeProvider: AsynchronousRepresentativeProbeProvider {

  public typealias AsynchronousRepresentativeProbes = Element.AsynchronousRepresentativeProbes
  
  @inlinable
  public var asynchronousRepresentativeProbes: AsynchronousRepresentativeProbes {
    Element.allAsynchronousRepresentativeProbes
  }
}
