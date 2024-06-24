import Foundation
import SwiftUI
import HDXLEssentialPrecursors

@attached(peer)
public macro PreferredMemberwiseInitializer() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "PreferredMemberwiseInitializerMacro"
)



