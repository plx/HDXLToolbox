import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import Foundation

@main
struct HDXLToolboxPackageMacrosPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    AddChainCollectionFixedComponentsMacro.self,
    
    AddChainCollectionStorageFixedComponentsMacro.self,
    AddChainCollectionStorageVariableComponentsMacro.self,
    
    AddChainCollectionIndexCaseIterableMacro.self,
    AddChainCollectionIndexFixedComponentsMacro.self
  ]
}

