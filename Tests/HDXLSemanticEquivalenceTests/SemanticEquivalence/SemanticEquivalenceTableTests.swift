import Foundation
import XCTest
//import HDXLCommonUtilities
import HDXLTestingUtilities
import HDXLAlgebraicUtilities
@testable import HDXLSemanticEquivalence

class SemanticEquivalenceTableTests: XCTestCase {
  
  let testDepth: Int = 10
  lazy var testRange = 0...testDepth
  
  // ------------------------------------------------------------------------ //
  // MARK: PrioritizedString Setup
  // ------------------------------------------------------------------------ //
  
  lazy var foos = testRange.map {
    PrioritizedString(
      label: "foo",
      priority: $0
    )
  }
  
  lazy var bars = testRange.map {
    PrioritizedString(
      label: "bar",
      priority: $0
    )
  }
  
  lazy var bazs = testRange.map {
    PrioritizedString(
      label: "baz",
      priority: $0
    )
  }
  
  lazy var quuxes = testRange.map {
    PrioritizedString(
      label: "quux",
      priority: $0
    )
  }

  lazy var highestFoo = foos[testDepth]
  lazy var highestBar = bars[testDepth]
  lazy var highestBaz = bazs[testDepth]
  lazy var highestQuux = quuxes[testDepth]
  
  func testSemanticEquivalenceTableAgainstCannedPrioritizedStrings() {
    haltingOnFirstError {
      
      let completeTable = SemanticEquivalenceTable<PrioritizedString>(
        elements: ChainCollection(foos, bars, bazs)
      )
      XCTAssertTrue(
        completeTable.isValid
      )
      XCTAssertFalse(
        completeTable.isEmpty
      )

      XCTAssertNotNil(
        completeTable.equivalenceClass(
          forElement: highestFoo
        )
      )
      XCTAssertNotNil(
        completeTable.equivalenceClass(
          forElement: highestBar
        )
      )
      XCTAssertNotNil(
        completeTable.equivalenceClass(
          forElement: highestBaz
        )
      )
      
      XCTAssertEqual(
        completeTable.equivalenceClass(
          forElement: highestFoo
        ),
        completeTable.equivalenceClass(
          forElement: highestFoo
        )
      )
      XCTAssertEqual(
        completeTable.equivalenceClass(
          forElement: highestBar
        ),
        completeTable.equivalenceClass(
          forElement: highestBar
        )
      )
      XCTAssertEqual(
        completeTable.equivalenceClass(
          forElement: highestBaz
        ),
        completeTable.equivalenceClass(
          forElement: highestBaz
        )
      )


      XCTAssertNotEqual(
        completeTable.equivalenceClass(
          forElement: highestFoo
        ),
        completeTable.equivalenceClass(
          forElement: highestBar
        )
      )
      XCTAssertNotEqual(
        completeTable.equivalenceClass(
          forElement: highestFoo
        ),
        completeTable.equivalenceClass(
          forElement: highestBaz
        )
      )
      XCTAssertNotEqual(
        completeTable.equivalenceClass(
          forElement: highestBar
        ),
        completeTable.equivalenceClass(
          forElement: highestBaz
        )
      )

      for foo in foos {
        XCTAssertTrue(
          completeTable.contains(
            element: foo
          )
        )
        XCTAssertEqual(
          highestFoo,
          completeTable.referenceElement(
            forElement: foo
          )
        )
      }
      for bar in bars {
        XCTAssertTrue(
          completeTable.contains(
            element: bar
          )
        )
        XCTAssertEqual(
          highestBar,
          completeTable.referenceElement(
            forElement: bar
          )
        )
      }
      for baz in bazs {
        XCTAssertTrue(
          completeTable.contains(
            element: baz
          )
        )
        XCTAssertEqual(
          highestBaz,
          completeTable.referenceElement(
            forElement: baz
          )
        )
      }
      for quux in quuxes {
        XCTAssertFalse(
          completeTable.contains(
            element: quux
          )
        )
        XCTAssertNil(
          completeTable.referenceElement(
            forElement: quux
          )
        )
      }
      
      // check our results make sense:
      
      var expectedFooClass = SemanticEquivalenceClass<PrioritizedString>(
        referenceElement: highestFoo
      )
      expectedFooClass._equivalentElements = foos.dropLast()
      
      var expectedBarClass = SemanticEquivalenceClass<PrioritizedString>(
        referenceElement: highestBar
      )
      expectedBarClass._equivalentElements = bars.dropLast()
      
      var expectedBazClass = SemanticEquivalenceClass<PrioritizedString>(
        referenceElement: highestBaz
      )
      expectedBazClass._equivalentElements = bazs.dropLast()
      
      for foo in foos {
        XCTAssertEqual(
          completeTable.equivalenceClass(forElement: foo),
          expectedFooClass
        )
      }

      for bar in bars {
        XCTAssertEqual(
          completeTable.equivalenceClass(forElement: bar),
          expectedBarClass
        )
      }
      
      for baz in bazs {
        XCTAssertEqual(
          completeTable.equivalenceClass(forElement: baz),
          expectedBazClass
        )
      }
      
      for quux in quuxes {
        XCTAssertNil(
          completeTable.equivalenceClass(forElement: quux)
        )
      }
      
      
      let removalReferences = [
        highestFoo,
        highestBar,
        highestBaz
      ]

      // for our first trick: try removing just-x:
      for removalTarget in ChainCollection(foos,bars,bazs,quuxes) {
        var scratchTable = completeTable
        scratchTable.removeEquivalenceClassesSatisfying(predicate: {$0.contains(element: removalTarget)})
        for removalCandidate in removalReferences {
          XCTAssertEqual(
            removalTarget.hasEquivalentSemantics(to: removalCandidate),
            !scratchTable.contains(element: removalCandidate)
          )
          XCTAssertEqual(
            removalTarget.hasEquivalentSemantics(to: removalCandidate),
            nil == scratchTable.equivalenceClass(forElement: removalCandidate)
          )
          XCTAssertEqual(
            removalTarget.hasEquivalentSemantics(to: removalCandidate),
            nil == scratchTable.referenceElement(forElement: removalCandidate)
          )
        }
        XCTAssertFalse(
          scratchTable.contains(element: highestQuux)
        )
        XCTAssertNil(
          scratchTable.equivalenceClass(forElement: highestQuux)
        )
        XCTAssertNil(
          scratchTable.referenceElement(forElement: highestQuux)
        )
      }

      // now for our next trick: try removing all-but-x:
      for removalTarget in ChainCollection(foos,bars,bazs,quuxes) {
        var scratchTable = completeTable
        scratchTable.removeEquivalenceClassesFailing(predicate: {$0.contains(element: removalTarget)})
        for removalCandidate in removalReferences {
          XCTAssertEqual(
            removalTarget.hasEquivalentSemantics(to: removalCandidate),
            scratchTable.contains(element: removalCandidate)
          )
          XCTAssertEqual(
            removalTarget.hasEquivalentSemantics(to: removalCandidate),
            nil != scratchTable.equivalenceClass(forElement: removalCandidate)
          )
          XCTAssertEqual(
            removalTarget.hasEquivalentSemantics(to: removalCandidate),
            nil != scratchTable.referenceElement(forElement: removalCandidate)
          )
        }
        XCTAssertFalse(
          scratchTable.contains(element: highestQuux)
        )
        XCTAssertNil(
          scratchTable.equivalenceClass(forElement: highestQuux)
        )
        XCTAssertNil(
          scratchTable.referenceElement(forElement: highestQuux)
        )
      }
    }
  }

  // ------------------------------------------------------------------------ //
  // MARK: PrioritizedStringDuo Setup
  // ------------------------------------------------------------------------ //
  
  let labels: [String] = ["foo", "bar", "baz", "quux"]
  let captions: [String] = ["alpha", "beta", "gamma"]
  let priorities: [Int] = [1, 2, 3]
  let repeatCount: Int = 3
  lazy var repeats: Range<Int> = 0..<repeatCount
  
  lazy var unorganizedTestValues: [PrioritizedStringDuo] = CartesianProduct(
    repeats,
    labels,
    captions,
    priorities
  ).asTuples().map {
    (_,label,caption,priority) -> PrioritizedStringDuo
    in
    return PrioritizedStringDuo(
      label: label,
      caption: caption,
      priority: priority
    )
  }
  
  func testSemanticEquivalenceTableAgainstCannedPrioritizedStringDuos() {
    haltingOnFirstError {
      
      let table = SemanticEquivalenceTable<PrioritizedStringDuo>(
        elements: unorganizedTestValues
      )
      XCTAssertTrue(table.isValid)
      
      for example in unorganizedTestValues {
        XCTAssertTrue(
          table.contains(element: example)
        )
        let referenceElement = try! XCTUnwrap(table.referenceElement(forElement: example))
        XCTAssertTrue(
          referenceElement.hasEquivalentSemantics(to: example)
        )
        XCTAssertEqual(
          referenceElement.label,
          example.label
        )
        XCTAssertEqual(
          referenceElement.caption,
          example.caption
        )
        XCTAssertGreaterThanOrEqual(
          referenceElement.priority,
          example.priority
        )

        let equivalenceClass = try! XCTUnwrap(table.equivalenceClass(forElement: example))
        XCTAssertTrue(
          equivalenceClass.contains(element: example)
        )
        XCTAssertTrue(
          equivalenceClass.isValid
        )
        
        for otherEquivalenceClass in table.equivalenceClasses {
          XCTAssertEqual(
            otherEquivalenceClass == equivalenceClass,
            otherEquivalenceClass.contains(element: example)
          )
        }
        
      }
      
      for (x,y) in CartesianProduct(unorganizedTestValues, unorganizedTestValues).asTuples() {
        let xClass = try! XCTUnwrap(table.equivalenceClass(forElement: x))
        XCTAssertTrue(xClass.contains(element: x))
        let yClass = try! XCTUnwrap(table.equivalenceClass(forElement: y))
        XCTAssertTrue(yClass.contains(element: y))
        XCTAssertEqual(
          x.hasEquivalentSemantics(to: y),
          xClass == yClass
        )
      }
      
    }
  }

}
