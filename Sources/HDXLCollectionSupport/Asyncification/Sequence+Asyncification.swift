import Foundation

extension Sequence where Element: Sendable {
  
  @inlinable
  package func erasedToAsyncSequence() -> some Sendable & AsyncSequence<Element, Never> {
    AsyncStream { continuation in
      defer { continuation.finish() }
      for element in self {
        continuation.yield(element)
      }
    }
  }
  
}
