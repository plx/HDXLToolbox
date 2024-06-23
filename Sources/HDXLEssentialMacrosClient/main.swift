
import Foundation
import HDXLEssentialMacros
import HDXLEssentialPrecursors

@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyCodable
struct MacroExerciser<Foo,Bar,Baz> {
  var foo: Foo
  var bar: Bar
  var baz: Baz
}


@ConditionallySendable
@ConditionallyEquatable
@ConditionallyHashable
@ConditionallyAutoIdentifiable
@ConditionallyEncodable
@ConditionallyDecodable
struct MacroExerciserII<Foo,Bar,Baz> {
  var foo: Foo
  var bar: Bar
  var baz: Baz
}
