import Testing
@testable import HDXLCollectionSupport

@Test(
  "`subscriptableIndex(before:)`",
  arguments: subscriptableIndexExamples
)
func testSubscriptableIndexBefore(_ example: [Int]) {
  // can never go back from the start index:
  #expect(nil == example.subscriptableIndex(before: example.startIndex))
  
  // for *non-empty* examples, we can *always* go back from any index
  // other than the start index
  if !example.isEmpty {
    for subscriptableIndex in 1..<example.count {
      // going back by one should...go back by one:
      #expect(subscriptableIndex - 1 == example.subscriptableIndex(before: subscriptableIndex))
      
      // the same concept, but expressed using the collection API itself:
      #expect(example.index(before: subscriptableIndex) == example.subscriptableIndex(before: subscriptableIndex))
    }
  }
  
  // we can *always* go back from the end index *unless* we're empty
  switch example.isEmpty {
  case true:
    #expect(nil == example.subscriptableIndex(before: example.endIndex))
  case false:
    #expect(example.count - 1 == example.subscriptableIndex(before: example.endIndex))
  }

}
