import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: AlgebraicProduct2 - Uniform Value Access
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2
  where
  A == B 
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
      value
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: Value Access
  // ------------------------------------------------------------------------ //

  /// The first, leftmost, etc., value within `self`.
  @inlinable
  public var firstValue: UniformValue {
    get { a }
    set { a = newValue }
  }
  
  /// The final, rightmost, etc., value within `self`.
  @inlinable
  public var lastValue: UniformValue {
    get { b }
    set { b = newValue }
  }
  
  /// Retrieves the contents of `self` as an `Array`.
  @inlinable
  public var allValues: [UniformValue] {
    [
      a,
      b
    ]
  }

  // ------------------------------------------------------------------------ //
  // MARK: Integer-Subscript Support
  // ------------------------------------------------------------------------ //
  
  @inlinable
  internal static func canSubscript(at index: Int) -> Bool {
    (0..<Self.arity).contains(index)
  }
  
  @inlinable
  package subscript(index: Int) -> UniformValue {
    get {
      switch index {
      case 0:
        self.a
      case 1:
        self.b
      default:
        preconditionFailure("Used invalid `index` \(index) to subscript \(String(reflecting: self))!")
      }
    }
    set {
      switch index {
      case 0:
        a = newValue
      case 1:
        b = newValue
      default:
        preconditionFailure("Used invalid `index` \(index) to subscript \(String(reflecting: self))!")
      }
    }
  }

  @inlinable
  package func uniformValue(at index: Int) -> UniformValue {
    return self[index]
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
      }
    }
    set {
      switch position {
      case .a:
        a = newValue
      case .b:
        b = newValue
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
  public func pushedLeftward(byAppending value: UniformValue) -> Self {
    Self(
      b,
      value
    )
  }

  @inlinable
  public func pushedRightward(byPrepending value: UniformValue) -> Self {
    return Self(
      value,
      a
    )
  }

  // ------------------------------------------------------------------------ //
  // MARK: In-Place Pushes
  // ------------------------------------------------------------------------ //
  
  @inlinable
  public mutating func formLeftwardPush(byAppending value: UniformValue) {
    a = b
    b = value
  }
  
  @inlinable
  public mutating func formRightwardPush(byPrepending value: UniformValue) {
    b = a
    a = value
  }

}

extension Array {

  @inlinable
  public init<T>(_ product: some AlgebraicProduct2<T,T>) {
    self = product.allValues
  }
  
  
}
