import Foundation

@inlinable
public func mandatoryValue<T>(
  _ value: @autoclosure () -> T?,
  explanation: StaticString,
  function: StaticString = #function,
  file: StaticString = #fileID,
  line: UInt = #line,
  column: UInt = #column
) -> T {
  guard let value = value() else {
    _mandatoryValueFailure(
      forValueOfType: T.self,
      expression: "`.none` (via `mandatoryValue`)",
      explanation: explanation,
      function: function,
      file: file,
      line: line,
      column: column
    )
  }
  
  return value
}

@inlinable
internal func _mandatoryValueFailure<T>(
  forValueOfType valueType: T.Type,
  expression: String,
  explanation: StaticString,
  function: StaticString = #function,
  file: StaticString = #fileID,
  line: UInt = #line,
  column: UInt = #column
) -> Never {
  fatalError(
    """
    Failed to produce non-nil value for a *mandatory* value of expected-type `\(String(reflecting: valueType))`:
    
    - `expression`: \(expression)
    - `explanation`: \(explanation)
    - `function`: \(function)
    - `file`: \(file)
    - `line`: \(file)
    - `column`: \(column)
    """,
    file: file,
    line: line
  )
}

@inlinable
public func _mandatoryMacroValue<T>(
  _ value: @autoclosure () -> T?,
  expression: String,
  explanation: StaticString,
  function: StaticString = #function,
  file: StaticString = #fileID,
  line: UInt = #line,
  column: UInt = #column
) -> T {
  guard let value = value() else {
    _mandatoryValueFailure(
      forValueOfType: T.self,
      expression: expression,
      explanation: explanation,
      function: function,
      file: file,
      line: line,
      column: column
    )
  }
  
  return value
}

