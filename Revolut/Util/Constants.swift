struct Constants {
    struct Messages {
        static let defaultError = "Ops. Something happened. Please, try again later"
    }
    
    struct CurrencyConversion {
        static let initialValue:Double = 100
        static let initialCurrencyViewModel = CurrencyViewModel(currency: Currency.euro, rate: 1)
    }
    
    static let CurrencyRateListTitle = "Rates & Conversions"
}
