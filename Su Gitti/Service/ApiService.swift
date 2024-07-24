//
//  ApiService.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 5.02.2024.
//

import Alamofire
import Foundation
import SVProgressHUD

class ApiService {
    static let shared = ApiService()

    private init() {}

    func fetchWaterCuts(completion: @escaping ([WaterCut]?, Error?) -> Void) {
        SVProgressHUD.show()
        AF.request("https://openapi.izmir.bel.tr/api/izsu/arizakaynaklisukesintileri", method: .get).responseDecodable(of: [WaterCut].self) { response in
            switch response.result {
            case let .success(data):
                completion(data, nil)
                SVProgressHUD.dismiss()
            case let .failure(error):
                completion(nil, error)
                SVProgressHUD.showError(withStatus: "\(error)")
            }
        }
    }
    
    
    func fetchMaviBayrak(completion: @escaping (DataModel?, Error?) -> Void) {
        SVProgressHUD.show()
        AF.request("https://openapi.izmir.bel.tr/api/ibb/cbs/mavibayrakplajlar", method: .get).responseDecodable(of: DataModel.self) { response in
            switch response.result {
            case let .success(data):
                completion(data, nil)
                SVProgressHUD.dismiss()
            case let .failure(error):
                completion(nil, error)
                SVProgressHUD.showError(withStatus: "\(error)")
            }
        }
    }
}
