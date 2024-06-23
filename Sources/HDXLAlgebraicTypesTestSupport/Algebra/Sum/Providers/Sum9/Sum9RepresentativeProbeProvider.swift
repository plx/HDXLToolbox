import HDXLEssentialPrecursors
import HDXLTestingSupport
import HDXLAlgebraicTypes
import HDXLUtilityCollections

@frozen
public struct Sum9RepresentativeProbeProvider<
  A, AProvider,
  B, BProvider,
  C, CProvider,
  D, DProvider,
  E, EProvider,
  F, FProvider,
  G, GProvider,
  H, HProvider,
  I, IProvider
> : RepresentativeProbeProvider
where
AProvider: RepresentativeProbeProvider<A>,
BProvider: RepresentativeProbeProvider<B>,
CProvider: RepresentativeProbeProvider<C>,
DProvider: RepresentativeProbeProvider<D>,
EProvider: RepresentativeProbeProvider<E>,
FProvider: RepresentativeProbeProvider<F>,
GProvider: RepresentativeProbeProvider<G>,
HProvider: RepresentativeProbeProvider<H>,
IProvider: RepresentativeProbeProvider<I>
{
  
  public typealias Element = Sum9<
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I
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

  @usableFromInline
  internal let iProvider: IProvider

  @inlinable
  internal init(
    _ aProvider: AProvider,
    _ bProvider: BProvider,
    _ cProvider: CProvider,
    _ dProvider: DProvider,
    _ eProvider: EProvider,
    _ fProvider: FProvider,
    _ gProvider: GProvider,
    _ hProvider: HProvider,
    _ iProvider: IProvider
  ) {
    self.aProvider = aProvider
    self.bProvider = bProvider
    self.cProvider = cProvider
    self.dProvider = dProvider
    self.eProvider = eProvider
    self.fProvider = fProvider
    self.gProvider = gProvider
    self.hProvider = hProvider
    self.iProvider = iProvider
  }
  
  @inlinable
  public var representativeProbes: some Collection<Element> {
    ChainCollection(
      aProvider
        .representativeProbes
        .localOnDemandMap(Element.a),
      bProvider
        .representativeProbes
        .localOnDemandMap(Element.b),
      cProvider
        .representativeProbes
        .localOnDemandMap(Element.c),
      dProvider
        .representativeProbes
        .localOnDemandMap(Element.d),
      eProvider
        .representativeProbes
        .localOnDemandMap(Element.e),
      fProvider
        .representativeProbes
        .localOnDemandMap(Element.f),
      gProvider
        .representativeProbes
        .localOnDemandMap(Element.g),
      hProvider
        .representativeProbes
        .localOnDemandMap(Element.h),
      iProvider
        .representativeProbes
        .localOnDemandMap(Element.i)
    )
  }
}
