import Foundation
import HDXLEssentialPrecursors

extension Sequence {
  @inlinable
  public func endcapInterpositions<Intro,Outro>(
    intro: Intro,
    outro: Outro
  ) -> EndcapInterposeSequence<Intro, Outro, Self> {
    EndcapInterposeSequence<Intro, Outro, Self>(
      intro: intro,
      outro: outro,
      base: self
    )
  }
  
  @inlinable
  public func endcapInterpositions<Intro>(
    intro: Intro
  ) -> EndcapInterposeSequence<Intro, Void, Self> {
    EndcapInterposeSequence<Intro, Void, Self>(
      intro: intro,
      outro: (),
      base: self
    )
  }
  
  @inlinable
  public func endcapInterpositions<Outro>(
    outro: Outro
  ) -> EndcapInterposeSequence<Void, Outro, Self> {
    EndcapInterposeSequence<Void, Outro, Self>(
      intro: (),
      outro: outro,
      base: self
    )
  }
  
  @inlinable
  public func endcapInterpositions() -> EndcapInterposeSequence<Void, Void, Self> {
    EndcapInterposeSequence<Void, Void, Self>(
      intro: (),
      outro: (),
      base: self
    )
  }
}

