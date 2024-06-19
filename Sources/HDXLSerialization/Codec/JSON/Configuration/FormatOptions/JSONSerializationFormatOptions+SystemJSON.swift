import Foundation
import HDXLEssentialPrecursors

extension JSONEncoder.OutputFormatting {
  @inlinable
  public var isPrettyPrinted: Bool {
    return contains(JSONEncoder.OutputFormatting.prettyPrinted)
  }
  
  @inlinable
  public var useSortedKeys: Bool {
    return contains(.sortedKeys)
  }
  
  @inlinable
  public var encodeWithoutEscapingSlashes: Bool {
    return contains(.withoutEscapingSlashes)
  }
  
  @inlinable
  public init(
    _ options: JSONSerializationFormatOptions
  ) {
    self.init(
      prettyPrinted: options.isPrettyPrinted,
      sortedKeys: options.useSortedKeys,
      withoutEscapingSlashes: options.encodeWithoutEscapingSlashes
    )
  }
  
  @inlinable
  public init(
    prettyPrinted: Bool,
    sortedKeys: Bool,
    withoutEscapingSlashes: Bool
  ) {
    self.init()
    setOptionStatus(
      to: prettyPrinted,
      for: .prettyPrinted
    )
    setOptionStatus(
      to: sortedKeys,
      for: .sortedKeys
    )
    setOptionStatus(
      to: withoutEscapingSlashes,
      for: .withoutEscapingSlashes
    )
  }
}

extension JSONSerializationFormatOptions {
  @inlinable
  public init(
    outputFormatting: JSONEncoder.OutputFormatting,
    allowJSON5: Bool,
    assumeTopLevelDictionary: Bool
  ) {
    self.init(
      prettyPrinted: outputFormatting.isPrettyPrinted,
      sortedKeys: outputFormatting.useSortedKeys,
      withoutEscapingSlashes: outputFormatting.encodeWithoutEscapingSlashes,
      allowJSON5: allowJSON5,
      assumeTopLevelDictionary: assumeTopLevelDictionary
    )
  }
}
