import Foundation

// MARK: - Throwing

public func asynchronousThrowingCartesianProduct<
  A, B, C, D, E, F,
  FA,FB,FC,FD,FE,FF
>(
  _ aa: some Sendable & AsyncSequence<A, FA>,
  _ bb: some Sendable & AsyncSequence<B, FB>,
  _ cc: some Sendable & AsyncSequence<C, FC>,
  _ dd: some Sendable & AsyncSequence<D, FD>,
  _ ee: some Sendable & AsyncSequence<E, FE>,
  _ ff: some Sendable & AsyncSequence<F, FF>
) -> some Sendable & AsyncSequence<(A, B, C, D, E, F), any Error> {
  AsyncThrowingStream<(A, B, C, D, E, F), any Error> {
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
                    continuation.yield(
                      (a,b,c,d,e,f)
                    )
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
  A, B, C, D, E, F,
  FA,FB,FC,FD,FE,FF
>(
  _ aa: some Sendable & AsyncSequence<A, FA>,
  _ bb: some Sendable & AsyncSequence<B, FB>,
  _ cc: some Sendable & AsyncSequence<C, FC>,
  _ dd: some Sendable & AsyncSequence<D, FD>,
  _ ee: some Sendable & AsyncSequence<E, FE>,
  _ ff: some Sendable & AsyncSequence<F, FF>,
  _ transformation: @Sendable @escaping (A,B,C,D,E,F) async throws -> T
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
                    continuation.yield(
                      try await transformation(a,b,c,d,e,f)
                    )
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
  A, B, C, D, E, F
>(
  _ aa: some Sendable & AsyncSequence<A, Never>,
  _ bb: some Sendable & AsyncSequence<B, Never>,
  _ cc: some Sendable & AsyncSequence<C, Never>,
  _ dd: some Sendable & AsyncSequence<D, Never>,
  _ ee: some Sendable & AsyncSequence<E, Never>,
  _ ff: some Sendable & AsyncSequence<F, Never>
) -> some Sendable & AsyncSequence<(A, B, C, D, E, F), Never> {
  AsyncStream<(A, B, C, D, E, F)> {
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
                  continuation.yield(
                    (a,b,c,d,e,f)
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

public func transformedAsynchronousCartesianProduct<
  T,
  A, B, C, D, E, F
>(
  _ aa: some Sendable & AsyncSequence<A, Never>,
  _ bb: some Sendable & AsyncSequence<B, Never>,
  _ cc: some Sendable & AsyncSequence<C, Never>,
  _ dd: some Sendable & AsyncSequence<D, Never>,
  _ ee: some Sendable & AsyncSequence<E, Never>,
  _ ff: some Sendable & AsyncSequence<F, Never>,
  _ transformation: @Sendable @escaping (A,B,C,D,E,F) async -> T
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
                  continuation.yield(
                    await transformation(a,b,c,d,e,f)
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
