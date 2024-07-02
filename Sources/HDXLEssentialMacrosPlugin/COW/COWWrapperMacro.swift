import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct COWWrapperMacro: DiagnosticDomainAwareMacro { }

extension COWWrapperMacro: ContextualizedMemberMacro {
  public static let structAttachmentDisposition: AttachmentDisposition = .required
  
  public static func contextualizedExpansion(
    in attachmentContext: some MemberMacroContextProtocol
  ) throws -> [DeclSyntax] {
    [
      """
      @inlinable
      internal mutating func ensureUniqueStorage() {
        guard !isKnownUniquelyReferenced(&storage) else { return }
        storage = storage.obtainClone()
      }
      """
    ]
  }
}
