import Foundation
import XCTest
import HDXLSerialization
import HDXLTestingSupport

// MARK: Synchronous Examples

extension XCTestCase {
  
  @inlinable
  public func validateCodableRoundTrip<T, Representation>(
    codecs: some Sequence<SerializationCodec<Representation>>,
    examples: some Collection<T>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) throws where T: Equatable, T: Codable {
    for codec in codecs {
      for example in examples {
        let encodedRepresentation = try codec.encode(example)
        let decodedExample = try codec.decode(
          T.self,
          from: encodedRepresentation
        )
        
        XCTAssertEqual(
          example,
          decodedExample,
          """
          Encountered round-trip failure for \(String(reflecting: T.self)):
          
          - `codec`: \(String(reflecting: codec))
          - `example`: \(String(reflecting: example))
          - `decodedExample`: \(String(reflecting: decodedExample))
          - `example`: \(String(reflecting: example))
          - `function`: \(function)
          - `file`: \(file)
          - `line`: \(line)
          - `column`: \(column)
          """,
          file: file,
          line: line
        )
      }
    }
  }
  
  @inlinable
  public func validateCodableRoundTrip<T, Representation, Failure>(
    codecs: some AsyncSequence<SerializationCodec<Representation>, Failure>,
    examples: some Collection<T>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) async throws where T: Equatable, T: Codable {
    for try await codec in codecs {
      for example in examples {
        let encodedRepresentation = try codec.encode(example)
        let decodedExample = try codec.decode(
          T.self,
          from: encodedRepresentation
        )
        
        XCTAssertEqual(
          example,
          decodedExample,
          """
          Encountered round-trip failure for \(String(reflecting: T.self)):
          
          - `codec`: \(String(reflecting: codec))
          - `example`: \(String(reflecting: example))
          - `decodedExample`: \(String(reflecting: decodedExample))
          - `example`: \(String(reflecting: example))
          - `function`: \(function)
          - `file`: \(file)
          - `line`: \(line)
          - `column`: \(column)
          """,
          file: file,
          line: line
        )
      }
    }
  }
  
  
  @inlinable
  public func validateCodableRoundTripForCommonCodecs<T>(
    examples: some Collection<T>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) async throws where T: Equatable, T: Codable {
    try await validateCodableRoundTripForJSONCodecs(
      examples: examples,
      function: function,
      file: file,
      line: line,
      column: column
    )
  }
  
  @inlinable
  public func validateCodableRoundTripForJSONCodecs<T>(
    examples: some Collection<T>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) async throws where T: Equatable, T: Codable {
    try await validateCodableRoundTrip(
      codecs: SerializationCodec<Data>.representativeJSONCodecs,
      examples: examples,
      function: function,
      file: file,
      line: line,
      column: column
    )
  }
  
}

// MARK: Asynchronous Examples

extension XCTestCase {
  
  @inlinable
  public func validateCodableRoundTrip<T, Representation, ExamplesFailure>(
    codecs: some Sequence<SerializationCodec<Representation>>,
    examples: @Sendable @autoclosure () -> some AsyncSequence<T, ExamplesFailure>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) async throws where T: Equatable, T: Codable {
    for codec in codecs {
      for try await example in examples() {
        let encodedRepresentation = try codec.encode(example)
        let decodedExample = try codec.decode(
          T.self,
          from: encodedRepresentation
        )
        
        XCTAssertEqual(
          example,
          decodedExample,
          """
          Encountered round-trip failure for \(String(reflecting: T.self)):
          
          - `codec`: \(String(reflecting: codec))
          - `example`: \(String(reflecting: example))
          - `decodedExample`: \(String(reflecting: decodedExample))
          - `example`: \(String(reflecting: example))
          - `function`: \(function)
          - `file`: \(file)
          - `line`: \(line)
          - `column`: \(column)
          """,
          file: file,
          line: line
        )
      }
    }
  }
  
  @inlinable
  public func validateCodableRoundTrip<T, Representation, CodecsFailure, ExamplesFailure>(
    codecs: some AsyncSequence<SerializationCodec<Representation>, CodecsFailure>,
    examples: @Sendable @autoclosure () -> some AsyncSequence<T, ExamplesFailure>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) async throws where T: Equatable, T: Codable {
    for try await codec in codecs {
      for try await example in examples() {
        let encodedRepresentation = try codec.encode(example)
        let decodedExample = try codec.decode(
          T.self,
          from: encodedRepresentation
        )
        
        XCTAssertEqual(
          example,
          decodedExample,
          """
          Encountered round-trip failure for \(String(reflecting: T.self)):
          
          - `codec`: \(String(reflecting: codec))
          - `example`: \(String(reflecting: example))
          - `decodedExample`: \(String(reflecting: decodedExample))
          - `example`: \(String(reflecting: example))
          - `function`: \(function)
          - `file`: \(file)
          - `line`: \(line)
          - `column`: \(column)
          """,
          file: file,
          line: line
        )
      }
    }
  }
    
  @inlinable
  public func validateCodableRoundTripForCommonCodecs<T, ExamplesFailure>(
    examples: @Sendable @autoclosure () -> some AsyncSequence<T, ExamplesFailure>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) async throws where T: Equatable, T: Codable {
    try await validateCodableRoundTripForJSONCodecs(
      examples: examples(),
      function: function,
      file: file,
      line: line,
      column: column
    )
  }
  
  @inlinable
  public func validateCodableRoundTripForJSONCodecs<T, ExamplesFailure>(
    examples: @Sendable @autoclosure () -> some AsyncSequence<T, ExamplesFailure>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) async throws where T: Equatable, T: Codable {
    try await validateCodableRoundTrip(
      codecs: SerializationCodec<Data>.representativeJSONCodecs,
      examples: examples(),
      function: function,
      file: file,
      line: line,
      column: column
    )
  }
 
  @inlinable
  public func validateCodableRoundTripForCommonCodecs<T>(
    representativeProbeProvider: some AsynchronousRepresentativeProbeProvider<T>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) async throws where T: Equatable, T: Codable {
    try await validateCodableRoundTripForJSONCodecs(
      examples: representativeProbeProvider.asynchronousRepresentativeProbes,
      function: function,
      file: file,
      line: line,
      column: column
    )
  }
  
  @inlinable
  public func validateCodableRoundTripForJSONCodecs<T>(
    representativeProbeProvider: some AsynchronousRepresentativeProbeProvider<T>,
    function: StaticString = #function,
    file: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
  ) async throws where T: Equatable, T: Codable {
    try await validateCodableRoundTrip(
      codecs: SerializationCodec<Data>.representativeJSONCodecs,
      examples: representativeProbeProvider.asynchronousRepresentativeProbes,
      function: function,
      file: file,
      line: line,
      column: column
    )
  }

}
