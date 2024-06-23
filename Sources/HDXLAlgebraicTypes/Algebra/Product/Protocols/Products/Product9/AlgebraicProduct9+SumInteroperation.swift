import Foundation
import HDXLEssentialPrecursors

extension AlgebraicProduct9 {
  
  /// Shorthand for the type of a homogeneous-value extractor.
  public typealias HomogeneousValueExtractor<T> = Sum9<
    (A) -> T,
    (B) -> T,
    (C) -> T,
    (D) -> T,
    (E) -> T,
    (F) -> T,
    (G) -> T,
    (H) -> T,
    (I) -> T
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
    case .d(let d):
      d(self.d)
    case .e(let e):
      e(self.e)
    case .f(let f):
      f(self.f)
    case .g(let g):
      g(self.g)
    case .h(let h):
      h(self.h)
    case .i(let i):
      i(self.i)
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
    case .d(let d):
      self.d = d
    case .e(let e):
      self.e = e
    case .f(let f):
      self.f = f
    case .g(let g):
      self.g = g
    case .h(let h):
      self.h = h
    case .i(let i):
      self.i = i
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
    case .d(let d):
      with(d: d)
    case .e(let e):
      with(e: e)
    case .f(let f):
      with(f: f)
    case .g(let g):
      with(g: g)
    case .h(let h):
      with(h: h)
    case .i(let i):
      with(i: i)
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
    case .d:
      .d(self.d)
    case .e:
      .e(self.e)
    case .f:
      .f(self.f)
    case .g:
      .g(self.g)
    case .h:
      .h(self.h)
    case .i:
      .i(self.i)
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
    case 3:
      .d(self.d)
    case 4:
      .e(self.e)
    case 5:
      .f(self.f)
    case 6:
      .g(self.g)
    case 7:
      .h(self.h)
    case 8:
      .i(self.i)
    default:
      preconditionFailure("Attempted to get the heterogeneous value at invalid index \(index) (on: \(String(reflecting: self))!")
    }
  }

}
