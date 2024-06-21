import Foundation

extension Dictionary {
  
  @inlinable
  public init<T>(
    fromLazyTransformationOf elements: some Sequence<T>,
    by transformation: (T) throws -> (Key, Value),
    uniquingValuesWith uniquer: (Value, Value) -> Value = { $1 }
  ) rethrows {
    self.init(minimumCapacity: elements.underestimatedCount)
    for element in elements {
      let (key, value) = try transformation(element)
      switch index(forKey: key) {
      case .some(let index):
        values[index] = uniquer(values[index], value)
      case .none:
        self[key] = value
      }
    }
  }

  @inlinable
  public init<T>(
    fromLazyTransformationOf elements: some Sequence<(Key, T)>,
    by transformation: (T) throws -> (Key, Value),
    uniquingValuesWith uniquer: (Value, Value) -> Value = { $1 }
  ) rethrows {
    self.init(minimumCapacity: elements.underestimatedCount)
    for (key, element) in elements {
      let (key, value) = try transformation(element)
      switch index(forKey: key) {
      case .some(let index):
        values[index] = uniquer(values[index], value)
      case .none:
        self[key] = value
      }
    }
  }

}
