import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    static let baseUrl = "https://revolut.duckdns.org"
    case latestRates(base: String)
    
    private var path: String {
        switch self {
        case .latestRates:
            return "/latest"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .latestRates:
            return .get
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .latestRates(let base):
            return ["base":base]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpShouldHandleCookies = true
        
        if method == .post {
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        } else {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
