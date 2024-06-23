import HDXLEssentialPrecursors
import HDXLTestingSupport
import HDXLAlgebraicTypes
import HDXLUtilityCollections

extension Sum9: @retroactive AsynchronousRepresentativeProbeProviding
where
A: AsynchronousRepresentativeProbeProviding,
B: AsynchronousRepresentativeProbeProviding,
C: AsynchronousRepresentativeProbeProviding,
D: AsynchronousRepresentativeProbeProviding,
E: AsynchronousRepresentativeProbeProviding,
F: AsynchronousRepresentativeProbeProviding,
G: AsynchronousRepresentativeProbeProviding,
H: AsynchronousRepresentativeProbeProviding,
I: AsynchronousRepresentativeProbeProviding
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
        for await c in C.allAsynchronousRepresentativeProbes {
          continuation.yield(.c(c))
        }
        for await d in D.allAsynchronousRepresentativeProbes {
          continuation.yield(.d(d))
        }
        for await e in E.allAsynchronousRepresentativeProbes {
          continuation.yield(.e(e))
        }
        for await f in F.allAsynchronousRepresentativeProbes {
          continuation.yield(.f(f))
        }
        for await g in G.allAsynchronousRepresentativeProbes {
          continuation.yield(.g(g))
        }
        for await h in H.allAsynchronousRepresentativeProbes {
          continuation.yield(.h(h))
        }
        for await i in I.allAsynchronousRepresentativeProbes {
          continuation.yield(.i(i))
        }
      }
    }
  }
  
}
