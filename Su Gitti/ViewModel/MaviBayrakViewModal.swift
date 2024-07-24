//
//  MaviBayrakViewModal.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 20.07.2024.
//

import Foundation


class MaviBayrakHomeViewModel {
    
    
    var maviBayrak: DataModel?
    
    
    func fetchMaviBayrak(completion: @escaping (Error?) -> Void) {
        ApiService.shared.fetchMaviBayrak { [weak self] maviBayrak, error in
            if let error = error {
                print("Hata: \(error)")
                completion(error)
            } else if let waterCuts = maviBayrak {
                self?.maviBayrak = waterCuts
                completion(nil)
            }
        }
    }

}



