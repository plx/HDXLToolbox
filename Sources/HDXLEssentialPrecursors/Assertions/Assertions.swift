import Foundation

// flip commented/uncommented to verify it passes even under `HEAVY_DEBUG`.
//#if true
#if HEAVY_DEBUG
@inline(__always)
@inlinable
package func pedanticAssert(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line
) {
  assert(
    condition(),
    message(),
    file: file,
    line: line
  )
}

@inline(__always)
@inlinable
package func pedanticAssertionFailure(
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line
) {
  assertionFailure(
    message(),
    file: file,
    line: line
  )
}


@inline(__always)
@inlinable
package func pedanticPrecondition(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line
) {
  precondition(
    condition(),
    message(),
    file: file,
    line: line
  )
}

@inline(__always)
@inlinable
package func pedanticPreconditionFailure(
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line
) {
  preconditionFailure(
    message(),
    file: file,
    line: line
  )
}

#else

@inline(__always)
@inlinable
package func pedanticAssert(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line
) {
}

@inline(__always)
@inlinable
package func pedanticAssertionFailure(
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line
) {
}

@inline(__always)
@inlinable
package func pedanticPrecondition(
  _ condition: @autoclosure () -> Bool,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line
) {
}

@inline(__always)
@inlinable
package func pedanticPreconditionFailure(
  _ message: @autoclosure () -> String = "",
  file: StaticString = #file,
  line: UInt = #line
) {
}

#endif
