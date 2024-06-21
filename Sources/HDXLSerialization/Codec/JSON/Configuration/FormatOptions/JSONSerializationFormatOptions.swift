import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: JSONSerializationFormatOptions
// -------------------------------------------------------------------------- //

/// Flags used to control miscellaneous aspects of Apple's JSON encoder and decoder.
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

// -------------------------------------------------------------------------- //
// MARK: - Synthesized Conformances
// -------------------------------------------------------------------------- //

extension JSONSerializationFormatOptions: Sendable { }
extension JSONSerializationFormatOptions: Equatable { }
extension JSONSerializationFormatOptions: Hashable { }
extension JSONSerializationFormatOptions: CaseIterable { }
extension JSONSerializationFormatOptions: Codable { }
extension JSONSerializationFormatOptions: CustomStringConvertible { }
extension JSONSerializationFormatOptions: CustomDebugStringConvertible { }

// -------------------------------------------------------------------------- //
// MARK: - Identifiable
// -------------------------------------------------------------------------- //

extension JSONSerializationFormatOptions: Identifiable {
  public typealias ID = Self
  
  @inlinable
  public var id: ID { self }
}

// -------------------------------------------------------------------------- //
// MARK: - FlagOptionSet
// -------------------------------------------------------------------------- //

extension JSONSerializationFormatOptions: FlagOptionSet {
  
  /// Used to request pretty-printed output from Apple's `JSONEncoder`.
  public static let prettyPrinted            = JSONSerializationFormatOptions(rawValue: 0b00000001)
  
  /// Used to request that Apple's `JSONEncoder` uses sorted keys in its output.
  public static let sortedKeys               = JSONSerializationFormatOptions(rawValue: 0b00000010)
  
  /// Used to request that Apple's `JSONEncoder` *not* escape slashes found in strings.
  public static let withoutEscapingSlashes   = JSONSerializationFormatOptions(rawValue: 0b00000100)
  
  /// Used to request that Apple's `JSONDecoder` *allow* decoding of JSON5-formatted data.
  public static let allowJSON5               = JSONSerializationFormatOptions(rawValue: 0b00001000)
  
  /// Used to request that Apple's `JSONDecoder` assume that the data's top-level obejct is a dictionary.
  ///
  /// This is somewhat non-intuitive and seems to be intended for niche usage.
  ///
  /// When set, the decoder will treat this:
  ///
  /// ```
  /// "x": 7,
  /// "y: 2
  /// ```
  ///
  /// ...as-if it was this:
  /// ```
  /// {
  ///    "x": 7,
  ///    "y": 2
  /// }
  /// ```
  ///
  /// What's particularly-puzzling here is that the `JSONDecoder` supports this format, but not the `JSONEncoder`--Apple's JSON toools will decode it but not encode it.
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
