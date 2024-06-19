import Foundation
import HDXLEssentialPrecursors

@frozen
public struct JSONSerializationFormatOptions: OptionSet {
  public typealias RawValue = UInt8
  
  public var rawValue: RawValue
  
  @inlinable
  public init() {
    self.init(rawValue: 0)
  }
  
  @inlinable
  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }
  
  @inlinable
  public init(
    prettyPrinted: Bool,
    sortedKeys: Bool,
    withoutEscapingSlashes: Bool,
    allowJSON5: Bool,
    assumeTopLevelDictionary: Bool
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
    setOptionStatus(
      to: allowJSON5,
      for: .allowJSON5
    )
    setOptionStatus(
      to: assumeTopLevelDictionary,
      for: .assumeTopLevelDictionary
    )
  }
}

extension JSONSerializationFormatOptions: Sendable { }
extension JSONSerializationFormatOptions: Equatable { }
extension JSONSerializationFormatOptions: Hashable { }
extension JSONSerializationFormatOptions: CaseIterable { }
extension JSONSerializationFormatOptions: Codable { }
extension JSONSerializationFormatOptions: CustomStringConvertible { }
extension JSONSerializationFormatOptions: CustomDebugStringConvertible { }

extension JSONSerializationFormatOptions: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

extension JSONSerializationFormatOptions: FlagOptionSet {
  
  public static let prettyPrinted            = JSONSerializationFormatOptions(rawValue: 0b00000001)
  public static let sortedKeys               = JSONSerializationFormatOptions(rawValue: 0b00000010)
  public static let withoutEscapingSlashes   = JSONSerializationFormatOptions(rawValue: 0b00000100)
  public static let allowJSON5               = JSONSerializationFormatOptions(rawValue: 0b00001000)
  public static let assumeTopLevelDictionary = JSONSerializationFormatOptions(rawValue: 0b00010000)
  
  public static let allFlagOptionsWithLeadingDotNames: [(JSONSerializationFormatOptions, String)] = [
    (.prettyPrinted, ".prettyPrinted"),
    (.sortedKeys, ".sortedKeys"),
    (.withoutEscapingSlashes, ".withoutEscapingSlashes"),
    (.allowJSON5, ".allowJSON5"),
    (.assumeTopLevelDictionary, ".assumeTopLevelDictionary")
  ]
  
  // TODO: this should come from a macro
  @inlinable
  public var isPrettyPrinted: Bool {
    get {
      contains(.prettyPrinted)
    }
    set {
      setOptionStatus(
        to: newValue,
        for: .prettyPrinted
      )
    }
  }
  
  // TODO: this should come from a macro
  @inlinable
  public var useSortedKeys: Bool {
    get {
      contains(.sortedKeys)
    }
    set {
      setOptionStatus(
        to: newValue,
        for: .sortedKeys
      )
    }
  }
  
  // TODO: this should come from a macro
  @inlinable
  public var encodeWithoutEscapingSlashes: Bool {
    get {
      contains(.withoutEscapingSlashes)
    }
    set {
      setOptionStatus(
        to: newValue,
        for: .withoutEscapingSlashes
      )
    }
  }
  
  // TODO: this should come from a macro
  @inlinable
  public var shouldAllowJSON5: Bool {
    get {
      contains(.allowJSON5)
    }
    set {
      setOptionStatus(
        to: newValue,
        for: .allowJSON5
      )
    }
  }
  
  // TODO: this should come from a macro
  @inlinable
  public var shouldAssumeTopLevelDictionary: Bool {
    get {
      contains(.assumeTopLevelDictionary)
    }
    set {
      setOptionStatus(
        to: newValue,
        for: .assumeTopLevelDictionary
      )
    }
  }
  
}
