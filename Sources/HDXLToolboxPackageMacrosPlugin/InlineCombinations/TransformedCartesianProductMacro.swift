//import Foundation
//import SwiftSyntax
//import SwiftParser
//import SwiftSyntaxMacros
//import SwiftSyntaxBuilder
//import SwiftDiagnostics
//import HDXLEssentialPrecursors
//import HDXLMacroSupport
//
//// MARK: InlineCartesianProductMacro
//
//public struct InlineTransformedCartesianProductMacro : DiagnosticDomainAwareMacro { }
//
//// MARK: - ContextualizedFreestandingMacro
//
//extension InlineTransformedCartesianProductMacro: ContextualizedExpressionMacro {
//  
//  public static func contextualizedExpansion(
//    in freestandingContext: some ExpressionMacroContextProtocol
//  ) throws -> ExprSyntax {
//    try freestandingContext.requireThat(
//      freestandingContext.macroInvocationNode.arguments.count == 3,
//      explanation: "Need exactly three arguments: the result-element type, a tuple of collections, and a trailing-closure with the transformation to apply."
//    )
//    
//    let presumptiveClosureExpression = try freestandingContext.requireSyntaxProperty(
//      \.arguments.last,
//       of: freestandingContext.macroInvocationNode,
//       as: ClosureExprSyntax.self
//    )
//    
//    let presumptiveTypeName = try freestandingContext.requireProperty(
//      \.arguments.first,
//       of: freestandingContext.macroInvocationNode
//    )
//    
//    // hacky but not sure the right construct to use:
//    let elementName = try freestandingContext.requireValue(
//      "Trying to go from `T.self` -> `T`?"
//    ) {
//      try /(\w)+\.self/.wholeMatch(in: "\(presumptiveTypeName.trimmed)")?.output.1
//    }
//    
//    try freestandingContext.requireThat(
//      !elementName.isEmpty
//    )
//    
//    let accumulatorUniqueName = freestandingContext.expansionContext.makeUniqueName("accumulator")
//    let closureUniqueName = freestandingContext.expansionContext.makeUniqueName("trailingClosure")
//    let totalCountUniqueName = freestandingContext.expansionContext.makeUniqueName("totalElementCount")
//        
//    let presumptiveArgumentExpressionsWithUniqueNames = try freestandingContext.requireNonEmptyValues(
//      freestandingContext
//        .macroInvocationNode
//        .arguments
//        .dropLast()
//        .enumerated()
//        .map { index, expression in
//          (
//            expression,
//            freestandingContext.expansionContext.makeUniqueName("iterationSource\(index)"),
//            freestandingContext.expansionContext.makeUniqueName("iterationValue\(index)")
//          )
//        }
//    )
//    
//    let totalCountProductExpression: String = presumptiveArgumentExpressionsWithUniqueNames.map { (expression, uniqueSourceName, uniqueValueName) in
//      uniqueSourceName.text
//    }.joined(separator: " * ")
//
//    let localSourceDeclarations: [String] = presumptiveArgumentExpressionsWithUniqueNames.map { (expression, uniqueSourceName, uniqueValueName) in
//      """
//      let \(uniqueSourceName) = \(expression)
//      """
//    }
//
//    let localValuesAsParameters: [String] = presumptiveArgumentExpressionsWithUniqueNames.map { (expression, uniqueSourceName, uniqueValueName) in
//      """
//      \(uniqueValueName)
//      """
//    }
//
//    let localIterationOpenings: [String] = presumptiveArgumentExpressionsWithUniqueNames.map { (expression, uniqueSourceName, uniqueValueName) in
//      """
//      for \(uniqueValueName) in \(uniqueSourceName) {
//      """
//    }
//    
//    let localIterationClosings: [String] = presumptiveArgumentExpressionsWithUniqueNames.map { (expression, uniqueSourceName, uniqueValueName) in
//      """
//      } // end-iteration for \(uniqueSourceName)
//      """
//    }
//    
//    return """
//    {
//      // capture all arguments into local variables (necessary b/c we might get "unevaluated syntax" as arguments.
//      \(raw: closureUniqueName) = \(presumptiveClosureExpression)
//
//      // capture all arguments into local variables (necessary b/c we might get "unevaluated syntax" as arguments.
//      \(raw: localSourceDeclarations.joined(separator: "\n"))
//    
//      // calculate the expected total count
//      let \(raw: totalCountUniqueName) = \(raw: totalCountProductExpression)
//
//      // setup the accumulator
//      var \(raw: accumulatorUniqueName): [\(raw: elementName)] = []
//      \(raw: accumulatorUniqueName).reserveCapacity(\(raw: totalCountUniqueName))
//    
//      // start iterating:
//      \(raw: localIterationOpenings.joined(separator: "\n"))
//    
//      // append value:
//      \(raw: accumulatorUniqueName).append(
//        \(raw: closureUniqueName)(
//          \(raw: localValuesAsParameters.joined(separator: ",\n"))
//        )
//      )
//    
//      // stop iterating:
//      \(raw: localIterationClosings)
//    
//      // return result:
//      return \(raw: accumulatorUniqueName)
//    }()
//    """
//  }
//  
//}
//
