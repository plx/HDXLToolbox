import HDXLEssentialPrecursors
import HDXLTestingSupport
import HDXLAlgebraicTypes
import HDXLUtilityCollections

@frozen
public struct Sum2RepresentativeProbeProvider<
  A, AProvider,
  B, BProvider
> : RepresentativeProbeProvider 
where
AProvider: RepresentativeProbeProvider<A>,
BProvider: RepresentativeProbeProvider<B>
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
  public var representativeProbes: some Collection<Element> {
    ChainCollection(
      aProvider
        .representativeProbes
        .localOnDemandMap(Element.a),
      bProvider
        .representativeProbes
        .localOnDemandMap(Element.b)
    )
  }
}
