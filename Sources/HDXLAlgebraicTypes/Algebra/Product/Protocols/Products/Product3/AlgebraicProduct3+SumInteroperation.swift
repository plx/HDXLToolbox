import Foundation
import HDXLEssentialPrecursors

extension AlgebraicProduct3 {
  
  /// S,horthand for the type of a homogeneous-value extractor.
  public typealias HomogeneousValueExtractor<T> = Sum3<
    (A) -> T,
    (B) -> T,
    (C) -> T
  >

  /// Returns a value of type `T` from `self` using the supplied extractor
  /// applied to its corresponding component (e.g. `.b(mappingFromBToT)` will
  /// return `mappingFromBToT(self.b)`).
  @inlinable
  public func extractHomogeneizedValue<T>(
    ofType type: T.Type,
    using extractor: HomogeneousValueExtractor<T>
  ) -> T {
    switch extractor {
    case .a(let a):
      a(self.a)
    case .b(let b):
      b(self.b)
    case .c(let c):
      c(self.c)
    }
  }
  
  /// Updates `self` by replacing the indicated `component`.
  ///
  /// In other words, `self.formReplacement(ofComponent: .b(newBValue))` will
  /// modify `self` in-place by setting `self.b = newBValue`, leaving all other
  /// components unchanged.
  ///
  @inlinable
  public mutating func formReplacement(
    ofComponent component: AssociatedSum
  ) {
    switch component {
    case .a(let a):
      self.a = a
    case .b(let b):
      self.b = b
    case .c(let c):
      self.c = c
    }
  }

  /// Returns `self` with the indicated `component` replaced.
  ///
  /// In other words, `self.replacing(component: .b(newBValue))` will return
  /// `self` with `.b` set to `newBValue` and all other components left as-is.
  ///
  @inlinable
  public func replacing(component: AssociatedSum) -> Self {
    switch component {
    case .a(let a):
      with(a: a)
    case .b(let b):
      with(b: b)
    case .c(let c):
      with(c: c)
    }
  }

  /// Retrieves value at `position`, represented as the `AssociatedSum`.
  @inlinable
  public func heterogeneousValue(
    at position: ArityPosition
  ) -> AssociatedSum {
    switch position {
    case .a:
      .a(self.a)
    case .b:
      .b(self.b)
    case .c:
      .c(self.c)
    }
  }
  
  /// Retrieves value at `position`, represented as the `AssociatedSum`.
  @inlinable
  package func heterogeneousValue(at index: Int) -> AssociatedSum {
    switch index {
    case 0:
      .a(self.a)
    case 1:
      .b(self.b)
    case 2:
      .c(self.c)
    default:
      preconditionFailure("Attempted to get the heterogeneous value at invalid index \(index) (on: \(String(reflecting: self))!")
    }
  }

}
