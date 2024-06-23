import Foundation

/// Lazily evalutes its arguments from left-to-right, returning the first non-nil value obtained.
@inlinable
public func firstNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?
) rethrows -> T? {
  if let a = try aa() { return a }
  if let b = try bb() { return b }
  return nil
}

/// Lazily evalutes its arguments from left-to-right, returning the first non-nil value obtained.
@inlinable
public func firstNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?
) rethrows -> T? {
  if let a = try aa() { return a }
  if let b = try bb() { return b }
  if let c = try cc() { return c }
  return nil
}

/// Lazily evalutes its arguments from left-to-right, returning the first non-nil value obtained.
@inlinable
public func firstNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?
) rethrows -> T? {
  if let a = try aa() { return a }
  if let b = try bb() { return b }
  if let c = try cc() { return c }
  if let d = try dd() { return d }
  return nil
}

/// Lazily evalutes its arguments from left-to-right, returning the first non-nil value obtained.
@inlinable
public func firstNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?,
  _ ee: @autoclosure () throws -> T?
) rethrows -> T? {
  if let a = try aa() { return a }
  if let b = try bb() { return b }
  if let c = try cc() { return c }
  if let d = try dd() { return d }
  if let e = try ee() { return e }
  return nil
}

/// Lazily evalutes its arguments from left-to-right, returning the first non-nil value obtained.
@inlinable
public func firstNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?,
  _ ee: @autoclosure () throws -> T?,
  _ ff: @autoclosure () throws -> T?
) rethrows -> T? {
  if let a = try aa() { return a }
  if let b = try bb() { return b }
  if let c = try cc() { return c }
  if let d = try dd() { return d }
  if let e = try ee() { return e }
  if let f = try ff() { return f }
  return nil
}

/// Lazily evalutes its arguments from left-to-right, returning the first non-nil value obtained.
@inlinable
public func firstNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?,
  _ ee: @autoclosure () throws -> T?,
  _ ff: @autoclosure () throws -> T?,
  _ gg: @autoclosure () throws -> T?
) rethrows -> T? {
  if let a = try aa() { return a }
  if let b = try bb() { return b }
  if let c = try cc() { return c }
  if let d = try dd() { return d }
  if let e = try ee() { return e }
  if let f = try ff() { return f }
  if let g = try gg() { return g }
  return nil
}

/// Lazily evalutes its arguments from left-to-right, returning the first non-nil value obtained.
@inlinable
public func firstNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?,
  _ ee: @autoclosure () throws -> T?,
  _ ff: @autoclosure () throws -> T?,
  _ gg: @autoclosure () throws -> T?,
  _ hh: @autoclosure () throws -> T?
) rethrows -> T? {
  if let a = try aa() { return a }
  if let b = try bb() { return b }
  if let c = try cc() { return c }
  if let d = try dd() { return d }
  if let e = try ee() { return e }
  if let f = try ff() { return f }
  if let g = try gg() { return g }
  if let h = try hh() { return h }
  return nil
}

/// Lazily evalutes its arguments from left-to-right, returning the first non-nil value obtained.
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

