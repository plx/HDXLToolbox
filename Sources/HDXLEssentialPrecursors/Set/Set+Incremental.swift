import Foundation

extension Set {
  
  @inlinable
  public init<T>(
    fromLazyTransformationOf values: some Sequence<T>,
    by transformation: (T) throws -> (Element)
  ) rethrows {
    self.init()
    for value in values {
      insert(try transformation(value))
    }
  }

}
