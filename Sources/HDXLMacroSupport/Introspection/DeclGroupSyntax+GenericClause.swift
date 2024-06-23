import SwiftSyntax

public enum TypeArchetype: Sendable, Hashable, CaseIterable, Codable {
  case `actor`
  case `class`
  case `enum`
  case `struct`
}

public struct CharacterizedTypeName: Sendable, Hashable, Codable {
  public var typeArchetype: TypeArchetype
  public var typeName: String
  
  public init(typeArchetype: TypeArchetype, typeName: String) {
    self.typeArchetype = typeArchetype
    self.typeName = typeName
  }

  public static func `actor`(_ name: String) -> Self {
    CharacterizedTypeName(
      typeArchetype: .actor,
      typeName: name
    )
  }

  public static func `struct`(_ name: String) -> Self {
    CharacterizedTypeName(
      typeArchetype: .struct,
      typeName: name
    )
  }
  
  public static func `class`(_ name: String) -> Self {
    CharacterizedTypeName(
      typeArchetype: .class,
      typeName: name
    )
  }
  
  public static func `enum`(_ name: String) -> Self {
    CharacterizedTypeName(
      typeArchetype: .enum,
      typeName: name
    )
  }
}

extension DeclGroupSyntax {

  @inlinable
  public func typeNameWithAllSimpleGenericParameters(
    excludingArchetypes excludedArchetypes: Set<TypeArchetype> = []
  ) -> (CharacterizedTypeName, [String])? {
    if let actorDeclaration = self.as(ActorDeclSyntax.self) {
      guard
        !excludedArchetypes.contains(.actor),
        let typeName = actorDeclaration.characterizedTypeName,
        let simpleGenericParameterNames = actorDeclaration.simpleGenericParameterNames
      else {
        return nil
      }
      
      return (typeName, simpleGenericParameterNames)
    } else if let enumDeclaration = self.as(EnumDeclSyntax.self) {
      guard
        !excludedArchetypes.contains(.enum),
        let typeName = enumDeclaration.characterizedTypeName,
        let simpleGenericParameterNames = enumDeclaration.simpleGenericParameterNames
      else {
        return nil
      }
      
      return (typeName, simpleGenericParameterNames)
    } else if let classDeclaration = self.as(ClassDeclSyntax.self) {
      guard
        !excludedArchetypes.contains(.class),
        let typeName = classDeclaration.characterizedTypeName,
        let simpleGenericParameterNames = classDeclaration.simpleGenericParameterNames
      else {
        return nil
      }
      
      return (typeName, simpleGenericParameterNames)
    } else if let structDeclaration = self.as(StructDeclSyntax.self) {
      guard
        !excludedArchetypes.contains(.struct),
        let typeName = structDeclaration.characterizedTypeName,
        let simpleGenericParameterNames = structDeclaration.simpleGenericParameterNames
      else {
        return nil
      }
      
      return (typeName, simpleGenericParameterNames)
    } else {
      return nil
    }
  }
  
}

extension ActorDeclSyntax {
  
  @inlinable
  public var characterizedTypeName: CharacterizedTypeName? {
    guard 
      case .identifier = name.tokenKind,
      !name.text.isEmpty
    else {
      return nil
    }
    
    return .actor(name.text)
  }
  
  @inlinable
  public var simpleGenericParameterNames: [String]? {
    genericParameterClause?.simpleGenericParameterNames
  }
  
}

extension EnumDeclSyntax {
  
  @inlinable
  public var characterizedTypeName: CharacterizedTypeName? {
    guard
      case .identifier = name.tokenKind,
      !name.text.isEmpty
    else {
      return nil
    }
    
    return .enum(name.text)
  }

  @inlinable
  public var simpleGenericParameterNames: [String]? {
    genericParameterClause?.simpleGenericParameterNames
  }
  
}

extension StructDeclSyntax {
  
  @inlinable
  public var characterizedTypeName: CharacterizedTypeName? {
    guard
      case .identifier = name.tokenKind,
      !name.text.isEmpty
    else {
      return nil
    }
    
    return .struct(name.text)
  }

  @inlinable
  public var simpleGenericParameterNames: [String]? {
    genericParameterClause?.simpleGenericParameterNames
  }
  
}

extension ClassDeclSyntax {
  
  @inlinable
  public var characterizedTypeName: CharacterizedTypeName? {
    guard
      case .identifier = name.tokenKind,
      !name.text.isEmpty
    else {
      return nil
    }
    
    return .class(name.text)
  }

  @inlinable
  public var simpleGenericParameterNames: [String]? {
    genericParameterClause?.simpleGenericParameterNames
  }
  
}

extension GenericParameterClauseSyntax {
  
  @inlinable
  public var simpleGenericParameterNames: [String]? {
    parameters.simpleGenericParameterNames
  }
}

extension GenericParameterListSyntax {
  @inlinable
  public var simpleGenericParameterNames: [String]? {
    let possibleNames = compactMap(\.simpleGenericParameterName)
    guard
      !possibleNames.isEmpty,
      possibleNames.count == count
    else {
      return nil
    }
    
    return possibleNames
  }
}

extension GenericParameterSyntax {
  @inlinable
  public var simpleGenericParameterName: String? {
    guard
      eachKeyword == nil,
      case .identifier = name.tokenKind,
      !name.text.isEmpty
    else {
      return nil
    }
    
    return name.text
  }
  
}
