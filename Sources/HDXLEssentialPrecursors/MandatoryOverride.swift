import Foundation

@inlinable
package func mandatoryOverride(
  for object: (some AnyObject).Type,
  function: StaticString = #function,
  file: StaticString = #file,
  line: UInt = #line
) -> Never {
  fatalError(
    "Subclasses of \(String(reflecting: type(of: object))) *must* override \(function)",
    file: file,
    line: line
  )
}
