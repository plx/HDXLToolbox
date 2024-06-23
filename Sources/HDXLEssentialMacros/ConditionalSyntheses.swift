import Foundation
import SwiftUI
import HDXLEssentialPrecursors

@attached(extension, conformances: Sendable)
public macro ConditionallySendable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallySendableMacro"
)

@attached(extension, conformances: Equatable)
public macro ConditionallyEquatable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyEquatableMacro"
)

@attached(extension, conformances: Hashable)
public macro ConditionallyHashable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyHashableMacro"
)

@attached(extension, conformances: Identifiable, AutoIdentifiable)
public macro ConditionallyAutoIdentifiable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyAutoIdentifiableMacro"
)

@attached(extension, conformances: Codable)
public macro ConditionallyCodable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyCodableMacro"
)

@attached(extension, conformances: Encodable)
public macro ConditionallyEncodable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyEncodableMacro"
)

@attached(extension, conformances: Decodable)
public macro ConditionallyDecodable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyDecodableMacro"
)

@attached(extension, conformances: AdditiveArithmetic)
public macro ConditionallyAdditiveArithmetic() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyAdditiveArithmeticMacro"
)

@attached(extension, conformances: VectorArithmetic)
public macro ConditionallyVectorArithmetic() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyVectorArithmeticMacro"
)

@attached(extension, conformances: RandomAccessCollection)
public macro ConditionallyRandomAccessCollection() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyRandomAccessCollectionMacro"
)
