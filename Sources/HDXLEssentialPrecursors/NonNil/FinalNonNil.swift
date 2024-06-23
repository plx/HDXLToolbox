import Foundation

/// Lazily evalutes its arguments from right-to-left, returning the first non-nil value obtained.
@inlinable
public func finalNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?
) rethrows -> T? {
  if let b = try bb() { return b }
  if let a = try aa() { return a }
  return nil
}

/// Lazily evalutes its arguments from right-to-left, returning the first non-nil value obtained.
@inlinable
public func finalNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?
) rethrows -> T? {
  if let c = try cc() { return c }
  if let b = try bb() { return b }
  if let a = try aa() { return a }
  return nil
}

/// Lazily evalutes its arguments from right-to-left, returning the first non-nil value obtained.
@inlinable
public func finalNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?
) rethrows -> T? {
  if let d = try dd() { return d }
  if let c = try cc() { return c }
  if let b = try bb() { return b }
  if let a = try aa() { return a }
  return nil
}

/// Lazily evalutes its arguments from right-to-left, returning the first non-nil value obtained.
@inlinable
public func finalNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?,
  _ ee: @autoclosure () throws -> T?
) rethrows -> T? {
  if let e = try ee() { return e }
  if let d = try dd() { return d }
  if let c = try cc() { return c }
  if let b = try bb() { return b }
  if let a = try aa() { return a }
  return nil
}

/// Lazily evalutes its arguments from right-to-left, returning the first non-nil value obtained.
@inlinable
public func finalNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?,
  _ ee: @autoclosure () throws -> T?,
  _ ff: @autoclosure () throws -> T?
) rethrows -> T? {
  if let f = try ff() { return f }
  if let e = try ee() { return e }
  if let d = try dd() { return d }
  if let c = try cc() { return c }
  if let b = try bb() { return b }
  if let a = try aa() { return a }
  return nil
}

/// Lazily evalutes its arguments from right-to-left, returning the first non-nil value obtained.
@inlinable
public func finalNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?,
  _ ee: @autoclosure () throws -> T?,
  _ ff: @autoclosure () throws -> T?,
  _ gg: @autoclosure () throws -> T?
) rethrows -> T? {
  if let g = try gg() { return g }
  if let f = try ff() { return f }
  if let e = try ee() { return e }
  if let d = try dd() { return d }
  if let c = try cc() { return c }
  if let b = try bb() { return b }
  if let a = try aa() { return a }
  return nil
}

/// Lazily evalutes its arguments from right-to-left, returning the first non-nil value obtained.
@inlinable
public func finalNonNil<T>(
  _ aa: @autoclosure () throws -> T?,
  _ bb: @autoclosure () throws -> T?,
  _ cc: @autoclosure () throws -> T?,
  _ dd: @autoclosure () throws -> T?,
  _ ee: @autoclosure () throws -> T?,
  _ ff: @autoclosure () throws -> T?,
  _ gg: @autoclosure () throws -> T?,
  _ hh: @autoclosure () throws -> T?
) rethrows -> T? {
  if let h = try hh() { return h }
  if let g = try gg() { return g }
  if let f = try ff() { return f }
  if let e = try ee() { return e }
  if let d = try dd() { return d }
  if let c = try cc() { return c }
  if let b = try bb() { return b }
  if let a = try aa() { return a }
  return nil
}

/// Lazily evalutes its arguments from right-to-left, returning the first non-nil value obtained.
@inlinable
public func finalNonNil<T>(
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
  if let i = try ii() { return i }
  if let h = try hh() { return h }
  if let g = try gg() { return g }
  if let f = try ff() { return f }
  if let e = try ee() { return e }
  if let d = try dd() { return d }
  if let c = try cc() { return c }
  if let b = try bb() { return b }
  if let a = try aa() { return a }
  return nil
}


