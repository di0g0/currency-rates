struct CurrencyViewModel {
    private let currency: Currency
    private let rate: Double
    var value: Double = 0
    
    init(currency: Currency, rate: Double) {
        self.currency = currency
        self.rate = rate
    }
    
    var currencyCode: String {
        return currency.code
    }
    
    var currencyName: String {
        return currency.name
    }
    
    var countryCode: String {
        return String(currency.code.prefix(2))
    }
    
    var convertedValue: Double {
        return value * rate
    }
    
    var formatedValue: String {
        return convertedValue.currencyString
    }
}
