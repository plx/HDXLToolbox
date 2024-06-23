import Foundation

extension AlgebraicProduct9 {
  
  @inlinable
  public func evaluate<
    T,
    RA,
    RB,
    RC,
    RD,
    RE,
    RF,
    RG,
    RH,
    RI
  >(
    on value: T
  ) -> (
    RA,
    RB,
    RC,
    RD,
    RE,
    RF,
    RG,
    RH,
    RI
  ) 
  where
  A == (T) -> RA,
  B == (T) -> RB,
  C == (T) -> RC,
  D == (T) -> RD,
  E == (T) -> RE,
  F == (T) -> RF,
  G == (T) -> RG,
  H == (T) -> RH,
  I == (T) -> RI
  {
    (
      a(value),
      b(value),
      c(value),
      d(value),
      e(value),
      f(value),
      g(value),
      h(value),
      i(value)
    )
  }

  @inlinable
  public func weaklyEvaluate<
    T,
    RA,
    RB,
    RC,
    RD,
    RE,
    RF,
    RG,
    RH,
    RI
  >(
    on value: T
  ) -> (
    RA,
    RB,
    RC,
    RD,
    RE,
    RF,
    RG,
    RH,
    RI
  )?
  where
  A == (T) -> RA?,
  B == (T) -> RB?,
  C == (T) -> RC?,
  D == (T) -> RD?,
  E == (T) -> RE?,
  F == (T) -> RF?,
  G == (T) -> RG?,
  H == (T) -> RH?,
  I == (T) -> RI?
  {
    guard
      let a = a(value),
      let b = b(value),
      let c = c(value),
      let d = d(value),
      let e = e(value),
      let f = f(value),
      let g = g(value),
      let h = h(value),
      let i = i(value)
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

}
