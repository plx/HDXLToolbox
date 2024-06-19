import Foundation

extension Collection {
  @inlinable
  package func fatalAttemptToSubscriptEndIndex(
    _ index: Index,
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
  ) -> Never {
    fatalError(
      """
      Unrecoverable failure due to trying to subscript the end-index!
      
      - `self`: \(String(reflecting: self))
      - `index`: \(String(reflecting: index))
      - `function`: \(function)
      - `file`: \(file)
      - `line`: \(line)
      - `column`: \(column)
      """,
      file: file,
      line: line
    )
  }

  
  @inlinable
  package func fatalAttemptToAdvanceEndIndex(
    _ index: Index,
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
  ) -> Never {
    fatalError(
      """
      Unrecoverable failure due to trying to advance from the end-index!
      
      - `self`: \(String(reflecting: self))
      - `index`: \(String(reflecting: index))
      - `function`: \(function)
      - `file`: \(file)
      - `line`: \(line)
      - `column`: \(column)
      """,
      file: file,
      line: line
    )
  }
  
  @inlinable
  package func fatalAttemptToGoBackFromStartIndex(
    _ index: Index,
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
  ) -> Never {
    fatalError(
      """
      Unrecoverable failure due to trying to go back from the start-index!
      
      - `self`: \(String(reflecting: self))
      - `index`: \(String(reflecting: index))
      - `function`: \(function)
      - `file`: \(file)
      - `line`: \(line)
      - `column`: \(column)
      """,
      file: file,
      line: line
    )
  }
  
  @inlinable
  package func fatalIndexNavigationMistake(
    _ index: Index,
    offsetBy distance: Int,
    function: StaticString = #function,
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
  ) -> Never {
    fatalError(
      """
      Unrecoverable failure due to trying to reach `\(String(describing: index)) + \(distance)`!
      
      - `self`: \(String(reflecting: self))
      - `index`: \(String(reflecting: index))
      - `offsetBy`: \(String(reflecting: distance))
      - `function`: \(function)
      - `file`: \(file)
      - `line`: \(line)
      - `column`: \(column)
      """,
      file: file,
      line: line
    )
  }

}
