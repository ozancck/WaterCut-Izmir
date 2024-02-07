//
//  WaterCutsHomeViewModel.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 5.02.2024.
//

import Foundation


class WaterCutHomeViewModel {
    var waterCuts: [WaterCut] = []

    func fetchWaterCuts(completion: @escaping (Error?) -> Void) {
        ApiService.shared.fetchWaterCuts { [weak self] waterCuts, error in
            if let error = error {
                print("Hata: \(error)")
                completion(error)
            } else if let waterCuts = waterCuts {
                self?.waterCuts = waterCuts
                completion(nil)
            }
        }
    }
    
    
    func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        }

        return nil
    }
}
