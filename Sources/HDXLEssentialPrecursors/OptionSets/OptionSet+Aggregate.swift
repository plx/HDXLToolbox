import Foundation

extension OptionSet {
  
  @inlinable
  public init(withUnionOf values: Self...) {
    self.init(withUnionOf: values)
  }

  @inlinable
  public init(withUnionOf values: some Sequence<Self>) {
    self.init()
    self.formUnion(with: values)
  }

  @inlinable
  public mutating func formUnion(with others: some Sequence<Self>) {
    for other in others {
      formUnion(other)
    }
  }

  @inlinable
  public func union(with others: some Sequence<Self>) -> Self {
    return mutation(of: self) { $0.formUnion(with: others)}
  }

  @inlinable
  public mutating func formIntersection(with others: some Sequence<Self>) {
    for other in others {
      formIntersection(other)
    }
  }
  
  @inlinable
  public func intersection(with others: some Sequence<Self>) -> Self {
    return mutation(of: self) { $0.formIntersection(with: others)}
  }
}
