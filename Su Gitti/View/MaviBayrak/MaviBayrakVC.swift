//
//  MaviBayrakVC.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 20.07.2024.
//

import UIKit

class MaviBayrakVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var TABLEVİEW: UITableView!
    
    
    var viewModal = MaviBayrakHomeViewModel()
    var maviBayrakList : [OnemliYer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        TABLEVİEW.dataSource = self
        TABLEVİEW.delegate = self
        
        TABLEVİEW.register(UINib(nibName: "MaviBayrakCell", bundle: nil), forCellReuseIdentifier: "MaviBayrakCell")
        
        
        viewModal.fetchMaviBayrak { [weak self] error in
            if let error = error {
                print("Veri çekme hatası: \(error.localizedDescription)")
            } else {
                
                if let maviBayrak =  self?.viewModal.maviBayrak {
                    self?.maviBayrakList = maviBayrak.onemliYer
                }
          
                
                self?.updateUI()
                
                //print(self?.viewModel.waterCuts as Any)
            }
        }
     
        
        

        
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Mavi Bayraklı Plajlar"
    }
    
    func updateUI(){
        TABLEVİEW.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maviBayrakList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TABLEVİEW.dequeueReusableCell(withIdentifier: "MaviBayrakCell", for: indexPath) as! MaviBayrakCell
        
        cell.nameTitle.text = self.maviBayrakList[indexPath.row].adi
        cell.cityTitle.text = self.maviBayrakList[indexPath.row].ilce
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(identifier: "MaviBayrakDetailVC") as! MaviBayrakDetailVC
        vc.maviBayrak = self.maviBayrakList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        maviBayrakList = searchText.isEmpty ? viewModal.maviBayrak!.onemliYer : viewModal.maviBayrak!.onemliYer.filter { message in
            return (message.adi.range(of: searchText, options: .caseInsensitive) != nil) ||
                    (message.ilce.range(of: searchText, options: .caseInsensitive) != nil)
        }
        
         TABLEVİEW.reloadData()
     }
    



}
