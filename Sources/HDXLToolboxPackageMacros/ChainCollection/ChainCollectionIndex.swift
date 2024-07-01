import Foundation
import HDXLEssentialPrecursors

@attached(
  extension,
  conformances: CaseIterable,
  names: named(allCases)
)
public macro AddChainCollectionIndexCaseIterable() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainCollectionIndexCaseIterableMacro"
)

@attached(
  member,
  names: named(Position), named(Storage), named(storage), named(init(storage:)), named(init(position:)), named(endIndex)
)
public macro AddChainIndexFixedComponents() = #externalMacro(
  module: "HDXLEssentialMacrosPlugin",
  type: "AddChainIndexFixedComponentsMacro"
)

