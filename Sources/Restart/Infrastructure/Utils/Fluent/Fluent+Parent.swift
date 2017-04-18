import Foundation
import Fluent

// MARK: - Hack fluent with custom id keys until fluent allows that feature again

extension Fluent.Builder {
    
    public func foreignId<E: Entity>(
        for entityType: E.Type,
        name: String = E.foreignIdKey,
        optional: Bool = false,
        unique: Bool = false
        ) {
        let field = Field(
            name: name,
            type: .id(type: E.idType),
            optional: optional,
            unique: unique
        )
        self.field(field)
        
        if autoForeignKeys {
            foreignKey(
                for: E.self,
                name: name
            )
        }
    }
    
    public func foreignKey<E: Entity>(
        for: E.Type = E.self,
        name: String = E.foreignIdKey
        ) {
        foreignKey(
            name,
            references: E.idKey,
            on: E.self
        )
    }
    
    public func parent<E: Entity>(
        _ entity: E.Type = E.self,
        name: String,
        optional: Bool = false,
        unique: Bool = false
        ) {
        foreignId(
            for: E.self,
            name: name,
            optional: optional,
            unique: unique
        )
    }
}
