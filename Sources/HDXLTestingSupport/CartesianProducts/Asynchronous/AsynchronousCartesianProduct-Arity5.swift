import Foundation

// MARK: - Throwing

public func asynchronousThrowingCartesianProduct<
  A, B, C, D, E,
  FA,FB,FC,FD,FE
>(
  _ aa: some Sendable & AsyncSequence<A, FA>,
  _ bb: some Sendable & AsyncSequence<B, FB>,
  _ cc: some Sendable & AsyncSequence<C, FC>,
  _ dd: some Sendable & AsyncSequence<D, FD>,
  _ ee: some Sendable & AsyncSequence<E, FE>
) -> some Sendable & AsyncSequence<(A, B, C, D, E), any Error> {
  AsyncThrowingStream<(A, B, C, D, E), any Error> {
    continuation
    in
    Task.detached {
      do {
        for try await a in aa {
          for try await b in bb {
            for try await c in cc {
              for try await d in dd {
                for try await e in ee {
                  continuation.yield(
                    (a,b,c,d,e)
                  )
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
  A, B, C, D, E,
  FA,FB,FC,FD,FE
>(
  _ aa: some Sendable & AsyncSequence<A, FA>,
  _ bb: some Sendable & AsyncSequence<B, FB>,
  _ cc: some Sendable & AsyncSequence<C, FC>,
  _ dd: some Sendable & AsyncSequence<D, FD>,
  _ ee: some Sendable & AsyncSequence<E, FE>,
  _ transformation: @Sendable @escaping (A,B,C,D,E) async throws -> T
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
                  continuation.yield(
                    try await transformation(a,b,c,d,e)
                  )
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
  A, B, C, D, E
>(
  _ aa: some Sendable & AsyncSequence<A, Never>,
  _ bb: some Sendable & AsyncSequence<B, Never>,
  _ cc: some Sendable & AsyncSequence<C, Never>,
  _ dd: some Sendable & AsyncSequence<D, Never>,
  _ ee: some Sendable & AsyncSequence<E, Never>
) -> some Sendable & AsyncSequence<(A, B, C, D, E), Never> {
  AsyncStream<(A, B, C, D, E)> {
    continuation
    in
    Task.detached {
      defer { continuation.finish() }
      for await a in aa {
        for await b in bb {
          for await c in cc {
            for await d in dd {
              for await e in ee {
                continuation.yield(
                  (a,b,c,d,e)
                )
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
  A, B, C, D, E
>(
  _ aa: some Sendable & AsyncSequence<A, Never>,
  _ bb: some Sendable & AsyncSequence<B, Never>,
  _ cc: some Sendable & AsyncSequence<C, Never>,
  _ dd: some Sendable & AsyncSequence<D, Never>,
  _ ee: some Sendable & AsyncSequence<E, Never>,
  _ transformation: @Sendable @escaping (A,B,C,D,E) async -> T
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
                continuation.yield(
                  await transformation(a,b,c,d,e)
                )
              }
            }
          }
        }
      }
    }
  }
}
