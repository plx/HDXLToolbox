import SwiftSyntax

extension AttributeSyntax {
  
  @inlinable
  public var hasAtSign: Bool {
    atSign.tokenKind == .atSign
  }
  
  @inlinable
  public var hasNoArguments: Bool {
    arguments == nil
    &&
    leftParen == nil
    &&
    rightParen == nil
  }
  
  @inlinable
  public var inlinabilityDisposition: InlinabilityDisposition? {
    guard
      let identifier = attributeName.as(IdentifierTypeSyntax.self)
    else {
      return nil
    }
    
    return InlinabilityDisposition(tokenSyntax: identifier.name)
  }
  
  @inlinable
  public var isPreferredMememberwiseInitializer: Bool {
    guard
      let identifier = attributeName.as(IdentifierTypeSyntax.self)
    else {
      return false
    }
    
    return identifier.name.text == "PreferredMemberwiseInitializer"
  }
  
}
