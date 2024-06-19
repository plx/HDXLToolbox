import Foundation

extension RepresentativeProbeProviding {
  
  @inlinable
  public static var representativeProbeProvider: some RepresentativeProbeProvider<Self> {
    StaticRepresentativeProbeProvider(forType: Self.self)
  }
  
}
