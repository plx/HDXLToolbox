import Foundation

// MARK: - Throwing

public func asynchronousThrowingCartesianProduct<
  A, B,
  FA,FB
>(
  _ aa: some Sendable & AsyncSequence<A, FA>,
  _ bb: some Sendable & AsyncSequence<B, FB>
) -> some Sendable & AsyncSequence<(A, B), any Error> {
  AsyncThrowingStream<(A, B), any Error> {
    continuation
    in
    Task.detached {
      do {
        for try await a in aa {
          for try await b in bb {
            continuation.yield(
              (a,b)
            )
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
  A, B,
  FA,FB
>(
  _ aa: some Sendable & AsyncSequence<A, FA>,
  _ bb: some Sendable & AsyncSequence<B, FB>,
  _ transformation: @Sendable @escaping (A,B) async throws -> T
) -> some Sendable & AsyncSequence<T, any Error> {
  AsyncThrowingStream<T, any Error> {
    continuation
    in
    Task.detached {
      do {
        for try await a in aa {
          for try await b in bb {
            continuation.yield(
              try await transformation(a,b)
            )
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
  A, B
>(
  _ aa: some Sendable & AsyncSequence<A, Never>,
  _ bb: some Sendable & AsyncSequence<B, Never>
) -> some Sendable & AsyncSequence<(A, B), Never> {
  AsyncStream<(A, B)> {
    continuation
    in
    Task.detached {
      defer { continuation.finish() }
      for await a in aa {
        for await b in bb {
          continuation.yield(
            (a,b)
          )
        }
      }
    }
  }
}

public func transformedAsynchronousCartesianProduct<
  T,
  A, B
>(
  _ aa: some Sendable & AsyncSequence<A, Never>,
  _ bb: some Sendable & AsyncSequence<B, Never>,
  _ transformation: @Sendable @escaping (A,B) async -> T
) -> some Sendable & AsyncSequence<T, Never> {
  AsyncStream<T> {
    continuation
    in
    Task.detached {
      defer { continuation.finish() }
      for await a in aa {
        for await b in bb {
          continuation.yield(
            await transformation(a,b)
          )
        }
      }
    }
  }
}
