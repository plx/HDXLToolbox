import HDXLEssentialPrecursors
import HDXLTestingSupport
import HDXLAlgebraicTypes
import HDXLUtilityCollections

extension Sum8: @retroactive RepresentativeProbeProviding
where
A: RepresentativeProbeProviding,
B: RepresentativeProbeProviding,
C: RepresentativeProbeProviding,
D: RepresentativeProbeProviding,
E: RepresentativeProbeProviding,
F: RepresentativeProbeProviding,
G: RepresentativeProbeProviding,
H: RepresentativeProbeProviding
{
  
  @inlinable
  public static var allRepresentativeProbes: some Collection<Self> {
    ChainCollection(
      A.allRepresentativeProbes
        .localOnDemandMap(Self.a),
      B.allRepresentativeProbes
        .localOnDemandMap(Self.b),
      C.allRepresentativeProbes
        .localOnDemandMap(Self.c),
      D.allRepresentativeProbes
        .localOnDemandMap(Self.d),
      E.allRepresentativeProbes
        .localOnDemandMap(Self.e),
      F.allRepresentativeProbes
        .localOnDemandMap(Self.f),
      G.allRepresentativeProbes
        .localOnDemandMap(Self.g),
      H.allRepresentativeProbes
        .localOnDemandMap(Self.h)
    )
  }
  
}

