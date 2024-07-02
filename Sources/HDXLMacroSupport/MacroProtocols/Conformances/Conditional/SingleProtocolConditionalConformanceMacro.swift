import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors

public protocol SingleProtocolConditionalConformanceMacro: AllOrNoneConditionalConformanceMacro {
  
  static var associatedProtocol: String { get }
}

extension SingleProtocolConditionalConformanceMacro {
  
  public static var requiredProtocolNames: [String] { [associatedProtocol] }
  public static var conformedProtocolNames: [String] { [associatedProtocol] }
  
}

