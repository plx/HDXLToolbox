import Foundation
import Combine
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: TopLevelEncoder - Type-Erasue
// -------------------------------------------------------------------------- //

extension TopLevelEncoder {
  
  /// Obtain a type-erased wrapper around `self`.
  @inlinable
  public func erasedToAnyTopLevelEncoder() -> AnyTopLevelEncoder<Output> {
    AnyTopLevelEncoder<Output>(wrappedEncoder: self)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: AnyTopLevelEncoder
// -------------------------------------------------------------------------- //

/// Hand-written type-erasing wrapper for `TopLevelEncoder`; to be removed when/if we can write `any TopLevelEncoder<Input>`.
///
/// - Note: exist b/c `TopLevelEncoder.Output` isn't declared as a prinary associated type and, thus, `any TopLevelEncoder` isn't a workable choice.
@frozen
public struct AnyTopLevelEncoder<Output> {
  
  @usableFromInline
  internal typealias Storage = _AnyTopLevelEncoderStorage<Output>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  internal init<WrappedEncoder>(
    wrappedEncoder: WrappedEncoder
  ) where WrappedEncoder: TopLevelEncoder, WrappedEncoder.Output == Output {
    self.init(
      storage: AnyTopLevelEncoderStorage<WrappedEncoder, Output>(
        wrappedEncoder: wrappedEncoder
      )
    )
  }
  
  @inlinable
  public func encode(
    _ value: some Encodable
  ) throws -> Output {
    try storage.encode(value)
  }

}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension AnyTopLevelEncoder : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describing: storage)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension AnyTopLevelEncoder : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(storage: \(String(reflecting: storage)))"
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - _AnyTopLevelEncoderStorage
// -------------------------------------------------------------------------- //

/// Private abstract base/implementation class used as the declared `Storage` type for ``AnyTopLevelEncoder``.
///
/// - seealso: ``AnyTopLevelEncoderStorage``
@usableFromInline
internal class _AnyTopLevelEncoderStorage<Output> : CustomStringConvertible, CustomDebugStringConvertible {
  
  @inlinable
  internal init() { }
  
  @inlinable
  internal func encode<T>(_ value: T) throws -> Output where T: Encodable {
    mandatoryOverride(for: Self.self)
  }
  
  @usableFromInline
  internal var description: String {
    mandatoryOverride(for: Self.self)
  }
  
  @usableFromInline
  internal var debugDescription: String {
    mandatoryOverride(for: Self.self)
  }
}

// -------------------------------------------------------------------------- //
// MARK: - AnyTopLevelEncoderStorage
// -------------------------------------------------------------------------- //

/// The actual storage type used by `AnyTopLevelEncoder`.
@usableFromInline
internal final class AnyTopLevelEncoderStorage<WrappedEncoder, Output> : _AnyTopLevelEncoderStorage<Output>
where
  WrappedEncoder : TopLevelEncoder,
  WrappedEncoder.Output == Output
{
  
  @usableFromInline
  internal let wrappedEncoder: WrappedEncoder
  
  @inlinable
  internal init(wrappedEncoder: WrappedEncoder) {
    self.wrappedEncoder = wrappedEncoder
  }
  
  @inlinable
  override internal func encode<T>(_ value: T) throws -> Output where T: Encodable {
    try wrappedEncoder.encode(value)
  }
  
  @usableFromInline
  override internal var description: String {
    String(describing: wrappedEncoder)
  }
  
  @usableFromInline
  override internal var debugDescription: String {
    "\(String(reflecting: type(of: self)))(wrappedEncoder: \(wrappedEncoder))"
  }

}
