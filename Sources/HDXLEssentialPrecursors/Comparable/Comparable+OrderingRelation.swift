import Foundation

extension ComparisonResult {
  @inlinable
  public func implies(_ orderingRelation: OrderingRelation) -> Bool {
    switch orderingRelation {
    case .equal:
      self == .orderedSame
    case .lessThan:
      self == .orderedAscending
    case .lessThanOrEqual:
      self != .orderedDescending
    case .greaterThan:
      self == .orderedDescending
    case .greaterThanOrEqual:
      self != .orderedAscending
    }
  }
  
  @inlinable
  public var impliesLessThan: Bool {
    implies(.lessThan)
  }
  
  @inlinable
  public var impliesLessThanOrEqual: Bool {
    implies(.lessThanOrEqual)
  }
  
  @inlinable
  public var impliesGreaterThan: Bool {
    implies(.greaterThan)
  }
  
  @inlinable
  public var impliesGreaterThanOrEqual: Bool {
    implies(.greaterThanOrEqual)
  }
  
  @inlinable
  public var impliesEqual: Bool {
    implies(.equal)
  }
}

extension ComparisonResult {
  @inlinable
  public static func coalescing(
    _ a: @autoclosure () -> ComparisonResult,
    _ b: @autoclosure () -> ComparisonResult
  ) -> ComparisonResult {
    let aa = a()
    guard aa != .orderedSame else {
      return aa
    }
    return b()
  }

  @inlinable
  public static func coalescing(
    _ a: @autoclosure () -> ComparisonResult,
    _ b: @autoclosure () -> ComparisonResult,
    _ c: @autoclosure () -> ComparisonResult
  ) -> ComparisonResult {
    let aa = a()
    guard aa != .orderedSame else {
      return aa
    }
    let bb = b()
    guard bb != .orderedSame else {
      return bb
    }
    return c()
  }

  @inlinable
  public static func coalescing(
    _ a: @autoclosure () -> ComparisonResult,
    _ b: @autoclosure () -> ComparisonResult,
    _ c: @autoclosure () -> ComparisonResult,
    _ d: @autoclosure () -> ComparisonResult
  ) -> ComparisonResult {
    let aa = a()
    guard aa != .orderedSame else {
      return aa
    }
    let bb = b()
    guard bb != .orderedSame else {
      return bb
    }
    let cc = c()
    guard cc != .orderedSame else {
      return cc
    }
    return d()
  }

  @inlinable
  public static func coalescing(
    _ a: @autoclosure () -> ComparisonResult,
    _ b: @autoclosure () -> ComparisonResult,
    _ c: @autoclosure () -> ComparisonResult,
    _ d: @autoclosure () -> ComparisonResult,
    _ e: @autoclosure () -> ComparisonResult
  ) -> ComparisonResult {
    let aa = a()
    guard aa != .orderedSame else {
      return aa
    }
    let bb = b()
    guard bb != .orderedSame else {
      return bb
    }
    let cc = c()
    guard cc != .orderedSame else {
      return cc
    }
    let dd = d()
    guard dd != .orderedSame else {
      return dd
    }
    return e()
  }

  @inlinable
  public static func coalescing(
    _ a: @autoclosure () -> ComparisonResult,
    _ b: @autoclosure () -> ComparisonResult,
    _ c: @autoclosure () -> ComparisonResult,
    _ d: @autoclosure () -> ComparisonResult,
    _ e: @autoclosure () -> ComparisonResult,
    _ f: @autoclosure () -> ComparisonResult
  ) -> ComparisonResult {
    let aa = a()
    guard aa != .orderedSame else {
      return aa
    }
    let bb = b()
    guard bb != .orderedSame else {
      return bb
    }
    let cc = c()
    guard cc != .orderedSame else {
      return cc
    }
    let dd = d()
    guard dd != .orderedSame else {
      return dd
    }
    let ee = e()
    guard ee != .orderedSame else {
      return ee
    }
    return f()
  }

  @inlinable
  public static func coalescing(
    _ a: @autoclosure () -> ComparisonResult,
    _ b: @autoclosure () -> ComparisonResult,
    _ c: @autoclosure () -> ComparisonResult,
    _ d: @autoclosure () -> ComparisonResult,
    _ e: @autoclosure () -> ComparisonResult,
    _ f: @autoclosure () -> ComparisonResult,
    _ g: @autoclosure () -> ComparisonResult
  ) -> ComparisonResult {
    let aa = a()
    guard aa != .orderedSame else {
      return aa
    }
    let bb = b()
    guard bb != .orderedSame else {
      return bb
    }
    let cc = c()
    guard cc != .orderedSame else {
      return cc
    }
    let dd = d()
    guard dd != .orderedSame else {
      return dd
    }
    let ee = e()
    guard ee != .orderedSame else {
      return ee
    }
    let ff = f()
    guard ff != .orderedSame else {
      return ff
    }
    return g()
  }

  @inlinable
  public static func coalescing(
    _ a: @autoclosure () -> ComparisonResult,
    _ b: @autoclosure () -> ComparisonResult,
    _ c: @autoclosure () -> ComparisonResult,
    _ d: @autoclosure () -> ComparisonResult,
    _ e: @autoclosure () -> ComparisonResult,
    _ f: @autoclosure () -> ComparisonResult,
    _ g: @autoclosure () -> ComparisonResult,
    _ h: @autoclosure () -> ComparisonResult
  ) -> ComparisonResult {
    let aa = a()
    guard aa != .orderedSame else {
      return aa
    }
    let bb = b()
    guard bb != .orderedSame else {
      return bb
    }
    let cc = c()
    guard cc != .orderedSame else {
      return cc
    }
    let dd = d()
    guard dd != .orderedSame else {
      return dd
    }
    let ee = e()
    guard ee != .orderedSame else {
      return ee
    }
    let ff = f()
    guard ff != .orderedSame else {
      return ff
    }
    let gg = g()
    guard gg != .orderedSame else {
      return gg
    }
    return h()
  }

  @inlinable
  public static func coalescing(
    _ a: @autoclosure () -> ComparisonResult,
    _ b: @autoclosure () -> ComparisonResult,
    _ c: @autoclosure () -> ComparisonResult,
    _ d: @autoclosure () -> ComparisonResult,
    _ e: @autoclosure () -> ComparisonResult,
    _ f: @autoclosure () -> ComparisonResult,
    _ g: @autoclosure () -> ComparisonResult,
    _ h: @autoclosure () -> ComparisonResult,
    _ i: @autoclosure () -> ComparisonResult
  ) -> ComparisonResult {
    let aa = a()
    guard aa != .orderedSame else {
      return aa
    }
    let bb = b()
    guard bb != .orderedSame else {
      return bb
    }
    let cc = c()
    guard cc != .orderedSame else {
      return cc
    }
    let dd = d()
    guard dd != .orderedSame else {
      return dd
    }
    let ee = e()
    guard ee != .orderedSame else {
      return ee
    }
    let ff = f()
    guard ff != .orderedSame else {
      return ff
    }
    let gg = g()
    guard gg != .orderedSame else {
      return gg
    }
    let hh = h()
    guard hh != .orderedSame else {
      return hh
    }
    return i()
  }
}
