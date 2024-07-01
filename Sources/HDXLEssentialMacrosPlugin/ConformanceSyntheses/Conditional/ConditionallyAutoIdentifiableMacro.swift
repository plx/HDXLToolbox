import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct ConditionallyAutoIdentifiableMacro: AllOrNoneConditionalConformanceMacro {
  public static let requiredProtocolNames: [String] = ["Hashable"]
  public static let conformedProtocolNames: [String] = ["Identifiable", "AutoIdentifiable"]
}

