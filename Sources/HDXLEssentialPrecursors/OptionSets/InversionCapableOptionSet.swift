import Foundation

// ---------------------------------------------------------------------------- //
// MARK: InversionCapableOptionSet
// ---------------------------------------------------------------------------- //

/// Swift's ``OptionSet`` is sufficiently-abstract-and-general that it has no built-in way to form the complement
/// of a value...but is also sufficiently-pedantic that you may not be able to get away with blindly doing a bitwise inversion
/// on the underlying raw value (where applicable!).
///
/// For example, let's say you have an option set that is:
///
/// 1. represented as `UInt8`
/// 2. has exactly 3 defined flags (`0b00000001`, `0b00000010`, `0b00000100`)
///
/// Doing a bitwise inverse will only partially work:
///
/// 1. it *will* produce a value with inverse membership state for each flag (e.g. if it contained`foo`, its bitwise-inverse complement won't)—that's fine
/// 2. it *will not* be bitwise identical to what you'd get if you did it manually:
///   - bitwise inversion: `0b00000101` -> `0b11111010`
///   - manual inversion: `0b00000101` -> `0b00000010`
///
/// ...and (in Swift) the presence of those "stray bits" will lead to unexpected results; this is *why* the option set protocol
/// doesn't provide a built-in way to take a complement//inverse/etc.—it's trying to maintain an informal guarantee
/// that "only the right underlyign bits will ever be set", and it can't do so efficiently in the general setting.
///
/// That's where this protocol comes in: we refine ``OptionSet`` and add the following:
///
/// - a static property that's (essentially) a bitmask with the known-valid bits
/// - a way to take the complement while maintaining that informal guarantee
///
/// Not all option sets can/should conform to this, but they should whenever inversion is possible-and-necessary.
public protocol InversionCapableOptionSet: OptionSet {
  /// A value containing all possible flags/options.
  ///
  /// For bitmask-style ``OptionSet``  types this should be a value with 1s for all possibly-set bits.
  ///
  /// This is the only required property in the protocol—the rest have worthwhile defaults.
  static var inversionReferenceValue: Self { get }
  
  /// The (option-)set-theoretic inverse of `self`.
  var complement: Self { get }
  
  /// In-place mutates `self` into its (option-)set-theoretic inverse.
  mutating func formComplement()
}

// ---------------------------------------------------------------------------- //
// MARK: - Conveniences
// ---------------------------------------------------------------------------- //

extension InversionCapableOptionSet {
  
  @inlinable
  public var complement: Self {
    // Obtain the inverse in the obvious way: subtract ourself from the "reference value".
    Self.inversionReferenceValue.subtracting(self)
  }
  
  @inlinable
  public mutating func formComplement() {
    self = complement
  }
  
}
