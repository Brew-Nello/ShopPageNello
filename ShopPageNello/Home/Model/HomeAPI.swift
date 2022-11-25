//
//  HomeAPI.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/22.
//

import Moya

enum HomeAPI {
    case initialization
    case pagination(_ lastId: Int? = nil)
}

extension HomeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://d2bab9i9pr8lds.cloudfront.net")!
    }
    
    var path: String {
        switch self {
        case .initialization:
            return "api/home"
        case .pagination(_):
            return "api/home/goods"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .initialization:
            return .get
        case .pagination(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .initialization:
            return .requestPlain
        case .pagination(let lastId):
            let parameters: [String : Any] = [
                "lastId": lastId!
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var sampleData: Data { Data() }
    
}
