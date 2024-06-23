import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct4 - Uniform Value Access
// -------------------------------------------------------------------------- //

extension AlgebraicProduct4
  where
  A == B,
  A == C,
  A == D
{

  // ------------------------------------------------------------------------ //
  // MARK: Typealias
  // ------------------------------------------------------------------------ //
  
  /// Synonym for `A`, but makes it clear when we mean "the type of the uniform value".
  public typealias UniformValue = A

  // ------------------------------------------------------------------------ //
  // MARK: Homogeneous Construction
  // ------------------------------------------------------------------------ //
  
  /// Constructs a product by "splatting" `value` into all positions.
  @inlinable
  public init(bySplatting value: UniformValue) {
    self.init(
      value,
      value,
      value,
      value
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: Value Access
  // ------------------------------------------------------------------------ //

  /// The first, leftmost, etc., value within `self`.
  @inlinable
  public var firstValue: UniformValue {
    get {
      a
    }
    set {
      a = newValue
    }
  }
  
  /// The final, rightmost, etc., value within `self`.
  @inlinable
  public var lastValue: UniformValue {
    get {
      d
    }
    set {
      d = newValue
    }
  }
  
  /// Retrieves the contents of `self` as an `Array`.
  @inlinable
  public var allValues: [UniformValue] {
    [
      a,
      b,
      c,
      d
    ]
  }

  // ------------------------------------------------------------------------ //
  // MARK: Integer-Subscript Support
  // ------------------------------------------------------------------------ //
  
  @inlinable
  internal static func canSubscript(at index: Int) -> Bool {
    (0..<arity).contains(index)
  }
  
  @inlinable
  package subscript(index: Int) -> UniformValue {
    get {
      precondition(Self.canSubscript(at: index))
      switch index {
        case 0:
          return a
        case 1:
          return b
        case 2:
          return c
        case 3:
          return d
      default:
        preconditionFailure("Used invalid `index` \(index) to subscript \(String(reflecting: self))!")
      }
    }
    set {
      precondition(Self.canSubscript(at: index))
      switch index {
        case 0:
          a = newValue
        case 1:
          b = newValue
        case 2:
          c = newValue
        case 3:
          d = newValue
        default:
          preconditionFailure("Used invalid `index` \(index) to subscript \(String(reflecting: self))!")
      }
    }
  }

  @inlinable
  package func uniformValue(at index: Int) -> UniformValue {
    self[index]
  }

  @inlinable
  package mutating func setUniformValue(
    _ value: UniformValue,
    at index: Int
  ) {
    self[index] = value
  }

  // ------------------------------------------------------------------------ //
  // MARK: Arity-Subscript Support
  // ------------------------------------------------------------------------ //
  
  @inlinable
  public subscript(position: ArityPosition) -> UniformValue {
    get {
      switch position {
      case .a:
        a
      case .b:
        b
      case .c:
        c
      case .d:
        d
      }
    }
    set {
      switch position {
      case .a:
        a = newValue
      case .b:
        b = newValue
      case .c:
        c = newValue
      case .d:
        d = newValue
      }
    }
  }

  @inlinable
  public func uniformValue(at position: ArityPosition) -> UniformValue {
    self[position]
  }

  @inlinable
  public mutating func setUniformValue(
    _ value: UniformValue,
    at position: ArityPosition
  ) {
    self[position] = value
  }

  // ------------------------------------------------------------------------ //
  // MARK: Out-of-Place Pushes
  // ------------------------------------------------------------------------ //
  
  @inlinable
  public func pushedLeftward(
    byAppending value: UniformValue
  ) -> Self {
    Self(
      b,
      c,
      d,
      value
    )
  }

  @inlinable
  public func pushedRightward(byPrepending value: UniformValue) -> Self {
    Self(
      value,
      a,
      b,
      c
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: In-Place Pushes
  // ------------------------------------------------------------------------ //
  
  @inlinable
  public mutating func formLeftwardPush(
    byAppending value: UniformValue
  ) {
    a = b
    b = c
    c = d
    d = value
  }
  
  @inlinable
  public mutating func formRightwardPush(
    byPrepending value: UniformValue
  ) {
    d = c
    c = b
    b = a
    a = value
  }

}
