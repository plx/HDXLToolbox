import Foundation




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
