import Foundation
class ConversionManager {
    let service = CurrencyRatesService()
    var timer = Timer()
    var onUpdateRates: ((_ currencies: [CurrencyViewModel])->Void)?
    var baseCurrency: CurrencyViewModel {
        didSet {
            updateCurrencies()
        }
    }
    
    var currencyRates:[String:Double] = [:] {
        didSet {
            updateCurrencies()
        }
    }
    
    init(baseCurrency: CurrencyViewModel) {
        self.baseCurrency = baseCurrency        
    }
    
    func updateCurrencies() {
        let currencies = Currency.allCurrencies.filter {$0.code != baseCurrency.currencyCode}
        let vms = currencies.compactMap { (currency) -> CurrencyViewModel? in
            return CurrencyViewModel(currency: currency, rate: currencyRates[currency.code] ?? 1)
        }
        onUpdateRates?(vms)
    }
    
    func cancelRequests() {
        timer.invalidate()
        service.cancelRequests()
    }
    
    func startPollingRates() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {[weak self] (timer) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.updateCurrencyRates()
        })
    }
    
    func updateCurrencyRates() {
        service.getRates(baseCurrency: baseCurrency.currencyCode) {[weak self] (error, rates) in
            guard let strongSelf = self else {
                return
            }
            guard let rates = rates else {
                return
            }
            strongSelf.currencyRates = rates
        }
    }
        
}
