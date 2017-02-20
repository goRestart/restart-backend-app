import Vapor
import Fluent
import VaporMySQL

extension Application {

    func prepare(_ droplet: Droplet) {
        try? droplet.addProvider(VaporMySQL.Provider)
        droplet.preparations.append(SuggestionDiskModel.self)
    }
}
