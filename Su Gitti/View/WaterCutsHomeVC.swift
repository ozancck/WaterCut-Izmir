//
//  WaterCutsHomeVC.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 5.02.2024.
//

import UIKit

class WaterCutsHomeVC: UIViewController {
    
    var viewModel = WaterCutHomeViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.fetchWaterCuts { [weak self] error in
            if let error = error {
                print("Veri çekme hatası: \(error.localizedDescription)")
            } else {
                
                print(self?.viewModel.formatDateString((self?.viewModel.waterCuts[0].ArizaGiderilmeTarihi)!) as Any)
                self?.updateUI()
                //print(self?.viewModel.waterCuts as Any)
            }
            
        }
        
        
        
       

        
    }
    
    func updateUI() {
         
      }
    


}
