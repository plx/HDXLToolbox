import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: with-Derivation: Defaults
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2 {
  
  @inlinable
  public func with(a: A) -> Self {
    mutation(of: self) { $0.a = a }
  }
  
  @inlinable
  public func with(b: B) -> Self {
    mutation(of: self) { $0.b = b }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-A
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2 where A: Equatable {
 
  @inlinable
  public func with(a: A) -> Self {
    guard a != self.a else { return self }

    return mutation(of: self) { $0.a = a }
  }

}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-B
// -------------------------------------------------------------------------- //

extension AlgebraicProduct2 where B: Equatable {
  
  @inlinable
  public func with(b: B) -> Self {
    guard b != self.b else { return self }
    
    return mutation(of: self) { $0.b = b }
  }
  
}
