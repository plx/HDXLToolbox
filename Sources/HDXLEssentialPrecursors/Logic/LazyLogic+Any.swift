
@inlinable
package func anyAreTrue(
  _ a: @autoclosure () throws -> Bool,
  _ b: @autoclosure () throws -> Bool
) rethrows -> Bool {
  try a() || b()
}

@inlinable
package func anyAreTrue(
  _ a: @autoclosure () throws -> Bool,
  _ b: @autoclosure () throws -> Bool,
  _ c: @autoclosure () throws -> Bool
) rethrows -> Bool {
  try a() || b() || c()
}

@inlinable
package func anyAreTrue(
  _ a: @autoclosure () throws -> Bool,
  _ b: @autoclosure () throws -> Bool,
  _ c: @autoclosure () throws -> Bool,
  _ d: @autoclosure () throws -> Bool
) rethrows -> Bool {
  try a() || b() || c() || d()
}

@inlinable
package func anyAreTrue(
  _ a: @autoclosure () throws -> Bool,
  _ b: @autoclosure () throws -> Bool,
  _ c: @autoclosure () throws -> Bool,
  _ d: @autoclosure () throws -> Bool,
  _ e: @autoclosure () throws -> Bool
) rethrows -> Bool {
  try a() || b() || c() || d() || e()
}

@inlinable
package func anyAreTrue(
  _ a: @autoclosure () throws -> Bool,
  _ b: @autoclosure () throws -> Bool,
  _ c: @autoclosure () throws -> Bool,
  _ d: @autoclosure () throws -> Bool,
  _ e: @autoclosure () throws -> Bool,
  _ f: @autoclosure () throws -> Bool
) rethrows -> Bool {
  try a() || b() || c() || d() || e() || f()
}

@inlinable
package func anyAreTrue(
  _ a: @autoclosure () throws -> Bool,
  _ b: @autoclosure () throws -> Bool,
  _ c: @autoclosure () throws -> Bool,
  _ d: @autoclosure () throws -> Bool,
  _ e: @autoclosure () throws -> Bool,
  _ f: @autoclosure () throws -> Bool,
  _ g: @autoclosure () throws -> Bool
) rethrows -> Bool {
  try a() || b() || c() || d() || e() || f() || g()
}

@inlinable
package func anyAreTrue(
  _ a: @autoclosure () throws -> Bool,
  _ b: @autoclosure () throws -> Bool,
  _ c: @autoclosure () throws -> Bool,
  _ d: @autoclosure () throws -> Bool,
  _ e: @autoclosure () throws -> Bool,
  _ f: @autoclosure () throws -> Bool,
  _ g: @autoclosure () throws -> Bool,
  _ h: @autoclosure () throws -> Bool
) rethrows -> Bool {
  try a() || b() || c() || d() || e() || f() || g() || h()
}

@inlinable
package func anyAreTrue(
  _ a: @autoclosure () throws -> Bool,
  _ b: @autoclosure () throws -> Bool,
  _ c: @autoclosure () throws -> Bool,
  _ d: @autoclosure () throws -> Bool,
  _ e: @autoclosure () throws -> Bool,
  _ f: @autoclosure () throws -> Bool,
  _ g: @autoclosure () throws -> Bool,
  _ h: @autoclosure () throws -> Bool,
  _ i: @autoclosure () throws -> Bool
) rethrows -> Bool {
  try a() || b() || c() || d() || e() || f() || g() || h() || i()
}
