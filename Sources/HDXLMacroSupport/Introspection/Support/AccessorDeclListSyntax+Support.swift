import SwiftSyntax
import HDXLEssentialPrecursors

extension AccessorDeclListSyntax {
  
  @inlinable
  public var isCompatibleWithStoredProperty: Bool {
    !isIncompatibleWithStoredProperty
  }
  
  @inlinable
  public var isIncompatibleWithStoredProperty: Bool {
    anySatisfy(\.isIncompatibleWithStoredProperty)
  }
  
}
