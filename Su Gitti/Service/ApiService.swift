//
//  ApiService.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 5.02.2024.
//

import Foundation
import Alamofire

import Alamofire

class ApiService {
    static let shared = ApiService()

    private init() {}

    func fetchWaterCuts(completion: @escaping ([WaterCut]?, Error?) -> Void) {
        AF.request("https://openapi.izmir.bel.tr/api/izsu/arizakaynaklisukesintileri", method: .get).responseDecodable(of: [WaterCut].self) { response in
            switch response.result {
            case let .success(data):
                completion(data, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}


