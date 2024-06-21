import Foundation
import Testing
@testable import HDXLEssentialPrecursors

@Test("Ordering Implications: `.equal`")
func testEqualOrderingRelationshipImplications() {
  verify(
    orderingRelation: .equal,
    .isNotImpliedBy,
    comparisonResult: .orderedAscending
  )
  verify(
    orderingRelation: .equal,
    .isImpliedBy,
    comparisonResult: .orderedSame
  )
  verify(
    orderingRelation: .equal,
    .isNotImpliedBy,
    comparisonResult: .orderedDescending
  )
}

@Test("Ordering Implications: `.lessThan`")
func testLessThanOrderingRelationshipImplications() {
  verify(
    orderingRelation: .lessThan,
    .isImpliedBy,
    comparisonResult: .orderedAscending
  )
  verify(
    orderingRelation: .lessThan,
    .isNotImpliedBy,
    comparisonResult: .orderedSame
  )
  verify(
    orderingRelation: .lessThan,
    .isNotImpliedBy,
    comparisonResult: .orderedDescending
  )
}
  
@Test("Ordering Implications: `.lessThanOrEqual`")
func testLessThanOrEqualOrderingRelationshipImplications() {
  verify(
    orderingRelation: .lessThanOrEqual,
    .isImpliedBy,
    comparisonResult: .orderedAscending
  )
  verify(
    orderingRelation: .lessThanOrEqual,
    .isImpliedBy,
    comparisonResult: .orderedSame
  )
  verify(
    orderingRelation: .lessThanOrEqual,
    .isNotImpliedBy,
    comparisonResult: .orderedDescending
  )
}

@Test("Ordering Implications: `.greaterThan`")
func testGreaterThanOrderingRelationshipImplications() {
  verify(
    orderingRelation: .greaterThan,
    .isNotImpliedBy,
    comparisonResult: .orderedAscending
  )
  verify(
    orderingRelation: .greaterThan,
    .isNotImpliedBy,
    comparisonResult: .orderedSame
  )
  verify(
    orderingRelation: .greaterThan,
    .isImpliedBy,
    comparisonResult: .orderedDescending
  )
}
 
@Test("Ordering Implications: `.greaterThanOrEqual`")
func testGreaterThanOrEqualOrderingRelationshipImplications() {
  verify(
    orderingRelation: .greaterThanOrEqual,
    .isNotImpliedBy,
    comparisonResult: .orderedAscending
  )
  verify(
    orderingRelation: .greaterThanOrEqual,
    .isImpliedBy,
    comparisonResult: .orderedSame
  )
  verify(
    orderingRelation: .greaterThanOrEqual,
    .isImpliedBy,
    comparisonResult: .orderedDescending
  )
}
  
@Test(
  "Implication Shorthands",
  arguments: [
    ComparisonResult.orderedAscending,
    ComparisonResult.orderedSame,
    ComparisonResult.orderedDescending
  ]
)
func testImplicationShorthands(comparisonResult: ComparisonResult) {
  #expect(
    comparisonResult.implies(.equal) 
    ==
    comparisonResult.impliesEqual
  )
  #expect(
    comparisonResult.implies(.lessThan)
    ==
    comparisonResult.impliesLessThan
  )
  #expect(
    comparisonResult.implies(.lessThanOrEqual)
    ==
    comparisonResult.impliesLessThanOrEqual
  )
  #expect(
    comparisonResult.implies(.greaterThan)
    ==
    comparisonResult.impliesGreaterThan
  )
  #expect(
    comparisonResult.implies(.greaterThanOrEqual)
    ==
    comparisonResult.impliesGreaterThanOrEqual
  )
}

fileprivate enum Implication: Hashable, CaseIterable, CaseNameAwareEnumeration, CustomStringConvertible, CustomDebugStringConvertible {
  case isImpliedBy
  case isNotImpliedBy
  
  var booleanRepresentation: Bool {
    switch self {
    case .isImpliedBy:
      true
    case .isNotImpliedBy:
      false
    }
  }
  
  var caseNameWithoutLeadingDot: String {
    switch self {
    case .isImpliedBy:
      "isImpliedBy"
    case .isNotImpliedBy:
      "isNotImpliedBy"
    }
  }
}

fileprivate func verify(
  orderingRelation: OrderingRelation,
  _ implication: Implication,
  comparisonResult: ComparisonResult,
  function: StaticString = #function,
  sourceLocation: SourceLocation = SourceLocation()
) {
  #expect(
    comparisonResult.implies(orderingRelation) == implication.booleanRepresentation,
    """
    Ordering-relationship implication failure:
    
    - expectation: `\(String(reflecting: comparisonResult)).implies(\(String(reflecting: orderingRelation))) => \(implication.booleanRepresentation)
    - result: `\(String(reflecting: comparisonResult)).implies(\(String(reflecting: orderingRelation)))` => \(comparisonResult.implies(orderingRelation))
    - function: \(function)
    - fileID: \(sourceLocation.fileID)
    - line: \(sourceLocation.line)
    - column: \(sourceLocation.column)
    """,
    sourceLocation: sourceLocation
  )
}
