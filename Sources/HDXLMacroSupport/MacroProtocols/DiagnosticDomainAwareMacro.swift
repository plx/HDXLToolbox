import SwiftSyntaxMacros
import SwiftDiagnostics

public protocol DiagnosticDomainAwareMacro {
  
  static var diagnosticDomainIdentifier: String { get }
}

extension DiagnosticDomainAwareMacro {
  
  public static var diagnosticDomainIdentifier: String { String(reflecting: self) }
}
