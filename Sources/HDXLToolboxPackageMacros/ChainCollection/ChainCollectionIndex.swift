import Foundation
import HDXLEssentialPrecursors

@attached(
  extension,
  conformances: CaseIterable,
  names: named(allCases)
)
public macro AddChainCollectionIndexCaseIterable() = #externalMacro(
  module: "HDXLToolboxPackageMacrosPlugin",
  type: "AddChainCollectionIndexCaseIterableMacro"
)

@attached(
  member,
  names: named(Position), named(Storage), named(storage), named(init(storage:)), named(init(position:)), named(endIndex)
)
public macro AddChainCollectionIndexFixedComponents() = #externalMacro(
  module: "HDXLToolboxPackageMacrosPlugin",
  type: "AddChainCollectionIndexFixedComponentsMacro"
)

