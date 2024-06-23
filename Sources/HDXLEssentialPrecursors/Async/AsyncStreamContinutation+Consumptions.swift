
extension AsyncStream.Continuation {
  
  @inlinable
  package func yield(everythingFrom values: some Sequence<Element>) {
    for value in values {
      yield(value)
    }
  }

  @inlinable
  package func yield<T>(
    everythingFrom values: some Sequence<T>,
    transformedBy transformation: (T) -> Element
  ) {
    for value in values {
      yield(transformation(value))
    }
  }

  @inlinable
  package func yield(
    everythingFrom values: some AsyncSequence<Element, Never>
  ) async {
    for await value in values {
      yield(value)
    }
  }

  @inlinable
  package func yield<T>(
    everythingFrom values: some AsyncSequence<T, Never>,
    transformedBy transformation: @Sendable (T) -> Element
  ) async {
    for await value in values {
      yield(transformation(value))
    }
  }

  @inlinable
  package func yield<T>(
    everythingFrom values: some AsyncSequence<T, Never>,
    transformedBy transformation: @Sendable (T) async -> Element
  ) async {
    for await value in values {
      yield(await transformation(value))
    }
  }

}
