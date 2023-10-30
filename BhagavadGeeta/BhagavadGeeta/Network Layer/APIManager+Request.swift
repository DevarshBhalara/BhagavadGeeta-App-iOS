//
//  ApiManager+Request.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//

import Foundation
import Alamofire

enum RequestItemsType: Equatable {
    case login
    case initialProducts
    case signUp
    case categoryProduct(String)
    case sellerProducts
    case uploadImage
    case addProduct
    case seachHistory(String)
}

// MARK: Extensions
// MARK: EndPointType

extension RequestItemsType: EndPointType {
    
    // MARK: Vars & Lets
    
    var baseURL: String {
        
        switch self {
        case .login, .initialProducts, .signUp, .categoryProduct, .sellerProducts, .addProduct, .seachHistory:
            return AppConstants.baseApi
        case .uploadImage:
            return AppConstants.uploadImageApi
        }
    }
    
    var version: String {
        switch self {
        case .login, .initialProducts, .signUp, .categoryProduct, .sellerProducts, .addProduct, .seachHistory:
            return AppConstants.apiVersion
        case .uploadImage:
            return "1/"
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .initialProducts:
            return "get-product/"
        case .signUp:
            return "sign-up/"
        case .categoryProduct(let category):
            return "get-product?category=\(category)"
        case .sellerProducts:
            return "seller-product"
        case .uploadImage:
            return "upload"
        case .addProduct:
            return "add-product"
        case .seachHistory(let query):
            return "search-product?search=\(query)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .signUp, .uploadImage, .addProduct:
            return .post
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .login, .uploadImage, .signUp:
            return []
        default:
            return ["Authorization" : KeychainHelper.shared.accessToken ?? ""]
        }
    }
    
    var url: URL {
        switch self {
        case .uploadImage:
            return URL(string: self.baseURL + self.version + self.path + "?" + "key=f8fe9a449ea4b2a9b7387b9e0d3d59c7")!
        default :
            return URL(string: self.baseURL + self.version +  self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
}

