struct CurrencyRateResponse: Codable {
    let base: String
    let date: String
    let rates: [String:Double]
}
