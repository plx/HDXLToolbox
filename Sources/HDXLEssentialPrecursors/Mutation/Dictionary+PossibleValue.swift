import Foundation

extension Dictionary {
  
  @inlinable
  @discardableResult
  public mutating func updatePossibleValue(
    _ possibleValue: Value?,
    forKey key: Key
  ) -> Value? {
    switch possibleValue {
    case .none:
      return nil
    case .some(let value):
      return updateValue(value, forKey: key)
    }
  }

  @inlinable
  @discardableResult
  public mutating func updatePossibleValue(
    _ possibleValue: Value?,
    forPossibleKey possibleKey: Key?
  ) -> Value? {
    guard
      let value = possibleValue,
      let key = possibleKey
    else {
      return nil
    }
    return updateValue(value, forKey: key)
  }
  
  @inlinable
  @discardableResult
  public mutating func removeValue(forPossibleKey possibleKey: Key?) -> Value? {
    switch possibleKey {
    case .none:
      return nil
    case .some(let key):
      return removeValue(forKey: key)
    }
  }

}
