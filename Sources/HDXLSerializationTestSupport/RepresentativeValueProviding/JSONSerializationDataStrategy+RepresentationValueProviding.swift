import Foundation
import HDXLEssentialPrecursors
import HDXLSerialization
import HDXLTestingSupport

extension JSONSerializationDataStrategy : @retroactive RepresentativeProbeProviding { }
extension JSONSerializationKeyStrategy : @retroactive RepresentativeProbeProviding { }
extension JSONSerializationDateStrategy: @retroactive RepresentativeProbeProviding { }
extension JSONSerializationFormatOptions: @retroactive RepresentativeProbeProviding { }
extension JSONSerializationNonConformingFloatStrategy: @retroactive RepresentativeProbeProviding {
  
  public static let allRepresentativeProbes: [Self] = evaluate {
    var result: [Self] = [.throw]
    result.append(
      contentsOf: NonConformingFloatMapping
        .allRepresentativeProbes
        .onDemandMap {
          .convertToString($0)
        }
    )
    
    return result
  }

}

extension NonConformingFloatMapping: @retroactive RepresentativeProbeProviding {
  
  public static let allRepresentativeProbes: [Self] = evaluate {
    var result: [NonConformingFloatMapping] = []
    
    for positiveInfinity in ["∞", "+∞", "inf", "+inf"] {
      for negativeInfinity in ["-∞", "-inf"] {
        for nan in ["nan", "NaN", "NAN"] {
          result.append(
            NonConformingFloatMapping(
              positiveInfinity: positiveInfinity,
              negativeInfinity: negativeInfinity,
              nan: nan
            )
          )
        }
      }
    }
    
    return result
  }
}

extension JSONSerializationConfiguration: @retroactive RepresentativeProbeProviding {
  
  public static let allRepresentativeProbes: [Self] = [Self].transformedCartesianProduct(
    JSONSerializationKeyStrategy.allRepresentativeProbes,
    JSONSerializationDateStrategy.allRepresentativeProbes,
    JSONSerializationDataStrategy.allRepresentativeProbes,
    JSONSerializationNonConformingFloatStrategy.allRepresentativeProbes,
    JSONSerializationFormatOptions.allRepresentativeProbes,
    Self.init(keyStrategy:dateStrategy:dataStrategy:nonConformingFloatStrategy:formatOptions:)
  )
}
