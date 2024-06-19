import Foundation

extension RepresentativeProbeProvider {
  
  @inlinable
  public func transform<R>(_ transformation: @escaping (Element) -> R) -> some RepresentativeProbeProvider<R> {
    TransformingRepresentativeProbeProvider(
      baseProvider: self,
      transformation: transformation
    )
  }
  
}

@frozen
public struct TransformingRepresentativeProbeProvider<Element, BaseProvider> : RepresentativeProbeProvider
where BaseProvider: RepresentativeProbeProvider
{
  @usableFromInline
  internal let baseProvider: BaseProvider
  
  @usableFromInline
  internal let transformation: (BaseProvider.Element) -> Element
  
  @inlinable
  internal init(
    baseProvider: BaseProvider,
    transformation: @escaping (BaseProvider.Element) -> Element
  ) {
    self.baseProvider = baseProvider
    self.transformation = transformation
  }
  
  // TODO: determine if we do/don't need to reintroduce the onDemandMap collection
  @inlinable
  public var representativeProbes: some Collection<Element> {
    baseProvider
      .representativeProbes
      .lazy
      .map(transformation)
  }
}
