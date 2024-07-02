import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct ConditionallyVectorArithmeticMacro: SingleProtocolConditionalConformanceMacro {
  public static let associatedProtocol: String = "VectorArithmetic"
}

