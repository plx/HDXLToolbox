
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

@usableFromInline
@COWStorage
internal final class COWExerciserStorage<Foo, Bar, Baz> {
  @usableFromInline
  var foo: Foo
  
  @usableFromInline
  var bar: Bar
  
  @usableFromInline
  var baz: Baz
  
  @inlinable
  init(foo: Foo, bar: Bar, baz: Baz) {
    self.foo = foo
    self.bar = bar
    self.baz = baz
  }
  
}

@COWWrapper
public struct COWExerciser<Foo, Bar, Baz> {
  
  @usableFromInline
  internal typealias Storage = COWExerciserStorage<Foo, Bar, Baz>
  
  @usableFromInline
  internal var storage: Storage
  
  @COWProperty
  public var foo: Foo
  
  @COWProperty
  public var bar: Bar
  
  @COWProperty
  public var baz: Baz
}

