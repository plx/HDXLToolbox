import SwiftSyntax
import HDXLMacroSupport

public struct AlwaysEquatableMacro: SingleProtocolUnconditionalConformanceMacro {
  public static let associatedProtocol: String = "Equatable"
}
