import Foundation

@inlinable
package func _mandatoryUnwrapMacroValue<T>(
  label: StaticString,
  value: T?,
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line,
  column: UInt = #column
) -> T {
  guard let value else {
    fatalError(
      """
      Failed to unwrap mandatory macro-value for `\(label)` of type \(String(reflecting: T.self))!
      
      - `function`: \(function)
      - `file`: \(file)
      - `line`: \(line)
      - `column`: \(column)
      """,
      file: file,
      line: line
    )
  }
  
  return value
}

