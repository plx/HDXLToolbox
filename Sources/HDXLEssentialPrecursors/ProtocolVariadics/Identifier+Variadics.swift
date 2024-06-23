


@inlinable
package func identifierTuple<each T: Identifiable>(
  for values: (repeat each T)
) -> (repeat (each T).ID) {
  return (repeat (each values).id)
}
