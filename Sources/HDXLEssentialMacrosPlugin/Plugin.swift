import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

@main
struct HDXLEssentialMacrosPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    ConditionallySendableMacro.self,
    ConditionallyEquatableMacro.self,
    ConditionallyHashableMacro.self,
    ConditionallyCodableMacro.self,
    ConditionallyEncodableMacro.self,
    ConditionallyDecodableMacro.self,
    ConditionallyAutoIdentifiableMacro.self,
    
    // not really "general-purpose" like the others:
    ConditionallyAdditiveArithmeticMacro.self,
    ConditionallyVectorArithmeticMacro.self,
    ConditionallyRandomAccessCollectionMacro.self,
    
    // COW-related
    COWPropertyMacro.self,
    COWBoxPropertyMacro.self,
    COWWrapperMacro.self,
    COWStorageMacro.self
  ]
}