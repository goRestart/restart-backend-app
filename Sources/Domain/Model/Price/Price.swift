import Foundation

public struct Price {
    
    public let amount: Double
    public let locale: Locale
    
    public init(amount: Double, locale: Locale) {
        self.amount = amount
        self.locale = locale
    }
}
