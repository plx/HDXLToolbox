import HDXLEssentialPrecursors
import HDXLTestingSupport
import HDXLAlgebraicTypes
import HDXLUtilityCollections

@frozen
public struct Sum8AsynchronousRepresentativeProbeProvider<
  A, AProvider,
  B, BProvider,
  C, CProvider,
  D, DProvider,
  E, EProvider,
  F, FProvider,
  G, GProvider,
  H, HProvider
> : AsynchronousRepresentativeProbeProvider
where
AProvider: AsynchronousRepresentativeProbeProvider<A>,
BProvider: AsynchronousRepresentativeProbeProvider<B>,
CProvider: AsynchronousRepresentativeProbeProvider<C>,
DProvider: AsynchronousRepresentativeProbeProvider<D>,
EProvider: AsynchronousRepresentativeProbeProvider<E>,
FProvider: AsynchronousRepresentativeProbeProvider<F>,
GProvider: AsynchronousRepresentativeProbeProvider<G>,
HProvider: AsynchronousRepresentativeProbeProvider<H>
{
  public typealias Element = Sum8<
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H
  >
  
  @usableFromInline
  internal let aProvider: AProvider
  
  @usableFromInline
  internal let bProvider: BProvider
  
  @usableFromInline
  internal let cProvider: CProvider
  
  @usableFromInline
  internal let dProvider: DProvider
  
  @usableFromInline
  internal let eProvider: EProvider
  
  @usableFromInline
  internal let fProvider: FProvider
  
  @usableFromInline
  internal let gProvider: GProvider
  
  @usableFromInline
  internal let hProvider: HProvider
    
  @inlinable
  internal init(
    _ aProvider: AProvider,
    _ bProvider: BProvider,
    _ cProvider: CProvider,
    _ dProvider: DProvider,
    _ eProvider: EProvider,
    _ fProvider: FProvider,
    _ gProvider: GProvider,
    _ hProvider: HProvider
  ) {
    self.aProvider = aProvider
    self.bProvider = bProvider
    self.cProvider = cProvider
    self.dProvider = dProvider
    self.eProvider = eProvider
    self.fProvider = fProvider
    self.gProvider = gProvider
    self.hProvider = hProvider
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
        for await c in cProvider.asynchronousRepresentativeProbes {
          continuation.yield(.c(c))
        }
        for await d in dProvider.asynchronousRepresentativeProbes {
          continuation.yield(.d(d))
        }
        for await e in eProvider.asynchronousRepresentativeProbes {
          continuation.yield(.e(e))
        }
        for await f in fProvider.asynchronousRepresentativeProbes {
          continuation.yield(.f(f))
        }
        for await g in gProvider.asynchronousRepresentativeProbes {
          continuation.yield(.g(g))
        }
        for await h in hProvider.asynchronousRepresentativeProbes {
          continuation.yield(.h(h))
        }
      }
    }
  }
}

