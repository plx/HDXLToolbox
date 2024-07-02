import Foundation
import SwiftSyntax
import SwiftParser
import SwiftSyntaxMacros
import SwiftSyntaxBuilder
import SwiftDiagnostics
import HDXLEssentialPrecursors
import HDXLMacroSupport

public struct AddChainCollectionIndexFixedComponentsMacro : DiagnosticDomainAwareMacro { }

extension AddChainCollectionIndexFixedComponentsMacro: ContextualizedMemberMacro {
  public static let structAttachmentDisposition: AttachmentDisposition = .required
  
  public static func contextualizedExpansion(
    in attachmentContext: some MemberMacroContextProtocol
  ) throws -> [DeclSyntax] {
    let genericParameters = try attachmentContext.requireNonEmptyProperty(
      \.simpleGenericParameterNames,
       of: attachmentContext.declaration
    )

    return [
      """
      @usableFromInline
      internal typealias Position = Sum\(raw: genericParameters.count)<\(raw: genericParameters.joined(separator: ", "))>
      """,

      """
      @usableFromInline
      internal typealias Storage = PositionIndexStorage<Position>
      """,
      
      """
      @usableFromInline
      internal var storage: Storage
      """,
      
      """
      @inlinable
      internal init(storage: Storage) {
        self.storage = storage
      }
      """,
      
      """
      @inlinable
      internal init(position: Position) {
        self.init(
          storage: .position(position)
        )
      }
      """,
      
      """
      @inlinable
      internal static var endIndex: Self {
        Self(storage: .endIndex)
      }
      """
    ]
  }
}

