import HDXLEssentialPrecursors
import HDXLTestingSupport
import HDXLAlgebraicTypes
import HDXLUtilityCollections

extension Sum2: @retroactive AsynchronousRepresentativeProbeProviding
where
A: AsynchronousRepresentativeProbeProviding,
B: AsynchronousRepresentativeProbeProviding
{
  
  @inlinable
  public static var allAsynchronousRepresentativeProbes: some Sendable & AsyncSequence<Self, Never> {
    AsyncStream { continuation in
      Task {
        defer { continuation.finish() }
        for await a in A.allAsynchronousRepresentativeProbes {
          continuation.yield(.a(a))
        }
        for await b in B.allAsynchronousRepresentativeProbes {
          continuation.yield(.b(b))
        }
      }
    }
  }
  
}

