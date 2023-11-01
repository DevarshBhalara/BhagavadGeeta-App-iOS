//
//  ApiManager+Request.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//

import Foundation
import Alamofire

enum RequestItemsType: Equatable {
    case chapters
    case slok(String, String)
    case chapter(String)
}

// MARK: Extensions
// MARK: EndPointType

extension RequestItemsType: EndPointType {
    
    // MARK: Vars & Lets
    
    var baseURL: String {
        return AppConstants.baseApi
    }
    
    var version: String {
        ""
    }
    
    var path: String {
        switch self {
        case .chapters:
            return "chapters"
        case .slok(let ch, let sl):
            return "slok/\(ch)/\(sl)"
        case .chapter(let ch):
            return "chapter/\(ch)"
        }
    }
    
    var httpMethod: HTTPMethod {
        HTTPMethod.get
    }
    
    var headers: HTTPHeaders? {
        []
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.path)!
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
}

