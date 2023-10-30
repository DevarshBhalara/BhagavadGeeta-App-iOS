//
//  ApiManager.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//

import Alamofire
import UIKit
import Reachability

class APIManager {
    
    // MARK: Vars & Lets
    private let sessionManager: Session
    private let interceptor: APIManagerInterceptor
    let reachability = try? Reachability()
    static let shared = APIManager(interceptor: APIManagerInterceptor())
    static let errorCodeList =  [400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 421, 422, 423, 424, 425, 426, 427, 428, 429, 431, 451, 500, -1009, -1001]
    
    // MARK: Methods
    func call<T>(type: RequestItemsType, params: Parameters? = nil, handler: @escaping (Result<T, CustomError>) -> Void) where T: Codable {
        
        guard reachability?.connection ?? .unavailable != .unavailable else {
            handler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.noInternet)))
            return
        }
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseData { (data) in
            if self.handleResponseCode(res: data) {
                do {
                    guard let jsonData = data.data else {
                        handler(.failure(.init(title: APIError.errorAlertTitle, body: APIError.noData)))
                        return
                    }
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try jsonDecoder.decode(BaseResponse<T>.self, from: jsonData)
                    
                    if result.success {
                        if let data = result.data {
                            handler(.success(data))
                        }
                    } else {
                        handler(.failure(.init(title: APIError.errorAlertTitle, body: result.message)))
                    }
                    
                    
                } catch {
                    handler(.failure(self.parseApiError(dataResponse: data)))
                }
            } else {
                handler(.failure(self.parseApiError(dataResponse: data)))
            }
        }
    }
    
    //MARK: - Uplaod Image Api
    func callUploadApi<T>(type: RequestItemsType, image: UIImage ,params: Parameters? = nil, handler: @escaping (Result<T, CustomError>) -> Void, progress: @escaping (Progress) -> Void) where T: Codable {
        
      
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            handler(.failure(.init(title: "Appname", body: "Image not found")))
            return
        }
        
        self.sessionManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }, to: type.url)
        .responseData { response in
            print(response)
            
            guard let data = response.data else {
                handler(.failure(.init(title: "AppName", body: "Data not Found")))
                return
            }
            
            if self.handleResponseCode(res: response) {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    print(response)
                    handler(.success(response))
                } catch let error {
                    handler(.failure(.init(title: "AppName", body: "Not able to response \(error)")))
                }
            }
        }.uploadProgress {
            progressCount in
            progress(progressCount)
        }
    }
    
    
    // Handle Response
    private func handleResponseCode(res: AFDataResponse<Data>?) -> Bool {
        var isSuccess: Bool = false
        
        guard let dataResponse = res else {
            return isSuccess
        }
        guard let response = dataResponse.response else {
            return isSuccess
        }
        
        switch response.statusCode {
        case 200...300:
            isSuccess = true
        default: break
        }
        
        return isSuccess
    }
    
    // MARK: - Initializer
    private init(interceptor: APIManagerInterceptor) {
        self.interceptor = interceptor
        self.sessionManager = Session(interceptor: interceptor)
    }
    
}
