import Foundation
import Testing
import HDXLSerializationTestSupport

@testable import HDXLSerialization

@Test(
  "JSONSerializationConfiguration serializes ok."
)
func testJSONSerializationConfigurationSerializesOK() async throws {
  try await verifyCodableRoundTrip(
    codecs: SerializationCodec<Data>.representativeJSONCodecs,
    examples: JSONSerializationConfiguration.allAsynchronousRepresentativeProbes
  )
}
