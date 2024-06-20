import Foundation

// MARK: - Throwing

public func asynchronousThrowingCartesianProduct<
  A, B, C, D, E, F, G, H, I,
  FA,FB,FC,FD,FE,FF,FG,FH,FI
>(
  _ aa: some Sendable & AsyncSequence<A, FA>,
  _ bb: some Sendable & AsyncSequence<B, FB>,
  _ cc: some Sendable & AsyncSequence<C, FC>,
  _ dd: some Sendable & AsyncSequence<D, FD>,
  _ ee: some Sendable & AsyncSequence<E, FE>,
  _ ff: some Sendable & AsyncSequence<F, FF>,
  _ gg: some Sendable & AsyncSequence<G, FG>,
  _ hh: some Sendable & AsyncSequence<H, FH>,
  _ ii: some Sendable & AsyncSequence<I, FI>
) -> some Sendable & AsyncSequence<(A, B, C, D, E, F, G, H, I), any Error> {
  AsyncThrowingStream<(A, B, C, D, E, F, G, H, I), any Error> {
    continuation
    in
    Task.detached {
      do {
        for try await a in aa {
          for try await b in bb {
            for try await c in cc {
              for try await d in dd {
                for try await e in ee {
                  for try await f in ff {
                    for try await g in gg {
                      for try await h in hh {
                        for try await i in ii {
                          continuation.yield(
                            (a,b,c,d,e,f,g,h,i)
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
        continuation.finish()
      }
      catch {
        continuation.finish(throwing: error)
      }
    }
  }
}

public func transformedThrowingAsynchronousCartesianProduct<
  T,
  A, B, C, D, E, F, G, H, I,
  FA,FB,FC,FD,FE,FF,FG,FH,FI
>(
  _ aa: some Sendable & AsyncSequence<A, FA>,
  _ bb: some Sendable & AsyncSequence<B, FB>,
  _ cc: some Sendable & AsyncSequence<C, FC>,
  _ dd: some Sendable & AsyncSequence<D, FD>,
  _ ee: some Sendable & AsyncSequence<E, FE>,
  _ ff: some Sendable & AsyncSequence<F, FF>,
  _ gg: some Sendable & AsyncSequence<G, FG>,
  _ hh: some Sendable & AsyncSequence<H, FH>,
  _ ii: some Sendable & AsyncSequence<I, FI>,
  _ transformation: @Sendable @escaping (A,B,C,D,E,F,G,H,I) async throws -> T
) -> some Sendable & AsyncSequence<T, any Error> {
  AsyncThrowingStream<T, any Error> {
    continuation
    in
    Task.detached {
      do {
        for try await a in aa {
          for try await b in bb {
            for try await c in cc {
              for try await d in dd {
                for try await e in ee {
                  for try await f in ff {
                    for try await g in gg {
                      for try await h in hh {
                        for try await i in ii {
                          continuation.yield(
                            try await transformation(a,b,c,d,e,f,g,h,i)
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
        continuation.finish()
      }
      catch {
        continuation.finish(throwing: error)
      }
    }
  }
}

// MARK: - Non-Throwing

public func asynchronousCartesianProduct<
  A, B, C, D, E, F, G, H, I
>(
  _ aa: some Sendable & AsyncSequence<A, Never>,
  _ bb: some Sendable & AsyncSequence<B, Never>,
  _ cc: some Sendable & AsyncSequence<C, Never>,
  _ dd: some Sendable & AsyncSequence<D, Never>,
  _ ee: some Sendable & AsyncSequence<E, Never>,
  _ ff: some Sendable & AsyncSequence<F, Never>,
  _ gg: some Sendable & AsyncSequence<G, Never>,
  _ hh: some Sendable & AsyncSequence<H, Never>,
  _ ii: some Sendable & AsyncSequence<I, Never>
) -> some Sendable & AsyncSequence<(A, B, C, D, E, F, G, H, I), Never> {
  AsyncStream<(A, B, C, D, E, F, G, H, I)> {
    continuation
    in
    Task.detached {
      defer { continuation.finish() }
      for await a in aa {
        for await b in bb {
          for await c in cc {
            for await d in dd {
              for await e in ee {
                for await f in ff {
                  for await g in gg {
                    for await h in hh {
                      for await i in ii {
                        continuation.yield(
                          (a,b,c,d,e,f,g,h,i)
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
  }
}

public func transformedAsynchronousCartesianProduct<
  T,
  A, B, C, D, E, F, G, H, I
>(
  _ aa: some Sendable & AsyncSequence<A, Never>,
  _ bb: some Sendable & AsyncSequence<B, Never>,
  _ cc: some Sendable & AsyncSequence<C, Never>,
  _ dd: some Sendable & AsyncSequence<D, Never>,
  _ ee: some Sendable & AsyncSequence<E, Never>,
  _ ff: some Sendable & AsyncSequence<F, Never>,
  _ gg: some Sendable & AsyncSequence<G, Never>,
  _ hh: some Sendable & AsyncSequence<H, Never>,
  _ ii: some Sendable & AsyncSequence<I, Never>,
  _ transformation: @Sendable @escaping (A,B,C,D,E,F,G,H,I) async -> T
) -> some Sendable & AsyncSequence<T, Never> {
  AsyncStream<T> {
    continuation
    in
    Task.detached {
      defer { continuation.finish() }
      for await a in aa {
        for await b in bb {
          for await c in cc {
            for await d in dd {
              for await e in ee {
                for await f in ff {
                  for await g in gg {
                    for await h in hh {
                      for await i in ii {
                        continuation.yield(
                          await transformation(a,b,c,d,e,f,g,h,i)
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
  }
}
