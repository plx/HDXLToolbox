import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: with-Derivation: Defaults
// -------------------------------------------------------------------------- //

extension AlgebraicProduct5 {
  
  @inlinable
  public func with(a: A) -> Self {
    mutation(of: self) { $0.a = a }
  }
  
  @inlinable
  public func with(b: B) -> Self {
    mutation(of: self) { $0.b = b }
  }
  
  @inlinable
  public func with(c: C) -> Self {
    mutation(of: self) { $0.c = c }
  }
  
  @inlinable
  public func with(d: D) -> Self {
    mutation(of: self) { $0.d = d }
  }
  
  @inlinable
  public func with(e: E) -> Self {
    mutation(of: self) { $0.e = e }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-A
// -------------------------------------------------------------------------- //

extension AlgebraicProduct5 where A: Equatable {
 
  @inlinable
  public func with(a: A) -> Self {
    guard a != self.a else { return self }

    return mutation(of: self) { $0.a = a }
  }

}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-B
// -------------------------------------------------------------------------- //

extension AlgebraicProduct5 where B: Equatable {
  
  @inlinable
  public func with(b: B) -> Self {
    guard b != self.b else { return self }
    
    return mutation(of: self) { $0.b = b }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-C
// -------------------------------------------------------------------------- //

extension AlgebraicProduct5 where C: Equatable {
  
  @inlinable
  public func with(c: C) -> Self {
    guard c != self.c else { return self }
    
    return mutation(of: self) { $0.c = c }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-D
// -------------------------------------------------------------------------- //

extension AlgebraicProduct5 where D: Equatable {
  
  @inlinable
  public func with(d: D) -> Self {
    guard d != self.d else { return self }
    
    return mutation(of: self) { $0.d = d }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-E
// -------------------------------------------------------------------------- //

extension AlgebraicProduct5 where E: Equatable {
  
  @inlinable
  public func with(e: E) -> Self {
    guard e != self.e else { return self }
    
    return mutation(of: self) { $0.e = e }
  }
  
}

