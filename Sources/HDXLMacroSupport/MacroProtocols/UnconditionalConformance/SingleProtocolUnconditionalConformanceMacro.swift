import SwiftSyntax
import HDXLEssentialPrecursors

public protocol SingleProtocolUnconditionalConformanceMacro: UnconditionalConformanceMacro, ContextualizedExtensionMacro, DiagnosticDomainAwareMacro {
  
  static var associatedProtocol: String { get }

  
}

extension SingleProtocolUnconditionalConformanceMacro {
  
  public static var protocolAttachmentDisposition: AttachmentDisposition { .excluded }
  
  public static var conformedProtocolNames: [String] { [associatedProtocol]  }
  
}
