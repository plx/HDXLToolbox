import Foundation
import HDXLEssentialPrecursors

extension IndexPositionStorageMovementAttemptResult {
  
  @inlinable
  internal var isSuccess: Bool {
    switch self {
    case .success:
      true
    case .becameEnd:
      false
    case .misnavigation:
      false
    }
  }
  
  @inlinable
  internal mutating func formCoalescence(
    with other: IndexPositionStorageMovementAttemptResult
  )  -> Bool {
    guard isSuccess else {
      return false
    }
    self = other
    return isSuccess
  }

  @inlinable
  internal static func coalescing(
    _ a: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ b: @autoclosure () -> IndexPositionStorageMovementAttemptResult
  ) -> IndexPositionStorageMovementAttemptResult {
    var result: IndexPositionStorageMovementAttemptResult = .success
    guard
      result.formCoalescence(with: a()),
      result.formCoalescence(with: b())
    else {
      return result
    }
    return result
  }

  @inlinable
  internal static func coalescing(
    _ a: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ b: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ c: @autoclosure () -> IndexPositionStorageMovementAttemptResult
  ) -> IndexPositionStorageMovementAttemptResult {
    var result: IndexPositionStorageMovementAttemptResult = .success
    guard
      result.formCoalescence(with: a()),
      result.formCoalescence(with: b()),
      result.formCoalescence(with: c()) 
    else {
      return result
    }
    return result
  }

  @inlinable
  internal static func coalescing(
    _ a: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ b: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ c: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ d: @autoclosure () -> IndexPositionStorageMovementAttemptResult
  ) -> IndexPositionStorageMovementAttemptResult {
    var result: IndexPositionStorageMovementAttemptResult = .success
    guard
      result.formCoalescence(with: a()),
      result.formCoalescence(with: b()),
      result.formCoalescence(with: c()),
      result.formCoalescence(with: d()) 
    else {
      return result
    }
    return result
  }

  @inlinable
  internal static func coalescing(
    _ a: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ b: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ c: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ d: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ e: @autoclosure () -> IndexPositionStorageMovementAttemptResult
  ) -> IndexPositionStorageMovementAttemptResult {
    var result: IndexPositionStorageMovementAttemptResult = .success
    guard
      result.formCoalescence(with: a()),
      result.formCoalescence(with: b()),
      result.formCoalescence(with: c()),
      result.formCoalescence(with: d()),
      result.formCoalescence(with: e()) 
    else {
      return result
    }
    return result
  }

  @inlinable
  internal static func coalescing(
    _ a: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ b: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ c: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ d: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ e: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ f: @autoclosure () -> IndexPositionStorageMovementAttemptResult
  ) -> IndexPositionStorageMovementAttemptResult {
    var result: IndexPositionStorageMovementAttemptResult = .success
    guard
      result.formCoalescence(with: a()),
      result.formCoalescence(with: b()),
      result.formCoalescence(with: c()),
      result.formCoalescence(with: d()),
      result.formCoalescence(with: e()),
      result.formCoalescence(with: f()) 
    else {
      return result
    }
    return result
  }

  @inlinable
  internal static func coalescing(
    _ a: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ b: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ c: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ d: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ e: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ f: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ g: @autoclosure () -> IndexPositionStorageMovementAttemptResult
  ) -> IndexPositionStorageMovementAttemptResult {
    var result: IndexPositionStorageMovementAttemptResult = .success
    guard
      result.formCoalescence(with: a()),
      result.formCoalescence(with: b()),
      result.formCoalescence(with: c()),
      result.formCoalescence(with: d()),
      result.formCoalescence(with: e()),
      result.formCoalescence(with: f()),
      result.formCoalescence(with: g()) 
    else {
      return result
    }
    return result
  }

  @inlinable
  internal static func coalescing(
    _ a: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ b: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ c: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ d: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ e: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ f: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ g: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ h: @autoclosure () -> IndexPositionStorageMovementAttemptResult
  ) -> IndexPositionStorageMovementAttemptResult {
    var result: IndexPositionStorageMovementAttemptResult = .success
    guard
      result.formCoalescence(with: a()),
      result.formCoalescence(with: b()),
      result.formCoalescence(with: c()),
      result.formCoalescence(with: d()),
      result.formCoalescence(with: e()),
      result.formCoalescence(with: f()),
      result.formCoalescence(with: g()),
      result.formCoalescence(with: h()) 
    else {
      return result
    }
    return result
  }

  @inlinable
  internal static func coalescing(
    _ a: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ b: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ c: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ d: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ e: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ f: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ g: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ h: @autoclosure () -> IndexPositionStorageMovementAttemptResult,
    _ i: @autoclosure () -> IndexPositionStorageMovementAttemptResult
  ) -> IndexPositionStorageMovementAttemptResult {
    var result: IndexPositionStorageMovementAttemptResult = .success
    guard
      result.formCoalescence(with: a()),
      result.formCoalescence(with: b()),
      result.formCoalescence(with: c()),
      result.formCoalescence(with: d()),
      result.formCoalescence(with: e()),
      result.formCoalescence(with: f()),
      result.formCoalescence(with: g()),
      result.formCoalescence(with: h()),
      result.formCoalescence(with: i()) 
    else {
      return result
    }
    return result
  }
  
}
