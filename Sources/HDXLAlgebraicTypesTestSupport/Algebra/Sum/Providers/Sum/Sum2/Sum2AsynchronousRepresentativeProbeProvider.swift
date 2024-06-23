import HDXLEssentialPrecursors
import HDXLTestingSupport
import HDXLAlgebraicTypes
import HDXLUtilityCollections

@frozen
public struct Sum2AsynchronousRepresentativeProbeProvider<
  A, AProvider,
  B, BProvider
> : AsynchronousRepresentativeProbeProvider
where
AProvider: AsynchronousRepresentativeProbeProvider<A>,
BProvider: AsynchronousRepresentativeProbeProvider<B>
{
  
  public typealias Element = Sum2<A, B>
  
  @usableFromInline
  internal let aProvider: AProvider
  
  @usableFromInline
  internal let bProvider: BProvider
  
  @inlinable
  internal init(
    _ aProvider: AProvider,
    _ bProvider: BProvider
  ) {
    self.aProvider = aProvider
    self.bProvider = bProvider
  }
  
  @inlinable
  public var asynchronousRepresentativeProbes: some Sendable & AsyncSequence<Element, Never> {
    AsyncStream { continuation in
      Task {
        defer { continuation.finish() }
        for await a in aProvider.asynchronousRepresentativeProbes {
          continuation.yield(.a(a))
        }
        for await b in bProvider.asynchronousRepresentativeProbes {
          continuation.yield(.b(b))
        }
      }
    }
  }
}
