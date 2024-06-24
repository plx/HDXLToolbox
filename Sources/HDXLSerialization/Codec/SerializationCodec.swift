import Foundation
import Combine
import HDXLEssentialPrecursors
import HDXLEssentialMacros
// ^ just for top-level encoder

// -------------------------------------------------------------------------- //
// MARK: SerializationCodec
// -------------------------------------------------------------------------- //

/// Type-erasing wrapper around a mutually-compatible  `Encoder` and `Decoder`.
///
/// This exists for two purposes:
///
/// 1. recruiting the type system to help us use consistent serialization configurations
/// 2. improved ergonomics when declaring and implementing serialization-related code
///
@frozen
@ConstructorDebugDescription
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
  @PreferredMemberwiseInitializer
  internal init(
    _encoder: AnyTopLevelEncoder<Representation>,
    _decoder: AnyTopLevelDecoder<Representation>
  ) {
    self._encoder = _encoder
    self._decoder = _decoder
  }

  /// Constructs a codec from the user-supplied, mutually-compatible `encoder` and `decoder`.
  ///
  /// - Parameters:
  ///   - encoder: the `Encoder` side of this codec
  ///   - decoder: the `Decoder` side of this codec
  ///
  /// - Precondition: `encoder` and `decoder` *must* be mutually-compatible
  /// - Warning: we cannot statically verify the compatibility of`encoder` and `decoder`
  ///
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

  /// Uses `encoder` to (attempt to) encode `value`.
  @inlinable
  public func encode(
    _ value: some Encodable
  ) throws -> Representation {
    try _encoder.encode(value)
  }
  
  /// Uses `decoder` to (attempt to) decode a value of type `type` from some previously-encoded `representation`.
  @inlinable
  public func decode<T>(
    _ type: T.Type,
    from representation: Representation
  ) throws -> T where T: Decodable {
    try _decoder.decode(
      type,
      from: representation
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
