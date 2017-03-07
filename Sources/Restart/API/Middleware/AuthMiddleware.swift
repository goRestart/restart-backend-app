import HTTP
import Vapor

private struct ApiParams {
    static let timestamp = "ts"
    static let hash = "hash"
    static let publicKey = "publicKey"
}

struct ApiMiddleware: Middleware {

    private let developerService: DeveloperService
    private let hasher: HashProtocol

    init(developerService: DeveloperService,
         hasher: HashProtocol)
    {
        self.developerService = developerService
        self.hasher = hasher
    }

    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        let response = try next.respond(to: request)

        guard let timestamp = request.data[ApiParams.timestamp]?.int,
              let hash = request.data[ApiParams.hash]?.string,
              let publicKey = request.data[ApiParams.publicKey]?.string else {
                throw MissingParameters.error
        }

        do {
            let privateKey = try developerService.getPrivateKey(with: publicKey)
            do {
                let generatedHash = try generateHash(publicKey, privateKey: privateKey, timestamp: timestamp)
                if hash != generatedHash {
                    throw InvalidHash.error
                }
            } catch {
                throw ServerError.error
            }
        } catch {
            throw InvalidPrivateKey.error
        }

        return response
    }

    // MARK: - Helper

    /// Generate api hash string, it's made by sha256(privateKey+timestamp+publicKey)
    private func generateHash(_ publicKey: String, privateKey: String, timestamp: Int) throws -> String {
        return try! hasher.make("\(privateKey)\(timestamp)\(publicKey)")
    }
}
