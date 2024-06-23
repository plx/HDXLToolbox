
// -------------------------------------------------------------------------- //
// MARK: - Tuple Representation
// -------------------------------------------------------------------------- //

extension AlgebraicProduct5 {
  
  /// Shorthand for the tuple equivalent-to `Self`.
  public typealias TupleRepresentation = (A,B,C,D,E)
  
  /// Returns a tuple equivalent-to `self`.
  @inlinable
  public var tupleRepresentation: TupleRepresentation {
    get {
      (
        a,
        b,
        c,
        d,
        e
      )
    }
    set {
      a = newValue.0
      b = newValue.1
      c = newValue.2
      d = newValue.3
      e = newValue.4
    }
  }
  
  @inlinable
  public init(tupleRepresentation: TupleRepresentation) {
    self.init(
      tupleRepresentation.0,
      tupleRepresentation.1,
      tupleRepresentation.2,
      tupleRepresentation.3,
      tupleRepresentation.4
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

extension AlgebraicProduct5 {
  
  public typealias ComponentTypeTuple = (
    A.Type,
    B.Type,
    C.Type,
    D.Type,
    E.Type
  )
  
  @inlinable
  public static var componentTypeTuple: ComponentTypeTuple {
    (
      A.self,
      B.self,
      C.self,
      D.self,
      E.self
    )
  }
  
}
