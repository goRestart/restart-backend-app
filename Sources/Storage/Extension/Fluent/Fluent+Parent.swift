import Foundation
import Fluent

// MARK: - Hack fluent with custom id keys until fluent allows that feature again

extension Fluent.Builder {
    
    public func foreignId<E: Entity>(
        for entityType: E.Type,
        idKey: String = E.foreignIdKey,
        optional: Bool = false,
        unique: Bool = false
        ) {
        let field = Field(
            name: idKey,
            type: .id(type: E.idType),
            optional: optional,
            unique: unique
        )
        self.field(field)
        
        if autoForeignKeys {
            foreignKey(
                for: E.self,
                idKey: idKey
            )
        }
    }
    
    public func foreignKey<E: Entity>(
        for: E.Type = E.self,
        idKey: String = E.foreignIdKey
        ) {
        foreignKey(
            idKey,
            references: E.idKey,
            on: E.self
        )
    }
    
    public func parent<E: Entity>(
        _ entity: E.Type = E.self,
        idKey: String,
        optional: Bool = false,
        unique: Bool = false
        ) {
        foreignId(
            for: E.self,
            idKey: idKey,
            optional: optional,
            unique: unique
        )
    }
}
