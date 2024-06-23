import Foundation
import HDXLEssentialPrecursors

// -------------------------------------------------------------------------- //
// MARK: with-Derivation: Defaults
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 {
  
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
  
  @inlinable
  public func with(f: F) -> Self {
    mutation(of: self) { $0.f = f }
  }
  
  @inlinable
  public func with(g: G) -> Self {
    mutation(of: self) { $0.g = g }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-A
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 where A: Equatable {
 
  @inlinable
  public func with(a: A) -> Self {
    guard a != self.a else { return self }

    return mutation(of: self) { $0.a = a }
  }

}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-B
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 where B: Equatable {
  
  @inlinable
  public func with(b: B) -> Self {
    guard b != self.b else { return self }
    
    return mutation(of: self) { $0.b = b }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-C
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 where C: Equatable {
  
  @inlinable
  public func with(c: C) -> Self {
    guard c != self.c else { return self }
    
    return mutation(of: self) { $0.c = c }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-D
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 where D: Equatable {
  
  @inlinable
  public func with(d: D) -> Self {
    guard d != self.d else { return self }
    
    return mutation(of: self) { $0.d = d }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-E
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 where E: Equatable {
  
  @inlinable
  public func with(e: E) -> Self {
    guard e != self.e else { return self }
    
    return mutation(of: self) { $0.e = e }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-F
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 where F: Equatable {
  
  @inlinable
  public func with(f: F) -> Self {
    guard f != self.f else { return self }
    
    return mutation(of: self) { $0.f = f }
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Equatable-G
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 where G: Equatable {
  
  @inlinable
  public func with(g: G) -> Self {
    guard g != self.g else { return self }
    
    return mutation(of: self) { $0.g = g }
  }
  
}
