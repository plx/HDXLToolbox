import SwiftSyntax
import SwiftDiagnostics
import SwiftSyntaxMacros
import HDXLEssentialPrecursors

extension String {
  public static let mustNotBeEmpty: String = "must-not-be-empty"
  public static let attachedToExcludedArchetype: String = "attached-to-excluded-archetype"
  public static let unableToObtainRequiredValue: String = "unable-to-obtain-required-value"
  public static let requiredPropertyWasNil: String = "required-property-was-nil"
  public static let necessaryConditionWasFalse: String = "necessary-condition-was-false"
  public static let declarationOfIncorrectType: String = "declaration-of-incorrect-type"
}

extension AttachedMacroContextProtocol {
    
  public func requireDeclarationAttached(
    to requiredArchetypes: Set<DeclarationArchetype>,
    messageIdentifier: @autoclosure () -> String = .attachedToExcludedArchetype,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws {
    let declarationArchetype = try requireProperty(
      \.declarationArchetype,
      of: declaration,
      function: function,
      fileID: fileID,
      line: line,
      column: column
    )
    
    try requireThat(
      requiredArchetypes.contains(declarationArchetype),
      explanation: """
      Our archetype is \(declarationArchetype), which is not in the requird-archetypes set \(requiredArchetypes)!
      """,
      function: function,
      fileID: fileID,
      line: line,
      column: column
    )
  }

  public func requireDeclarationNotAttached(
    to excludedArchetypes: Set<DeclarationArchetype>,
    messageIdentifier: @autoclosure () -> String = .attachedToExcludedArchetype,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws {
    let declarationArchetype = try requireProperty(
      \.declarationArchetype,
      of: declaration,
      function: function,
      fileID: fileID,
      line: line,
      column: column
    )
    
    try requireThat(
      !excludedArchetypes.contains(declarationArchetype),
      explanation: """
      Our archetype is \(declarationArchetype), which is in the excluded-archetypes set \(excludedArchetypes)!
      """,
      function: function,
      fileID: fileID,
      line: line,
      column: column
    )
  }

  public func requireDeclaration<R>(
    as declarationType: R.Type,
    messageIdentifier: @autoclosure () -> String = .declarationOfIncorrectType,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws -> R where R: DeclSyntaxProtocol {
    try requireSyntaxProperty(
      \.declaration,
      as: declarationType,
      function: function,
      fileID: fileID,
      line: line,
      column: column
    )
  }

}
