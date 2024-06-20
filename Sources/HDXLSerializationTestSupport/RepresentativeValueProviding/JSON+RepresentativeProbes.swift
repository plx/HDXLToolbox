import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport
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

extension JSONSerializationConfiguration: @retroactive AsynchronousRepresentativeProbeProviding {
  
  public static var allAsynchronousRepresentativeProbes: some Sendable & AsyncSequence<Self, Never> {
    transformedAsynchronousCartesianProduct(
      JSONSerializationKeyStrategy.allRepresentativeProbes.erasedToAsyncSequence(),
      JSONSerializationDateStrategy.allRepresentativeProbes.erasedToAsyncSequence(),
      JSONSerializationDataStrategy.allRepresentativeProbes.erasedToAsyncSequence(),
      JSONSerializationNonConformingFloatStrategy.allRepresentativeProbes.erasedToAsyncSequence(),
      JSONSerializationFormatOptions.allRepresentativeProbes.erasedToAsyncSequence()
    ) {
      (keyStrategy, dateStrategy, dataStrategy, nonConformingFloatStrategy, formatOptions)
      in
      JSONSerializationConfiguration(
        keyStrategy: keyStrategy,
        dateStrategy: dateStrategy,
        dataStrategy: dataStrategy,
        nonConformingFloatStrategy: nonConformingFloatStrategy,
        formatOptions: formatOptions
      )
    }
  }
  
}

extension SerializationCodec<Data> {
  
  @inlinable
  public static var representativeJSONCodecs: some Sendable & AsyncSequence<Self, Never> {
    JSONSerializationConfiguration
      .asynchronousRepresentativeProbeProvider
      .transform { configuration in
        SerializationCodec(
          jsonSerializationConfiguration: configuration
        )
      }.asynchronousRepresentativeProbes
  }
  
}
