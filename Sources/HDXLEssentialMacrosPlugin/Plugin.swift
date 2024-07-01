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
    ConditionallyRandomAccessCollectionMacro.self,
    
    // unconditional conformances:
    AlwaysSendableMacro.self,
    AlwaysEquatableMacro.self,
    AlwaysComparableMacro.self,
    AlwaysHashableMacro.self,
    AlwaysEncodableMacro.self,
    AlwaysDecodableMacro.self,
    AlwaysCodableMacro.self,
    AlwaysCaseIterableMacro.self,    
    
    // storage-based conveniences:
    StorageComparableMacro.self,
    StorageCustomStringConvertibleMacro.self,
    StorageCustomDebugStringConvertibleMacro.self,
    
    //
    
    // COW-related
    COWPropertyMacro.self,
    COWBoxPropertyMacro.self,
    COWWrapperMacro.self,
    COWStorageMacro.self,
    
    // Stringification
    ConstructorDebugDescriptionMacro.self,
    
    // Assistance
    PreferredMemberwiseInitializerMacro.self,
    
    // Algebraic
    //    CollectionsWithCommonElementTypeMacro.self,
    DeclareChainCollectionStorageMacro.self,
    AddAlgebraicProductLikeStringificationMacro.self,
    AddAlgebraicProductLikeStorageAndForwardingMacro.self,
    AddChainCollectionStorageImplementationMacro.self,
    AddFixedChainCollectionStorageComponentsMacro.self,
    ResettableLazyCalculationMacro.self,
    AddAlgebraicSumLikeIndexInitializationMacro.self,
    AddChainCollectionIndexCaseIterableMacro.self,
    AddChainIndexFixedComponentsMacro.self
  ]
}

