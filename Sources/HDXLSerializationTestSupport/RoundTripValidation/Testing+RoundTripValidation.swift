import Foundation
import Testing
import HDXLSerialization

@inlinable
public func verifyCodableRoundTrip<T, Representation>(
  codec: SerializationCodec<Representation>,
  example: T,
  function: StaticString = #function,
  sourceLocation: SourceLocation = SourceLocation()
) throws where T: Equatable, T: Codable {
  let encodedRepresentation = try codec.encode(example)
  let decodedExample = try codec.decode(
    T.self,
    from: encodedRepresentation
  )
  
  #expect(
    example == decodedExample,
    """
    Encountered round-trip failure for \(String(reflecting: T.self)):
    
    - `codec`: \(String(reflecting: codec))
    - `example`: \(String(reflecting: example))
    - `decodedExample`: \(String(reflecting: decodedExample))
    - `example`: \(String(reflecting: example))
    - `function`: \(function)
    - `moduleName: \(sourceLocation.moduleName)
    - `fileID`: \(sourceLocation.fileID)
    - `line`: \(sourceLocation.line)
    - `column`: \(sourceLocation.column)
    """,
    sourceLocation: sourceLocation
  )
}


@inlinable
public func verifyCodableRoundTrip<T, Representation>(
  codecs: some Sequence<SerializationCodec<Representation>>,
  examples: some Collection<T>,
  function: StaticString = #function,
  sourceLocation: SourceLocation = SourceLocation()
) throws where T: Equatable, T: Codable {
  for codec in codecs {
    for example in examples {
      try verifyCodableRoundTrip(
        codec: codec,
        example: example,
        function: function,
        sourceLocation: sourceLocation
      )
    }
  }
}

@inlinable
public func verifyCodableRoundTrip<T, Representation, Failure>(
  codecs: some AsyncSequence<SerializationCodec<Representation>, Failure>,
  examples: some Collection<T>,
  function: StaticString = #function,
  sourceLocation: SourceLocation = SourceLocation()
) async throws where T: Equatable, T: Codable {
  for try await codec in codecs {
    for example in examples {
      try verifyCodableRoundTrip(
        codec: codec,
        example: example,
        function: function,
        sourceLocation: sourceLocation
      )
    }
  }
}

@inlinable
public func verifyCodableRoundTripForCommonCodecs<T>(
  examples: some Collection<T>,
  function: StaticString = #function,
  sourceLocation: SourceLocation = SourceLocation()
) async throws where T: Equatable, T: Codable {
  try await verifyCodableRoundTripForJSONCodecs(
    examples: examples,
    function: function,
    sourceLocation: sourceLocation
  )
}

@inlinable
public func verifyCodableRoundTripForJSONCodecs<T>(
  examples: some Collection<T>,
  function: StaticString = #function,
  sourceLocation: SourceLocation = SourceLocation()
) async throws where T: Equatable, T: Codable {
  try await verifyCodableRoundTrip(
    codecs: SerializationCodec<Data>.representativeJSONCodecs,
    examples: examples,
    function: function,
    sourceLocation: sourceLocation
  )
}

// MARK: Async

@inlinable
public func verifyCodableRoundTrip<T, Representation, CodecFailure, ExampleFailure>(
  codecs: some AsyncSequence<SerializationCodec<Representation>, CodecFailure>,
  examples: some AsyncSequence<T, ExampleFailure>,
  function: StaticString = #function,
  sourceLocation: SourceLocation = SourceLocation()
) async throws where T: Equatable, T: Codable {
  for try await codec in codecs {
    for try await example in examples {
      try verifyCodableRoundTrip(
        codec: codec,
        example: example,
        function: function,
        sourceLocation: sourceLocation
      )
    }
  }
}

@inlinable
public func verifyCodableRoundTripForCommonCodecs<T, ExampleFailure>(
  examples: some AsyncSequence<T, ExampleFailure>,
  function: StaticString = #function,
  sourceLocation: SourceLocation = SourceLocation()
) async throws where T: Equatable, T: Codable {
  try await verifyCodableRoundTripForJSONCodecs(
    examples: examples,
    function: function,
    sourceLocation: sourceLocation
  )
}

@inlinable
public func verifyCodableRoundTripForJSONCodecs<T, ExampleFailure>(
  examples: some AsyncSequence<T, ExampleFailure>,
  function: StaticString = #function,
  sourceLocation: SourceLocation = SourceLocation()
) async throws where T: Equatable, T: Codable {
  try await verifyCodableRoundTrip(
    codecs: SerializationCodec<Data>.representativeJSONCodecs,
    examples: examples,
    function: function,
    sourceLocation: sourceLocation
  )
}

