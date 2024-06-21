import Foundation
// TODO: inject some kind of global failure thing that lets clients
// set a custom failure handler for mandatory values.

/// Force-unwraps `value` (or terminates with a detailed error message).
///
/// Exists to provide a safer, more self-documenting alternative to `!`, e.g. for things like this:
///
/// ```swift
/// let loadingIcon = mandatoryValue(
///   Image(named: "LoadingIcon"),
///   "`LoadingIcon` is a built-in resource we must be able to locate for the application to work."
/// )
/// ```
///
/// - Parameters:
///   - value: The value to be unwrapped.
///   - explanation: A developer-facing explanation for why the unwrapping should always succeed.
///   - function: The function to-which to attribute this call.
///   - file: The file to-which to attribute this call.
///   - line: The line to-which to attribute this call.
///   - column: The column to-which to attribute this call.
/// - Returns: The equivalent of `value()!`.
///
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

