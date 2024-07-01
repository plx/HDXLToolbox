import SwiftSyntax
import HDXLMacroSupport

public struct AlwaysComparableMacro: SingleProtocolUnconditionalConformanceMacro {
  public static let associatedProtocol: String = "Comparable"
}
