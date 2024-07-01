import SwiftSyntax
import HDXLMacroSupport

public struct AlwaysEncodableMacro: SingleProtocolUnconditionalConformanceMacro {
  public static let associatedProtocol: String = "Encodable"
}
