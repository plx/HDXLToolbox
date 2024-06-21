import Foundation
import HDXLEssentialPrecursors

@usableFromInline
internal typealias CollectionStorage<Base> = SequenceStorage<Base> where Base: Collection

@usableFromInline
@propertyWrapper
internal struct SequenceStorage<Base> where Base: Sequence {

  @usableFromInline
  internal var wrappedValue: Base {
    didSet {
      _count = nil
    }
  }
  
  @usableFromInline
  internal var _count: Int? = nil

  @inlinable
  internal var projectedValue: Self { self }
  
  @inlinable
  internal init(wrappedValue: Base) {
    self.wrappedValue = wrappedValue
  }
  
}

extension SequenceStorage: Sendable where Base: Sendable { }
extension SequenceStorage: Equatable where Base: Equatable { }
extension SequenceStorage: Hashable where Base: Hashable { }
extension SequenceStorage: Encodable where Base: Encodable { }
extension SequenceStorage: Decodable where Base: Decodable { }

extension SequenceStorage where Base: Collection {
  
  @inlinable
  internal var count: Int {
    mutating get {
      _count.obtainAssuredValue(
        fallback: wrappedValue.count
      )
    }
  }

}
