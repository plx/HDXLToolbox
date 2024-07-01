import SwiftSyntax
import HDXLMacroSupport

public struct AlwaysSendableMacro: SingleProtocolUnconditionalConformanceMacro {
  public static let associatedProtocol: String = "Sendable"
}
