import Foundation
import Combine
// ^ just for top-level encoder

// -------------------------------------------------------------------------- //
// MARK: SerializationCodec
// -------------------------------------------------------------------------- //

/// Type-erasing wrapper around a compatible pair like `(Encoder,Decoder)`;
/// restricts the input/output type to `Data` due to lack of need that generalization.
///
/// Jointly addresses two issues: (a) reduces cluttering serialization-related
/// call sites with excessive genericity vis-a-vis their encoding/decoding and,
/// additionally, (b) uses specialized constructors (etc.) to recruit the type
/// system's help in only-ever using mutually-compatible encoder/decoder pairs.
///
@frozen
public struct SerializationCodec<Representation> {
  
  @usableFromInline
  internal var _encoder: AnyTopLevelEncoder<Representation>

  @inlinable
  public var encoder: AnyTopLevelDecoder<Representation> { _decoder }

  @usableFromInline
  internal var _decoder: AnyTopLevelDecoder<Representation>
  
  @inlinable
  public var decoder: AnyTopLevelDecoder<Representation> { _decoder }
  
  @inlinable
  internal init(
    _encoder: AnyTopLevelEncoder<Representation>,
    _decoder: AnyTopLevelDecoder<Representation>
  ) {
    self._encoder = _encoder
    self._decoder = _decoder
  }

  @inlinable
  public init<E,D>(
    encoder: E,
    decoder: D
  ) where
    E: TopLevelEncoder,
    D: TopLevelDecoder,
    E.Output == Representation,
    D.Input == Representation
  {
    self.init(
      _encoder: encoder.erasedToAnyTopLevelEncoder(),
      _decoder: decoder.erasedToAnyTopLevelDecoder()
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Primary API
// -------------------------------------------------------------------------- //

extension SerializationCodec {

  @inlinable
  public func encode(
    _ value: some Encodable
  ) throws -> Representation {
    try _encoder.encode(value)
  }
  
  @inlinable
  public func decode<T>(
    _ type: T.Type,
    from data: Representation
  ) throws -> T where T: Decodable {
    try _decoder.decode(
      type,
      from: data
    )
  }

}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension SerializationCodec : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    "SerializationCodec(encoder: \(String(describing: _encoder)), decoder: \(String(describing: _decoder)))"
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension SerializationCodec : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(encoder: \(String(reflecting: _encoder)), decoder: \(String(reflecting: _decoder)))"
  }
  
}

