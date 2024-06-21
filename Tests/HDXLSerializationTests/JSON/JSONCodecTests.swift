import Foundation
import Testing
import HDXLSerializationTestSupport

@testable import HDXLSerialization

// This test is *really* checking that the codecs work.
@Test(
  "JSON codecs round-trip dictionaries ok.",
  arguments: [
    [:],
    [1: "1"],
    [2: "22", 3: "333"]
  ]
)
func testJSONCodecRoundTripOnIntStringDictionaries(
  _ example: [Int: String]
) async throws {
  try await verifyCodableRoundTrip(
    codecs: SerializationCodec<Data>.representativeJSONCodecs,
    examples: [example]
  )
}
