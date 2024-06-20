import Foundation

extension RangeReplaceableCollection {
  
  @inlinable
  public mutating func conditionallyAppend(
    value: @autoclosure () -> Element,
    when condition: Bool
  ) {
    guard condition else { return }
    append(value())
  }
  
  @inlinable
  public mutating func conditionallyAppend(
    possibleValue: @autoclosure () -> Element?,
    when condition: Bool
  ) {
    guard
      condition,
      let value = possibleValue()
    else {
      return
    }
    
    append(value)
  }

  @inlinable
  public mutating func append(possibleValue: Element?) {
    guard let value = possibleValue else {
      return
    }
    append(value)
  }
  
  @inlinable
  public mutating func append(possibleContentsOf possibleElements: (some Sequence<Element>)?) {
    guard let elements = possibleElements else {
      return
    }
    append(contentsOf: elements)
  }
  
  @inlinable
  public mutating func appendLazyApplication<T>(
    of function: (T) throws -> Element,
    to sequence: some Sequence<T>
  ) throws {
    append(
      contentsOf: try sequence.lazy.map(function)
    )
  }

  @inlinable
  public mutating func appendLazyApplication<T>(
    of function: (T) -> Element,
    to sequence: some Sequence<T>
  ) {
    withoutActuallyEscaping(function) { transform in
      append(
        contentsOf: sequence.localOnDemandMap(transform)
      )
    }
  }

}
