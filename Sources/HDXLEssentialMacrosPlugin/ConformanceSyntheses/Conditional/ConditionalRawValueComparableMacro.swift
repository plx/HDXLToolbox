import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct ConditionalAutoRawValueComparableMacro: AllOrNoneConditionalConformanceMacro {
  
  public static let conformedProtocolNames: [String] = ["Comparable", "AutoRawValueComparable"]
  public static let requiredProtocolNames: [String] = ["Comparable"]
  
}

