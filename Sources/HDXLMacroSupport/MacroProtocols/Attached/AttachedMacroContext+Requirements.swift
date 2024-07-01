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

extension AttachedMacroContext {
    
  public func expansionRequirement<R>(
    _ explanation: @autoclosure () -> String,
    messageIdentifier: @autoclosure () -> String = .unableToObtainRequiredValue,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column,
    _ requirement: () throws -> R
  ) throws -> R {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: explanation(), 
      subject: nil
    ) {
      try MacroExpansionFailure.withAutomaticEncapsulation(
        explanation: explanation(),
        function: function,
        fileID: fileID,
        line: line,
        column: column
      ) {
        try requirement()
      }
    }
  }

  public func expansionRequirement(
    mustBeAttachedTo requiredArchetypes: Set<DeclarationArchetype>,
    messageIdentifier: @autoclosure () -> String = .attachedToExcludedArchetype,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: "Must be attached-to only one of these declaration-types: \(requiredArchetypes)",
      subject: nil
    ) {
      guard let declarationArchetype = declaration.declarationArchetype else {
        throw MacroExpansionFailure(
          explanation: "Couldn't obtain a declaration-archtype from \(declaration)",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
      
      guard requiredArchetypes.contains(declarationArchetype) else {
        throw MacroExpansionFailure(
          explanation: "\(declaration) must be one of these: \(requiredArchetypes)!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
    }
  }

  public func expansionRequirement(
    mustNotBeAttachedTo excludedArchetypes: Set<DeclarationArchetype>,
    messageIdentifier: @autoclosure () -> String = .attachedToExcludedArchetype,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: "Must not be attached-to any of these declaration-types: \(excludedArchetypes)",
      subject: nil
    ) {
      guard let declarationArchetype = declaration.declarationArchetype else {
        throw MacroExpansionFailure(
          explanation: "Couldn't obtain a declaration-archtype from \(declaration)",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
      
      guard !excludedArchetypes.contains(declarationArchetype) else {
        throw MacroExpansionFailure(
          explanation: "\(declaration) must not be one of these: \(excludedArchetypes)!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
    }
  }

  public func expansionRequirement<R>(
    _ explanation: @autoclosure () -> String,
    messageIdentifier: @autoclosure () -> String = .unableToObtainRequiredValue,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column,
    _ requirement: () throws -> R?
  ) throws -> R {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: explanation(),
      subject: nil
    ) {
      try MacroExpansionFailure.withAutomaticEncapsulation(
        explanation: explanation(),
        function: function,
        fileID: fileID,
        line: line,
        column: column
      ) {
        guard 
          let value = try requirement()
        else {
          throw MacroExpansionFailure(
            explanation: "\(explanation())",
            details: nil,
            function: function,
            fileID: fileID,
            line: line,
            column: column
          )
        }
        
        return value
      }
    }
  }

  public func expansionRequirement<T,R>(
    property: KeyPath<T,R?>,
    of source: T,
    messageIdentifier: @autoclosure () -> String = .requiredPropertyWasNil,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws -> R where T: SyntaxProtocol {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: "Couldn't obtain \(property) from \(source)!",
      subject: source
    ) {
      guard
        let value = source[keyPath: property]
      else {
        throw MacroExpansionFailure(
          explanation: "Couldn't obtain \(property) from \(source)!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
      
      return value
    }
  }

  public func expansionRequirement<T,V,R>(
    property: KeyPath<T,V>,
    of source: T,
    as syntaxProtocol: R.Type,
    messageIdentifier: @autoclosure () -> String = .requiredPropertyWasNil,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws -> R where T: SyntaxProtocol, V: SyntaxProtocol, R: SyntaxProtocol {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: "Couldn't obtain \(property) of concrete-type \(syntaxProtocol) from \(source)!",
      subject: source
    ) {
      let value = source[keyPath: property]
      
      guard
        let downcastValue = value.as(syntaxProtocol)
      else {
        throw MacroExpansionFailure(
          explanation: "Value \(value) wasn't of the required-type \(syntaxProtocol)!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
      
      return downcastValue
    }
  }

  public func expansionRequirement<T,V,R>(
    property: KeyPath<T,V?>,
    of source: T,
    as syntaxProtocol: R.Type,
    messageIdentifier: @autoclosure () -> String = .requiredPropertyWasNil,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws -> R where T: SyntaxProtocol, V: SyntaxProtocol, R: SyntaxProtocol {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: "Couldn't obtain \(property) of concrete-type \(syntaxProtocol) from \(source)!",
      subject: source
    ) {
      guard
        let value = source[keyPath: property]
      else {
        throw MacroExpansionFailure(
          explanation: "Couldn't obtain \(property) from \(source)!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
      
      guard
        let downcastValue = value.as(syntaxProtocol)
      else {
        throw MacroExpansionFailure(
          explanation: "Value \(value) wasn't of the required-type \(syntaxProtocol)!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }

      return downcastValue
    }
  }

  public func expansionRequirement<R>(
    declarationAs declarationType: R.Type,
    messageIdentifier: @autoclosure () -> String = .declarationOfIncorrectType,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws -> R where R: DeclSyntaxProtocol {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: "`declaration` needs to be of-type \(declarationType)!",
      subject: declaration
    ) {
      guard
        let value = declaration.as(declarationType)
      else {
        throw MacroExpansionFailure(
          explanation: "`declaration` isn't of-type \(declarationType)!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
      
      return value
    }
  }

  public func expansionRequirement<R>(
    declarationAs declarationGroupType: R.Type,
    messageIdentifier: @autoclosure () -> String = .declarationOfIncorrectType,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws -> R where R: DeclGroupSyntax, Declaration: DeclGroupSyntax {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: "`declaration` needs to be of-type \(declarationGroupType)!",
      subject: declaration
    ) {
      guard
        let value = declaration.as(declarationGroupType)
      else {
        throw MacroExpansionFailure(
          explanation: "`declaration` isn't of-type \(declarationGroupType)!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
      
      return value
    }
  }

  public func expansionRequirement(
    logicalCondition: @autoclosure () -> String,
    messageIdentifier: @autoclosure () -> String = .necessaryConditionWasFalse,
    subject: @autoclosure () -> (any SyntaxProtocol)? = nil,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column,
    _ predicate: () throws -> Bool
  ) throws {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: "We need `\(logicalCondition())` to be `true`!",
      subject: subject()
    ) {
      guard
        try MacroExpansionFailure.withAutomaticEncapsulation(
          explanation: "We need `\(logicalCondition())` -> `false`!",
          function: function,
          fileID: fileID,
          line: line,
          column: column,
          predicate
        )
      else {
        throw MacroExpansionFailure(
          explanation: "We need `\(logicalCondition())` -> `false`!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
    }
  }

  public func expansionRequirement<R>(
    mustNotBeEmpty values: R,
    messageIdentifier: @autoclosure () -> String = .mustNotBeEmpty,
    subject: @autoclosure () -> (any SyntaxProtocol)? = nil,
    function: StaticString = #function,
    fileID: StaticString = #fileID,
    line: UInt = #line,
    column: UInt = #column
  ) throws -> R where R: Collection {
    try withAutomaticRecordingForRequiredOperation(
      messageIdentifier: messageIdentifier(),
      explanation: "We need non-empty `\(values)` here!",
      subject: subject()
    ) {
      guard !values.isEmpty else {
        throw MacroExpansionFailure(
          explanation: "We need non-empty `\(values)`!",
          details: nil,
          function: function,
          fileID: fileID,
          line: line,
          column: column
        )
      }
      
      return values
    }
  }

}
