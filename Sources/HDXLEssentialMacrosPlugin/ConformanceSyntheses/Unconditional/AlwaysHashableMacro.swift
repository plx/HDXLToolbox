import SwiftSyntax
import HDXLMacroSupport

public struct AlwaysHashableMacro: SingleProtocolUnconditionalConformanceMacro {
  public static let associatedProtocol: String = "Hashable"
}
