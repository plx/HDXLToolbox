import Foundation
import SwiftUI
import HDXLEssentialPrecursors

//@attached(extension, conformances: COWWrapperProtocol)
//public macro COWWrapper() = #externalMacro(
//  module: "HDXLEssentialMacrosPlugin",
//  type: "COWWrapperMacro"
//)
//
@attached(member, names: named(ensureUniqueStorage()))
public macro COWWrapper() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "COWWrapperMacro"
)

@attached(accessor)
public macro COWProperty() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "COWPropertyMacro"
)

@attached(accessor)
public macro COWBoxProperty() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "COWBoxPropertyMacro"
)

@attached(extension, conformances: CloneableObject)
@attached(member, names: named(obtainClone()))
public macro COWStorage() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "COWStorageMacro"
)

