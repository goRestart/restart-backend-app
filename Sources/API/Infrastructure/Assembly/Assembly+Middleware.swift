import ServiceLocator

extension Assembly {

    func getApiAuthMiddleware() -> ApiAuthMiddleware {
        let droplet = getDroplet()
        return ApiAuthMiddleware(
            developerService: getDeveloperService(),
            hasher: droplet.hash
        )
    }
}
