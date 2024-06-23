import XCTest

extension XCTestCase {
  
  @inlinable
  public func haltingOnFirstError<R>(_ closure: () throws -> R) rethrows -> R {
    let previousContinueAfterFailure = continueAfterFailure
    defer { continueAfterFailure = previousContinueAfterFailure }
    continueAfterFailure = false
    
    return try closure()
  }
  
}
