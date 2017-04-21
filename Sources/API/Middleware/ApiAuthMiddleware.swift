import HTTP
import Vapor
import Restart

public struct ApiAuthMiddleware: Middleware {

    private let developerService: DeveloperService
    private let hasher: HashProtocol

    init(developerService: DeveloperService,
         hasher: HashProtocol)
    {
        self.developerService = developerService
        self.hasher = hasher
    }

    public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        guard let timestamp = request.headers["X-Timestamp"],
            let hash = request.headers["X-Hash"],
            let publicKey = request.headers["X-PublicKey"] else {
                return MissingParameters.error
        }
        
        do {
            let privateKey = try developerService.getPrivateKey(with: publicKey)
            do {
                let generatedHash = try generateHash(publicKey, privateKey: privateKey, timestamp: timestamp)
                if hash != generatedHash {
                    return InvalidHash.error
                }
            } catch {
                return ServerError.error
            }
        } catch {
            return InvalidPrivateKey.error
        }

        return try next.respond(to: request)
    }

    // MARK: - Helper

    /// Generate api hash string, it's made by sha256(privateKey+timestamp+publicKey)
    private func generateHash(_ publicKey: String, privateKey: String, timestamp: String) throws -> String {
        return try! hasher.make("\(privateKey)\(timestamp)\(publicKey)").makeString()
    }
}
