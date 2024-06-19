import Foundation
import HDXLEssentialPrecursors
import HDXLSerialization
import HDXLTestingSupport

extension JSONSerializationDataStrategy : @retroactive RepresentativeProbeProviding { }
extension JSONSerializationKeyStrategy : @retroactive RepresentativeProbeProviding { }
extension JSONSerializationDateStrategy: @retroactive RepresentativeProbeProviding { }
extension JSONSerializationFormatOptions: @retroactive RepresentativeProbeProviding { }
extension NonConformingFloatMapping: @retroactive RepresentativeProbeProviding {
  
  public static let allRepresentativeProbes: [NonConformingFloatMapping] = evaluate {
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

