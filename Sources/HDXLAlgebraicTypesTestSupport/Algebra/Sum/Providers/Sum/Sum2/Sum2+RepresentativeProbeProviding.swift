import HDXLEssentialPrecursors
import HDXLTestingSupport
import HDXLAlgebraicTypes
import HDXLUtilityCollections

extension Sum2: @retroactive RepresentativeProbeProviding
where
A: RepresentativeProbeProviding,
B: RepresentativeProbeProviding
{
  
  @inlinable
  public static var allRepresentativeProbes: some Collection<Self> {
    ChainCollection(
      A.allRepresentativeProbes
        .localOnDemandMap(Self.a),
      B.allRepresentativeProbes
        .localOnDemandMap(Self.b)
    )
  }
  
}

