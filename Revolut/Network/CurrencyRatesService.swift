import Foundation
import Alamofire

class CurrencyRatesService: APIClient {
    var request: DataRequest?
    
    func cancelRequests() {
        self.request?.cancel()
    }
    
    func getRates(baseCurrency: String, completion:@escaping (_ error: Error?, _ currencyList:[String:Double]?) -> Void) {
        self.request = request(APIRouter.latestRates(base: baseCurrency), resultType: CurrencyRateResponse.self) { (result) in
            switch result {
            case .Failure(let err):
                completion(err, nil)
            case .Success(let rateResponse):
                completion(nil,rateResponse.rates)
            }
        }
    }
}
