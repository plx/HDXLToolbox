import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: ObjectWrapper
// -------------------------------------------------------------------------- //

/// A "forgetful wrapper" around some `object` that gets us to `Equatable`,
/// `Hashable`, and `Identifiable` by using object-identity:
///
/// - `==` is just `===` (e.g. "equality is identity")
/// - `hash` is just the `ObjectIdentifier(object)`'s hash
/// - `id` is just the `ObjectIdentifier(object)`
///
/// This exists *primarily* to streamline using `class` types in the standard
/// collections *without* having to implement semantically-dubious `Equatable`
/// and `Hashable` conformances directly on the type definition. In other words,
/// if your `class` is some kind of controller or delegate or coordinator, it's
/// semantically weird to implement `Equatable` and `Hashable`, it's still useful
/// to define sets of them (etc.), and this exists in service of that.
///
@frozen
public struct ObjectWrapper<T:AnyObject> {
  
  public let object: T
  
  @inlinable
  public var objectIdentifier: ObjectIdentifier {
    ObjectIdentifier(object)
  }
  
  @inlinable
  public init(object: T) {
    self.object = object
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension ObjectWrapper: Sendable where T: Sendable { }
extension ObjectWrapper: Codable where T: Codable { }

// -------------------------------------------------------------------------- //
// MARK: - Equatable
// -------------------------------------------------------------------------- //

extension ObjectWrapper : Equatable {
  
  @inlinable
  public static func == (
    lhs: ObjectWrapper<T>,
    rhs: ObjectWrapper<T>
  ) -> Bool {
    lhs.object === rhs.object
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Hashable
// -------------------------------------------------------------------------- //

extension ObjectWrapper : Hashable {
  
  @inlinable
  public func hash(into hasher: inout Hasher) {
    objectIdentifier.hash(into: &hasher)
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension ObjectWrapper : Identifiable {
  
  /// - note: *Generally* for `Hashable` types I use `Self` for `ID`, but here I want to avoid unintentionally-extending the object lifetime.
  public typealias ID = ObjectIdentifier
  
  @inlinable
  public var id: ID { objectIdentifier }
  
}

// -------------------------------------------------------------------------- //
// MARK: - CustomStringConvertible
// -------------------------------------------------------------------------- //

extension ObjectWrapper : CustomStringConvertible {

  @inlinable
  public var description: String {
    "wrapper-of \(String(describing: object))"
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: ObjectWrapper - CustomDebugStringConvertible
// -------------------------------------------------------------------------- //

extension ObjectWrapper : CustomDebugStringConvertible {
  
  @inlinable
  public var debugDescription: String {
    "ObjectWrapper<\(String(reflecting: T.self))>(object: \(String(reflecting: object)), objectIdentifier: \(String(reflecting: objectIdentifier)))"
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: ObjectWrapper - Codable
// -------------------------------------------------------------------------- //

extension ObjectWrapper : SingleValueCodable where T:Codable {
  
  public typealias SingleValueCodableRepresentation = T
  
  @inlinable
  public var singleValueCodableRepresentation: SingleValueCodableRepresentation {
    object
  }
  
  @inlinable
  public init(unsafeFromSingleValueCodableRepresentation singleValueCodableRepresentation: SingleValueCodableRepresentation) throws {
    self.init(object: singleValueCodableRepresentation)
  }
  
}
