import Foundation
import HDXLEssentialPrecursors

extension AsynchronousRepresentativeProbeProvider {
  
  @inlinable
  public func transform<R>(
    _ transformation: @escaping @Sendable (Element) async -> R
  ) -> some AsynchronousRepresentativeProbeProvider<R> {
    AsynchronousTransformingRepresentativeProbeProvider<R, Self>(
      baseProvider: self,
      transformation: transformation
    )
  }
  
}

@frozen
public struct AsynchronousTransformingRepresentativeProbeProvider<Element, BaseProvider> : AsynchronousRepresentativeProbeProvider
where BaseProvider: AsynchronousRepresentativeProbeProvider
{
  
  @usableFromInline
  internal let baseProvider: BaseProvider
  
  @usableFromInline
  internal let transformation: @Sendable (BaseProvider.Element) async -> Element
  
  @inlinable
  internal init(
    baseProvider: BaseProvider,
    transformation: @escaping @Sendable (BaseProvider.Element) async -> Element
  ) {
    self.baseProvider = baseProvider
    self.transformation = transformation
  }
  
  // TODO: determine if we do/don't need to reintroduce the onDemandMap collection
  @inlinable
  public var asynchronousRepresentativeProbes: some Sendable & AsyncSequence<Element, Never> {
    let probes = baseProvider.asynchronousRepresentativeProbes
    let transform = transformation
    
    return AsyncStream { continuation in
      Task.detached {
        defer { continuation.finish() }
        for await baseElement in probes {
          continuation.yield(await transform(baseElement))
        }
      }
    }
  }
}
