import Foundation




@inlinable
public func firstNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?,
  _ ee: @autoclosure () throws -> T?,
  _ ff: @autoclosure () throws -> T?,
  _ gg: @autoclosure () throws -> T?,
  _ hh: @autoclosure () throws -> T?,
  _ ii: @autoclosure () throws -> T?
) rethrows -> T? {
  if let a = try aa() { return a }
  if let b = try bb() { return b }
  if let c = try cc() { return c }
  if let d = try dd() { return d }
  if let e = try ee() { return e }
  if let f = try ff() { return f }
  if let g = try gg() { return g }
  if let h = try hh() { return h }
  if let i = try ii() { return i }
  return nil
}

