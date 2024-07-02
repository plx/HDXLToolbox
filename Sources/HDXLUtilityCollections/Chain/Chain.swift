import Foundation
import HDXLEssentialPrecursors
import HDXLCollectionSupport

// -------------------------------------------------------------------------- //
// MARK: ChainCollection - Arity 2
// -------------------------------------------------------------------------- //

/// "Pseudo-constructor" for a specific `ChainXCollection`.
///
/// - parameter a: The first collection in the chain.
/// - parameter b: The second collection in the chain.
///
/// - returns: A collection of the elements in `a`, followed by the elements in `b`, (etc.).
///
/// - note: Non-idiomatic capitalization of the function name is to look more like a type constructor.
///
@inlinable
public func ChainCollection<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>
) -> some Collection<T> {
  Chain2Collection(
    a,
    b
  )
}

@inlinable
public func chain<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>
) -> some Collection<T> {
  Chain2Collection(
    a,
    b
  )
}

// -------------------------------------------------------------------------- //
// MARK: ChainCollection - Arity 3
// -------------------------------------------------------------------------- //

/// "Pseudo-constructor" for a specific `ChainXCollection`.
///
/// - parameter a: The first collection in the chain.
/// - parameter b: The second collection in the chain.
/// - parameter c: The third collection in the chain.
///
/// - returns: A collection of the elements in `a`, followed by the elements in `b`, (etc.).
///
/// - note: Non-idiomatic capitalization of the function name is to look more like a type constructor.
///
@inlinable
public func ChainCollection<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>
) -> some Collection<T> {
  Chain3Collection(
    a,
    b,
    c
  )
}

@inlinable
public func chain<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>
) -> some Collection<T> {
  Chain3Collection(
    a,
    b,
    c
  )
}

// -------------------------------------------------------------------------- //
// MARK: ChainCollection - Arity 4
// -------------------------------------------------------------------------- //

/// "Pseudo-constructor" for a specific `ChainXCollection`.
///
/// - parameter a: The first collection in the chain.
/// - parameter b: The second collection in the chain.
/// - parameter c: The third collection in the chain.
/// - parameter d: The fourth collection in the chain.
///
/// - returns: A collection of the elements in `a`, followed by the elements in `b`, (etc.).
///
/// - note: Non-idiomatic capitalization of the function name is to look more like a type constructor.
///
@inlinable
public func ChainCollection<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>
) -> some Collection<T> {
  Chain4Collection(
    a,
    b,
    c,
    d
  )
}

@inlinable
public func chain<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>
) -> some Collection<T> {
  Chain4Collection(
    a,
    b,
    c,
    d
  )
}

// -------------------------------------------------------------------------- //
// MARK: ChainCollection - Arity 5
// -------------------------------------------------------------------------- //

/// "Pseudo-constructor" for a specific `ChainXCollection`.
///
/// - parameter a: The first collection in the chain.
/// - parameter b: The second collection in the chain.
/// - parameter c: The third collection in the chain.
/// - parameter d: The fourth collection in the chain.
/// - parameter e: The fifth collection in the chain.
///
/// - returns: A collection of the elements in `a`, followed by the elements in `b`, (etc.).
///
/// - note: Non-idiomatic capitalization of the function name is to look more like a type constructor.
///
@inlinable
public func ChainCollection<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>
) -> some Collection<T> {
  Chain5Collection(
    a,
    b,
    c,
    d,
    e
  )
}

@inlinable
public func chain<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>
) -> some Collection<T> {
  Chain5Collection(
    a,
    b,
    c,
    d,
    e
  )
}

// -------------------------------------------------------------------------- //
// MARK: ChainCollection - Arity 6
// -------------------------------------------------------------------------- //

/// "Pseudo-constructor" for a specific `ChainXCollection`.
///
/// - parameter a: The first collection in the chain.
/// - parameter b: The second collection in the chain.
/// - parameter c: The third collection in the chain.
/// - parameter d: The fourth collection in the chain.
/// - parameter e: The fifth collection in the chain.
/// - parameter f: The sixth collection in the chain.
///
/// - returns: A collection of the elements in `a`, followed by the elements in `b`, (etc.).
///
/// - note: Non-idiomatic capitalization of the function name is to look more like a type constructor.
///
@inlinable
public func ChainCollection<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>,
  _ f: some Collection<T>
) -> some Collection<T> {
  Chain6Collection(
    a,
    b,
    c,
    d,
    e,
    f
  )
}

@inlinable
public func chain<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>,
  _ f: some Collection<T>
) -> some Collection<T> {
  Chain6Collection(
    a,
    b,
    c,
    d,
    e,
    f
  )
}

// -------------------------------------------------------------------------- //
// MARK: ChainCollection - Arity 7
// -------------------------------------------------------------------------- //

/// "Pseudo-constructor" for a specific `ChainXCollection`.
///
/// - parameter a: The first collection in the chain.
/// - parameter b: The second collection in the chain.
/// - parameter c: The third collection in the chain.
/// - parameter d: The fourth collection in the chain.
/// - parameter e: The fifth collection in the chain.
/// - parameter f: The sixth collection in the chain.
/// - parameter g: The seventh collection in the chain.
///
/// - returns: A collection of the elements in `a`, followed by the elements in `b`, (etc.).
///
/// - note: Non-idiomatic capitalization of the function name is to look more like a type constructor.
///
@inlinable
public func ChainCollection<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>,
  _ f: some Collection<T>,
  _ g: some Collection<T>
) -> some Collection<T> {
  Chain7Collection(
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
public func chain<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>,
  _ f: some Collection<T>,
  _ g: some Collection<T>
) -> some Collection<T> {
  Chain7Collection(
    a,
    b,
    c,
    d,
    e,
    f,
    g
  )
}

// -------------------------------------------------------------------------- //
// MARK: ChainCollection - Arity 8
// -------------------------------------------------------------------------- //

/// "Pseudo-constructor" for a specific `ChainXCollection`.
///
/// - parameter a: The first collection in the chain.
/// - parameter b: The second collection in the chain.
/// - parameter c: The third collection in the chain.
/// - parameter d: The fourth collection in the chain.
/// - parameter e: The fifth collection in the chain.
/// - parameter f: The sixth collection in the chain.
/// - parameter g: The seventh collection in the chain.
/// - parameter h: The eigth collection in the chain.
///
/// - returns: A collection of the elements in `a`, followed by the elements in `b`, (etc.).
///
/// - note: Non-idiomatic capitalization of the function name is to look more like a type constructor.
///
@inlinable
public func ChainCollection<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>,
  _ f: some Collection<T>,
  _ g: some Collection<T>,
  _ h: some Collection<T>
) -> some Collection<T> {
  Chain8Collection(
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    h
  )
}

@inlinable
public func chain<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>,
  _ f: some Collection<T>,
  _ g: some Collection<T>,
  _ h: some Collection<T>
) -> some Collection<T> {
  Chain8Collection(
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    h
  )
}

// -------------------------------------------------------------------------- //
// MARK: ChainCollection - Arity 9
// -------------------------------------------------------------------------- //

/// "Pseudo-constructor" for a specific `ChainXCollection`.
///
/// - parameter a: The first collection in the chain.
/// - parameter b: The second collection in the chain.
/// - parameter c: The third collection in the chain.
/// - parameter d: The fourth collection in the chain.
/// - parameter e: The fifth collection in the chain.
/// - parameter f: The sixth collection in the chain.
/// - parameter g: The seventh collection in the chain.
/// - parameter h: The eigth collection in the chain.
/// - parameter i: The ninth collection in the chain.
///
/// - returns: A collection of the elements in `a`, followed by the elements in `b`, (etc.).
///
/// - note: Non-idiomatic capitalization of the function name is to look more like a type constructor.
///
@inlinable
public func ChainCollection<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>,
  _ f: some Collection<T>,
  _ g: some Collection<T>,
  _ h: some Collection<T>,
  _ i: some Collection<T>
) -> some Collection<T> {
  Chain9Collection(
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

@inlinable
public func chain<T>(
  _ a: some Collection<T>,
  _ b: some Collection<T>,
  _ c: some Collection<T>,
  _ d: some Collection<T>,
  _ e: some Collection<T>,
  _ f: some Collection<T>,
  _ g: some Collection<T>,
  _ h: some Collection<T>,
  _ i: some Collection<T>
) -> some Collection<T> {
  Chain9Collection(
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
