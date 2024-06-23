
// -------------------------------------------------------------------------- //
// MARK: - Tuple Representation
// -------------------------------------------------------------------------- //

extension AlgebraicProduct9 {
  
  /// Shorthand for the tuple equivalent-to `Self`.
  public typealias TupleRepresentation = (A,B,C,D,E,F,G,H,I)

  /// Returns a tuple equivalent-to `self`.
  @inlinable
  public var tupleRepresentation: TupleRepresentation {
    get {
      (
        a,
        b,
        c,
        d,
        e,
        f,
        g,
        h,
        i
      )
    }
    set {
      a = newValue.0
      b = newValue.1
      c = newValue.2
      d = newValue.3
      e = newValue.4
      f = newValue.5
      g = newValue.6
      h = newValue.7
      i = newValue.8
    }
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
      tupleRepresentation.6,
      tupleRepresentation.7,
      tupleRepresentation.8
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

extension AlgebraicProduct9 {
  
  public typealias ComponentTypeTuple = (
    A.Type,
    B.Type,
    C.Type,
    D.Type,
    E.Type,
    F.Type,
    G.Type,
    H.Type,
    I.Type
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
      G.self,
      H.self,
      I.self
    )
  }

}
