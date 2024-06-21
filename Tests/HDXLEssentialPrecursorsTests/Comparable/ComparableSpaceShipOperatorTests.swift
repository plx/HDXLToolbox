import Testing
@testable import HDXLEssentialPrecursors

@Test(
  "`Comparable.<=>`",
  arguments: 0...5, 0...5
)
func testComparableSpaceshipOperatorImplementation(
  lhs: Int,
  rhs: Int
) {
  // "forwards check": do we get the expected result?
  if lhs < rhs {
    #expect((lhs <=> rhs) == .orderedAscending)
  } else if lhs > rhs {
    #expect((lhs <=> rhs) == .orderedDescending)
  } else {
    #expect((lhs <=> rhs) == .orderedSame)
  }
  
  // "backwards check": is our reality consistent with our result
  switch lhs <=> rhs {
  case .orderedAscending:
    #expect(lhs < rhs)
  case .orderedSame:
    #expect(lhs == rhs)
  case .orderedDescending:
    #expect(lhs > rhs)
  }
}
