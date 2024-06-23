import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: Arity-2
// -------------------------------------------------------------------------- //

@inlinable
package func coalesceMovementAttemptDestinations<A,B>(
  _ a: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<A>,
  _ b: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<B>
) -> IndexPositionStorageMovementAttemptDestination<(A,B)> {
  switch a() {
  case .misnavigation:
    .misnavigation
  case .becameEnd:
    .becameEnd
  case .success(let aPosition):
    switch b() {
    case .misnavigation:
      .misnavigation
    case .becameEnd:
      .becameEnd
    case .success(let bPosition):
      .success(
        (
          aPosition,
          bPosition
        )
      )
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Arity-3
// -------------------------------------------------------------------------- //

@inlinable
internal func coalesceMovementAttemptDestinations<A,B,C>(
  _ a: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<A>,
  _ b: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<B>,
  _ c: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<C>
) -> IndexPositionStorageMovementAttemptDestination<(A,B,C)> {
  switch a() {
  case .misnavigation:
    .misnavigation
  case .becameEnd:
    .becameEnd
  case .success(let aPosition):
    switch b() {
    case .misnavigation:
      .misnavigation
    case .becameEnd:
      .becameEnd
    case .success(let bPosition):
      switch c() {
      case .misnavigation:
        .misnavigation
      case .becameEnd:
        .becameEnd
      case .success(let cPosition):
        .success(
          (
            aPosition,
            bPosition,
            cPosition
          )
        )
      }
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Arity-4
// -------------------------------------------------------------------------- //

@inlinable
internal func coalesceMovementAttemptDestinations<A,B,C,D>(
  _ a: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<A>,
  _ b: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<B>,
  _ c: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<C>,
  _ d: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<D>
) -> IndexPositionStorageMovementAttemptDestination<(A,B,C,D)> {
  switch a() {
  case .misnavigation:
    .misnavigation
  case .becameEnd:
    .becameEnd
  case .success(let aPosition):
    switch b() {
    case .misnavigation:
      .misnavigation
    case .becameEnd:
      .becameEnd
    case .success(let bPosition):
      switch c() {
      case .misnavigation:
        .misnavigation
      case .becameEnd:
        .becameEnd
      case .success(let cPosition):
        switch d() {
        case .misnavigation:
          .misnavigation
        case .becameEnd:
          .becameEnd
        case .success(let dPosition):
          .success(
            (
              aPosition,
              bPosition,
              cPosition,
              dPosition
            )
          )
        }
      }
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Arity-5
// -------------------------------------------------------------------------- //

@inlinable
internal func coalesceMovementAttemptDestinations<A,B,C,D,E>(
  _ a: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<A>,
  _ b: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<B>,
  _ c: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<C>,
  _ d: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<D>,
  _ e: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<E>
) -> IndexPositionStorageMovementAttemptDestination<(A,B,C,D,E)> {
  switch a() {
  case .misnavigation:
    .misnavigation
  case .becameEnd:
    .becameEnd
  case .success(let aPosition):
    switch b() {
    case .misnavigation:
      .misnavigation
    case .becameEnd:
      .becameEnd
    case .success(let bPosition):
      switch c() {
      case .misnavigation:
        .misnavigation
      case .becameEnd:
        .becameEnd
      case .success(let cPosition):
        switch d() {
        case .misnavigation:
          .misnavigation
        case .becameEnd:
          .becameEnd
        case .success(let dPosition):
          switch e() {
          case .misnavigation:
            .misnavigation
          case .becameEnd:
            .becameEnd
          case .success(let ePosition):
            .success(
              (
                aPosition,
                bPosition,
                cPosition,
                dPosition,
                ePosition
              )
            )
          }
        }
      }
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Arity-6
// -------------------------------------------------------------------------- //

@inlinable
internal func coalesceMovementAttemptDestinations<A,B,C,D,E,F>(
  _ a: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<A>,
  _ b: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<B>,
  _ c: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<C>,
  _ d: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<D>,
  _ e: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<E>,
  _ f: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<F>
) -> IndexPositionStorageMovementAttemptDestination<(A,B,C,D,E,F)> {
  switch a() {
  case .misnavigation:
    .misnavigation
  case .becameEnd:
    .becameEnd
  case .success(let aPosition):
    switch b() {
    case .misnavigation:
      .misnavigation
    case .becameEnd:
      .becameEnd
    case .success(let bPosition):
      switch c() {
      case .misnavigation:
        .misnavigation
      case .becameEnd:
        .becameEnd
      case .success(let cPosition):
        switch d() {
        case .misnavigation:
          .misnavigation
        case .becameEnd:
          .becameEnd
        case .success(let dPosition):
          switch e() {
          case .misnavigation:
            .misnavigation
          case .becameEnd:
            .becameEnd
          case .success(let ePosition):
            switch f() {
            case .misnavigation:
              .misnavigation
            case .becameEnd:
              .becameEnd
            case .success(let fPosition):
              .success(
                (
                  aPosition,
                  bPosition,
                  cPosition,
                  dPosition,
                  ePosition,
                  fPosition
                )
              )
            }
          }
        }
      }
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Arity-7
// -------------------------------------------------------------------------- //

@inlinable
internal func coalesceMovementAttemptDestinations<A,B,C,D,E,F,G>(
  _ a: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<A>,
  _ b: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<B>,
  _ c: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<C>,
  _ d: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<D>,
  _ e: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<E>,
  _ f: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<F>,
  _ g: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<G>
) -> IndexPositionStorageMovementAttemptDestination<(A,B,C,D,E,F,G)> {
  switch a() {
  case .misnavigation:
    .misnavigation
  case .becameEnd:
    .becameEnd
  case .success(let aPosition):
    switch b() {
    case .misnavigation:
      .misnavigation
    case .becameEnd:
      .becameEnd
    case .success(let bPosition):
      switch c() {
      case .misnavigation:
        .misnavigation
      case .becameEnd:
        .becameEnd
      case .success(let cPosition):
        switch d() {
        case .misnavigation:
          .misnavigation
        case .becameEnd:
          .becameEnd
        case .success(let dPosition):
          switch e() {
          case .misnavigation:
            .misnavigation
          case .becameEnd:
            .becameEnd
          case .success(let ePosition):
            switch f() {
            case .misnavigation:
              .misnavigation
            case .becameEnd:
              .becameEnd
            case .success(let fPosition):
              switch g() {
              case .misnavigation:
                .misnavigation
              case .becameEnd:
                .becameEnd
              case .success(let gPosition):
                .success(
                  (
                    aPosition,
                    bPosition,
                    cPosition,
                    dPosition,
                    ePosition,
                    fPosition,
                    gPosition
                  )
                )
              }
            }
          }
        }
      }
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Arity-8
// -------------------------------------------------------------------------- //

@inlinable
internal func coalesceMovementAttemptDestinations<A,B,C,D,E,F,G,H>(
  _ a: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<A>,
  _ b: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<B>,
  _ c: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<C>,
  _ d: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<D>,
  _ e: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<E>,
  _ f: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<F>,
  _ g: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<G>,
  _ h: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<H>
) -> IndexPositionStorageMovementAttemptDestination<(A,B,C,D,E,F,G,H)> {
  switch a() {
  case .misnavigation:
    .misnavigation
  case .becameEnd:
    .becameEnd
  case .success(let aPosition):
    switch b() {
    case .misnavigation:
      .misnavigation
    case .becameEnd:
      .becameEnd
    case .success(let bPosition):
      switch c() {
      case .misnavigation:
        .misnavigation
      case .becameEnd:
        .becameEnd
      case .success(let cPosition):
        switch d() {
        case .misnavigation:
          .misnavigation
        case .becameEnd:
          .becameEnd
        case .success(let dPosition):
          switch e() {
          case .misnavigation:
            .misnavigation
          case .becameEnd:
            .becameEnd
          case .success(let ePosition):
            switch f() {
            case .misnavigation:
              .misnavigation
            case .becameEnd:
              .becameEnd
            case .success(let fPosition):
              switch g() {
              case .misnavigation:
                .misnavigation
              case .becameEnd:
                .becameEnd
              case .success(let gPosition):
                switch h() {
                case .misnavigation:
                  .misnavigation
                case .becameEnd:
                  .becameEnd
                case .success(let hPosition):
                  .success(
                    (
                      aPosition,
                      bPosition,
                      cPosition,
                      dPosition,
                      ePosition,
                      fPosition,
                      gPosition,
                      hPosition
                    )
                  )
                }
              }
            }
          }
        }
      }
    }
  }
}

// -------------------------------------------------------------------------- //
// MARK: Arity-9
// -------------------------------------------------------------------------- //

@inlinable
internal func coalesceMovementAttemptDestinations<A,B,C,D,E,F,G,H,I>(
  _ a: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<A>,
  _ b: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<B>,
  _ c: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<C>,
  _ d: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<D>,
  _ e: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<E>,
  _ f: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<F>,
  _ g: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<G>,
  _ h: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<H>,
  _ i: @autoclosure () -> IndexPositionStorageMovementAttemptDestination<I>
) -> IndexPositionStorageMovementAttemptDestination<(A,B,C,D,E,F,G,H,I)> {
  switch a() {
  case .misnavigation:
    .misnavigation
  case .becameEnd:
    .becameEnd
  case .success(let aPosition):
    switch b() {
    case .misnavigation:
      .misnavigation
    case .becameEnd:
      .becameEnd
    case .success(let bPosition):
      switch c() {
      case .misnavigation:
        .misnavigation
      case .becameEnd:
        .becameEnd
      case .success(let cPosition):
        switch d() {
        case .misnavigation:
          .misnavigation
        case .becameEnd:
          .becameEnd
        case .success(let dPosition):
          switch e() {
          case .misnavigation:
            .misnavigation
          case .becameEnd:
            .becameEnd
          case .success(let ePosition):
            switch f() {
            case .misnavigation:
              .misnavigation
            case .becameEnd:
              .becameEnd
            case .success(let fPosition):
              switch g() {
              case .misnavigation:
                .misnavigation
              case .becameEnd:
                .becameEnd
              case .success(let gPosition):
                switch h() {
                case .misnavigation:
                  .misnavigation
                case .becameEnd:
                  .becameEnd
                case .success(let hPosition):
                  switch i() {
                  case .misnavigation:
                    .misnavigation
                  case .becameEnd:
                    .becameEnd
                  case .success(let iPosition):
                    .success(
                      (
                        aPosition,
                        bPosition,
                        cPosition,
                        dPosition,
                        ePosition,
                        fPosition,
                        gPosition,
                        hPosition,
                        iPosition
                      )
                    )
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
