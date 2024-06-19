import Foundation
import Combine
import HDXLEssentialPrecursors

extension TopLevelDecoder {
  
  @inlinable
  public func erasedToAnyTopLevelDecoder() -> AnyTopLevelDecoder<Input> {
    AnyTopLevelDecoder<Input>(wrappedDecoder: self)
  }
  
}

@frozen
public struct AnyTopLevelDecoder<Input> {
  
  @usableFromInline
  internal typealias Storage = _AnyTopLevelDecoderStorage<Input>
  
  @usableFromInline
  internal var storage: Storage
  
  @inlinable
  internal init(storage: Storage) {
    self.storage = storage
  }
  
  @inlinable
  internal init<WrappedDecoder>(
    wrappedDecoder: WrappedDecoder
  ) where WrappedDecoder: TopLevelDecoder, WrappedDecoder.Input == Input {
    self.init(
      storage: AnyTopLevelDecoderStorage<WrappedDecoder, Input>(
        wrappedDecoder: wrappedDecoder
      )
    )
  }
 
  @inlinable
  public func decode<T>(
    _ type: T.Type,
    from input: Input
  ) throws -> T where T: Decodable {
    try storage.decode(
      type,
      from: input
    )
  }

}

extension AnyTopLevelDecoder : CustomStringConvertible {
  
  @inlinable
  public var description: String {
    String(describing: storage)
  }
  
}

extension AnyTopLevelDecoder : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "\(String(reflecting: Self.self))(storage: \(String(reflecting: storage)))"
  }
  
}


@usableFromInline
internal class _AnyTopLevelDecoderStorage<Input> : CustomStringConvertible, CustomDebugStringConvertible {
  
  @inlinable
  internal init() { }
  
  @inlinable
  internal func decode<T>(
    _ type: T.Type,
    from input: Input
  ) throws -> T where T: Decodable {
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

@usableFromInline
internal final class AnyTopLevelDecoderStorage<WrappedDecoder, Input> : _AnyTopLevelDecoderStorage<Input>
where
WrappedDecoder : TopLevelDecoder,
WrappedDecoder.Input == Input
{
  
  @usableFromInline
  internal let wrappedDecoder: WrappedDecoder
  
  @inlinable
  internal init(wrappedDecoder: WrappedDecoder) {
    self.wrappedDecoder = wrappedDecoder
  }
  
  @inlinable
  override internal func decode<T>(
    _ type: T.Type,
    from input: Input
  ) throws -> T where T: Decodable {
    try wrappedDecoder.decode(
      type,
      from: input
    )
  }
  
  @usableFromInline
  override internal var description: String {
    String(describing: wrappedDecoder)
  }
  
  @usableFromInline
  override internal var debugDescription: String {
    "\(String(reflecting: type(of: self)))(wrappedDecoder: \(wrappedDecoder))"
  }
  
}
