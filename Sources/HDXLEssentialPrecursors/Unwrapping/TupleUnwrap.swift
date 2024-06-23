import Foundation

/// Function equivalent to an explicit `guard`-`let` chain.
///
/// - note; This exists for use in variadic boilerplate; prefer explicit `guard`-`let` chains in all other contexts.
@inlinable
@inline(__always)
package func tupleUnwrap<
  A,
  B
>(
  _ a: @autoclosure () throws -> A?,
  _ b: @autoclosure () throws -> B?
) rethrows -> (A, B)? {
  guard
    let a = try a(),
    let b = try b()
  else {
    return nil
  }
  
  return (
    a,
    b
  )
}

/// Function equivalent to an explicit `guard`-`let` chain.
///
/// - note; This exists for use in variadic boilerplate; prefer explicit `guard`-`let` chains in all other contexts.
@inlinable
@inline(__always)
package func tupleUnwrap<
  A,
  B,
  C
>(
  _ a: @autoclosure () throws -> A?,
  _ b: @autoclosure () throws -> B?,
  _ c: @autoclosure () throws -> C?
) rethrows -> (A, B, C)? {
  guard
    let a = try a(),
    let b = try b(),
    let c = try c()
  else {
    return nil
  }
  
  return (
    a,
    b,
    c
  )
}

/// Function equivalent to an explicit `guard`-`let` chain.
///
/// - note; This exists for use in variadic boilerplate; prefer explicit `guard`-`let` chains in all other contexts.
@inlinable
@inline(__always)
package func tupleUnwrap<
  A,
  B,
  C,
  D
>(
  _ a: @autoclosure () throws -> A?,
  _ b: @autoclosure () throws -> B?,
  _ c: @autoclosure () throws -> C?,
  _ d: @autoclosure () throws -> D?
) rethrows -> (A, B, C, D)? {
  guard
    let a = try a(),
    let b = try b(),
    let c = try c(),
    let d = try d()
  else {
    return nil
  }
  
  return (
    a,
    b,
    c,
    d
  )
}

/// Function equivalent to an explicit `guard`-`let` chain.
///
/// - note; This exists for use in variadic boilerplate; prefer explicit `guard`-`let` chains in all other contexts.
@inlinable
@inline(__always)
package func tupleUnwrap<
  A,
  B,
  C,
  D,
  E
>(
  _ a: @autoclosure () throws -> A?,
  _ b: @autoclosure () throws -> B?,
  _ c: @autoclosure () throws -> C?,
  _ d: @autoclosure () throws -> D?,
  _ e: @autoclosure () throws -> E?
) rethrows -> (A, B, C, D, E)? {
  guard
    let a = try a(),
    let b = try b(),
    let c = try c(),
    let d = try d(),
    let e = try e()
  else {
    return nil
  }
  
  return (
    a,
    b,
    c,
    d,
    e
  )
}

/// Function equivalent to an explicit `guard`-`let` chain.
///
/// - note; This exists for use in variadic boilerplate; prefer explicit `guard`-`let` chains in all other contexts.
@inlinable
@inline(__always)
package func tupleUnwrap<
  A,
  B,
  C,
  D,
  E,
  F
>(
  _ a: @autoclosure () throws -> A?,
  _ b: @autoclosure () throws -> B?,
  _ c: @autoclosure () throws -> C?,
  _ d: @autoclosure () throws -> D?,
  _ e: @autoclosure () throws -> E?,
  _ f: @autoclosure () throws -> F?
) rethrows -> (A, B, C, D, E, F)? {
  guard
    let a = try a(),
    let b = try b(),
    let c = try c(),
    let d = try d(),
    let e = try e(),
    let f = try f()
  else {
    return nil
  }
  
  return (
    a,
    b,
    c,
    d,
    e,
    f
  )
}

/// Function equivalent to an explicit `guard`-`let` chain.
///
/// - note; This exists for use in variadic boilerplate; prefer explicit `guard`-`let` chains in all other contexts.
@inlinable
@inline(__always)
package func tupleUnwrap<
  A,
  B,
  C,
  D,
  E,
  F,
  G
>(
  _ a: @autoclosure () throws -> A?,
  _ b: @autoclosure () throws -> B?,
  _ c: @autoclosure () throws -> C?,
  _ d: @autoclosure () throws -> D?,
  _ e: @autoclosure () throws -> E?,
  _ f: @autoclosure () throws -> F?,
  _ g: @autoclosure () throws -> G?
) rethrows -> (A, B, C, D, E, F, G)? {
  guard
    let a = try a(),
    let b = try b(),
    let c = try c(),
    let d = try d(),
    let e = try e(),
    let f = try f(),
    let g = try g()
  else {
    return nil
  }
  
  return (
    a,
    b,
    c,
    d,
    e,
    f,
    g
  )
}

/// Function equivalent to an explicit `guard`-`let` chain.
///
/// - note; This exists for use in variadic boilerplate; prefer explicit `guard`-`let` chains in all other contexts.
@inlinable
@inline(__always)
package func tupleUnwrap<
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H
>(
  _ a: @autoclosure () throws -> A?,
  _ b: @autoclosure () throws -> B?,
  _ c: @autoclosure () throws -> C?,
  _ d: @autoclosure () throws -> D?,
  _ e: @autoclosure () throws -> E?,
  _ f: @autoclosure () throws -> F?,
  _ g: @autoclosure () throws -> G?,
  _ h: @autoclosure () throws -> H?
) rethrows -> (A, B, C, D, E, F, G, H)? {
  guard
    let a = try a(),
    let b = try b(),
    let c = try c(),
    let d = try d(),
    let e = try e(),
    let f = try f(),
    let g = try g(),
    let h = try h()
  else {
    return nil
  }
  
  return (
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    h
  )
}

/// Function equivalent to an explicit `guard`-`let` chain.
///
/// - note; This exists for use in variadic boilerplate; prefer explicit `guard`-`let` chains in all other contexts.
@inlinable
@inline(__always)
package func tupleUnwrap<
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I
>(
  _ a: @autoclosure () throws -> A?,
  _ b: @autoclosure () throws -> B?,
  _ c: @autoclosure () throws -> C?,
  _ d: @autoclosure () throws -> D?,
  _ e: @autoclosure () throws -> E?,
  _ f: @autoclosure () throws -> F?,
  _ g: @autoclosure () throws -> G?,
  _ h: @autoclosure () throws -> H?,
  _ i: @autoclosure () throws -> I?
) rethrows -> (A, B, C, D, E, F, G, H, I)? {
  guard
    let a = try a(),
    let b = try b(),
    let c = try c(),
    let d = try d(),
    let e = try e(),
    let f = try f(),
    let g = try g(),
    let h = try h(),
    let i = try i()
  else {
    return nil
  }
  
  return (
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    h,
    i
  )
}
