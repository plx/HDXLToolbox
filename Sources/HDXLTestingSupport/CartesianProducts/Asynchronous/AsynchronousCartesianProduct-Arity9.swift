import Foundation

public func transformedAsynchronousCartesianProduct<
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
