import Testing
@testable import HDXLCollectionSupport

@Test(
  "`Collection.subscriptableIndex(after:)`",
  arguments: subscriptableIndexExamples
)
func testSubscriptableIndexAfter(_ example: [Int]) throws {
  guard !example.isEmpty else {
    #expect(example.startIndex == example.endIndex) // <- double-check our understanding
    #expect(nil == example.subscriptableIndex(after: example.startIndex))
    return
  }
  
  for subscriptableIndex in 0..<(example.count - 1) {
    // going forward by one should...go back by one:
    #expect(subscriptableIndex + 1 == example.subscriptableIndex(after: subscriptableIndex))
    
    // the same concept, but expressed using the collection API itself:
    #expect(example.index(after: subscriptableIndex) == example.subscriptableIndex(after: subscriptableIndex))
  }
  
  // we can *never* advance from the final subscriptable index
  let finalSubscriptableIndex = try #require(example.finalSubscriptableIndex)
  #expect(nil == example.subscriptableIndex(after: finalSubscriptableIndex))
  
  // we correctly handle *trying* to advance from the end index
  #expect(nil == example.subscriptableIndex(after: example.endIndex))
}

@Test(
  "`Collection.firstSubscriptableIndex`",
  arguments: subscriptableIndexExamples
)
func testFirstSubscriptableIndex(_ example: [Int]) {
  switch example.firstSubscriptableIndex {
  case .none:
    #expect(example.isEmpty)
  case .some(let firstSubscriptableIndex):
    #expect(firstSubscriptableIndex == 0)
    #expect(firstSubscriptableIndex == example.startIndex)
    // ^ same concept, expressed concretely then in collection-api terms
  }
}

@Test(
  "`Collection.finalSubscriptableIndex`",
  arguments: subscriptableIndexExamples
)
func testFinalSubscriptableIndex(_ example: [Int]) {
  switch example.finalSubscriptableIndex {
  case .none:
    #expect(example.isEmpty)
  case .some(let finalSubscriptableIndex):
    #expect(finalSubscriptableIndex == example.count - 1)
    #expect(finalSubscriptableIndex == example.index(before: example.endIndex))
    // ^ same concept, expressed concretely then in collection-api terms
  }
}

@Test(
  "`Collection.canSubscript(index:)",
  arguments: subscriptableIndexExamples
)
func testCanSubscriptIndex(_ example: [Int]) {
  #expect(!example.canSubscript(index: example.count))
  #expect(!example.canSubscript(index: example.endIndex))
  // ^ same concept, expressed concretely then in collection-api terms
  
  for index in example.indices {
    #expect(example.canSubscript(index: index))
  }
}
