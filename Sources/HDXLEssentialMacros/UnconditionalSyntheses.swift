import Foundation
import SwiftUI
import HDXLEssentialPrecursors

@attached(extension, conformances: Sendable)
public macro AlwaysSendable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AlwaysSendableMacro"
)

@attached(extension, conformances: Equatable)
public macro AlwaysEquatable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AlwaysEquatableMacro"
)

@attached(extension, conformances: Comparable)
public macro AlwaysComparable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AlwaysComparableMacro"
)

@attached(extension, conformances: Hashable)
public macro AlwaysHashable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AlwaysHashableMacro"
)

@attached(extension, conformances: Encodable)
public macro AlwaysEncodable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AlwaysEncodableMacro"
)

@attached(extension, conformances: Decodable)
public macro AlwaysDecodable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AlwaysDecodableMacro"
)

@attached(extension, conformances: Codable)
public macro AlwaysCodable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AlwaysCodableMacro"
)

@attached(extension, conformances: CaseIterable)
public macro AlwaysCaseIterable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AlwaysCaseIterableMacro"
)
