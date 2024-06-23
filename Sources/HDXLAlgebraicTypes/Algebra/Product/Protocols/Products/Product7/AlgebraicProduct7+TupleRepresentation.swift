
// -------------------------------------------------------------------------- //
// MARK: - Tuple Representation
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 {
  
  /// Shorthand for the tuple equivalent-to `Self`.
  public typealias TupleRepresentation = (A,B,C,D,E,F,G)
  
  /// Returns a tuple equivalent-to `self`.
  @inlinable
  public var tupleRepresentation: TupleRepresentation {
    (
      a,
      b,
      c,
      d,
      e,
      f,
      g
    )
  }
  
  @inlinable
  public init(tupleRepresentation: TupleRepresentation) {
    self.init(
      tupleRepresentation.0,
      tupleRepresentation.1,
      tupleRepresentation.2,
      tupleRepresentation.3,
      tupleRepresentation.4,
      tupleRepresentation.5,
      tupleRepresentation.6
    )
  }
  
  @inlinable
  public init?(possibleTupleRepresentation: TupleRepresentation?) {
    guard let tupleRepresentation = possibleTupleRepresentation else {
      return nil
    }
    self.init(
      tupleRepresentation: tupleRepresentation
    )
  }
  
}

// -------------------------------------------------------------------------- //
// MARK: - Component-Type Tuple
// -------------------------------------------------------------------------- //

extension AlgebraicProduct7 {
  
  public typealias ComponentTypeTuple = (
    A.Type,
    B.Type,
    C.Type,
    D.Type,
    E.Type,
    F.Type,
    G.Type
  )
  
  @inlinable
  public static var componentTypeTuple: ComponentTypeTuple {
    (
      A.self,
      B.self,
      C.self,
      D.self,
      E.self,
      F.self,
      G.self
    )
  }
  
}
