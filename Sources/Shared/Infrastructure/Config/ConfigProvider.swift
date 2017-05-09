import Foundation
import Vapor

protocol ConfigProvider {
    func config() throws -> Config
}
