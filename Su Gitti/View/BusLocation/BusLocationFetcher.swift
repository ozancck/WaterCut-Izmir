//
//  BusLocationFetcher.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 21.07.2024.
//

import Foundation
import SVProgressHUD


class BusLocationFetcher {
    var timer: Timer?
    var routeNumber: String
    var updateInterval: TimeInterval
    
    init(routeNumber: String, updateInterval: TimeInterval = 5.0) {
        self.routeNumber = routeNumber
        self.updateInterval = updateInterval
    }
    
    func startFetching(completion: @escaping (Result<[BusLocation], Error>) -> Void) {
        fetchBusLocations(completion: completion)
        timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] _ in
            self?.fetchBusLocations(completion: completion)
        }
    }
    
    func stopFetching() {
        timer?.invalidate()
        timer = nil
    }
    
    private func fetchBusLocations(completion: @escaping (Result<[BusLocation], Error>) -> Void) {
        SVProgressHUD.show()
        let urlString = "https://openapi.izmir.bel.tr/api/iztek/hatotobuskonumlari/\(routeNumber)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Geçersiz URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                SVProgressHUD.dismiss()
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                SVProgressHUD.dismiss()
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Veri yok"])))
                return
            }
            
            do {
                SVProgressHUD.dismiss()
                let response = try JSONDecoder().decode(BusLocationResponse.self, from: data)
                completion(.success(response.hatOtobusKonumlari))
            } catch {
                SVProgressHUD.dismiss()
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}



