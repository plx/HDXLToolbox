import SwiftSyntax
import HDXLMacroSupport

public struct AlwaysCodableMacro: SingleProtocolUnconditionalConformanceMacro {
  public static let associatedProtocol: String = "Codable"
}
