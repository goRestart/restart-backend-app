import Foundation

public struct UserDiskDataSource: UserDataSource {

    public func add(with request: AddUserRequest) throws -> User {

        var newUser = UserDiskModel(
            id: Identifier.make().value,
            username: request.userName,
            email: request.email,
            password: request.password
        )

        do {
            try newUser.save()
        } catch {
            print("Error => \(error)")
        }

        throw AddUserError.unknown
//        return User(
//            identifier: "",
//            userName: "",
//            firstName: "",
//            lastName: "",
//            description: "",
//            image: nil,
//            email: "",
//            location: <#T##Location#>,
//            status: <#T##UserStatus#>,
//            locale: <#T##Locale#>,
//            applicationVersion: <#T##Int?#>,
//            birtdate: <#T##Date?#>,
//            createdAt: <#T##Date#>,
//            updatedAt: <#T##Date#>
//        )
    }
}
