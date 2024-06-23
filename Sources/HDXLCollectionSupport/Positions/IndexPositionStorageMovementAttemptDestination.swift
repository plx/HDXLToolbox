import Foundation
import HDXLEssentialPrecursors

@usableFromInline
package enum IndexPositionStorageMovementAttemptDestination<T> {
  
  case success(T)
  case becameEnd
  case misnavigation
  
}
