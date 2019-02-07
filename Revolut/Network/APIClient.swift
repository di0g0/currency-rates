import Foundation
import Alamofire

enum APIClientError: Error {
    case jsonParsingError
    case serverError
    case other
    
    var localizedDescription: String {
        return Constants.Messages.defaultError
    }
}

public enum APIResult<T> {
    case Failure(Error)
    case Success(T)
}

protocol APIClient {
    func request<T>(_ request: URLRequestConvertible, resultType:T.Type, completion: @escaping ((APIResult<T>) -> Void)) -> DataRequest where T: Decodable
}

extension APIClient {
    func request<T>(_ request: URLRequestConvertible, resultType: T.Type, completion: @escaping ((APIResult<T>) -> Void)) -> DataRequest where T : Decodable {
        return Alamofire.request(request)
            .validate()
            .responseData { (response) in
                guard response.result.isSuccess,
                    let data = response.result.value else {
                        completion(.Failure(APIClientError.serverError))
                        return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(resultType, from: data)
                    completion(.Success(obj))
                }
                catch {
                    completion(.Failure(APIClientError.jsonParsingError))
                }
                
        }
    }
}
