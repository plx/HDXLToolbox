import Foundation
import SwiftUI
import HDXLEssentialPrecursors

@attached(extension, conformances: Sendable)
public macro ConditionallySendable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallySendableMacro"
)

@attached(extension, conformances: Sendable)
public macro ConditionallyUncheckedSendable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConditionallyUncheckedSendableMacro"
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

@attached(
  extension,
  conformances: Identifiable, AutoIdentifiable,
  names: named(ID), named(id)
)
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

@attached(extension, conformances: Comparable, names: named(<))
public macro StorageComparable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "StorageComparableMacro"
)

@attached(extension, conformances: CustomStringConvertible, names: named(description))
public macro StorageCustomStringConvertible() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "StorageCustomStringConvertibleMacro"
)

@attached(extension, conformances: CustomDebugStringConvertible, names: named(debugDescription))
public macro StorageCustomDebugStringConvertible() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "StorageCustomDebugStringConvertibleMacro"
)

@attached(extension, conformances: CustomDebugStringConvertible, names: named(debugDescription))
public macro ConstructorDebugDescription() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "ConstructorDebugDescriptionMacro"
)

