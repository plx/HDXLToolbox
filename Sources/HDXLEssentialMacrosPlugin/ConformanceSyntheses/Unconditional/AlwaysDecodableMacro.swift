import SwiftSyntax
import HDXLMacroSupport

public struct AlwaysDecodableMacro: SingleProtocolUnconditionalConformanceMacro {
  public static let associatedProtocol: String = "Decodable"
}
