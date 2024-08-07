//
//  WaterCutsHomeVC.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 5.02.2024.
//

import UIKit

class WaterCutsHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
    
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    var viewModel = WaterCutHomeViewModel()
    
    var filteredWaterCuts: [WaterCut] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        searchbar.delegate = self
        
        
        //self.tabBarItem.badgeValue = "Su kesintisi mevcut"
        
        
        
        
    
        
        
        
        
        
        
        viewModel.fetchWaterCuts { [weak self] error in
            if let error = error {
                print("Veri çekme hatası: \(error.localizedDescription)")
            } else {
                
                print(self?.viewModel.formatDateString((self?.viewModel.waterCuts[0].ArizaGiderilmeTarihi)!) as Any)
                
                self?.filteredWaterCuts = self!.viewModel.waterCuts
                
                self?.updateUI()
                
                //print(self?.viewModel.waterCuts as Any)
            }
            
        }
        
        
    }

   
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SU KESINTILERI"
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredWaterCuts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "WaterCutsHomeTableViewCell", for: indexPath) as! WaterCutsHomeTableViewCell
        
        cell.title.text = filteredWaterCuts[indexPath.row].IlceAdi
        cell.desc.text = filteredWaterCuts[indexPath.row].Mahalleler.lowercased()
        cell.imageview.image = UIImage(systemName: "drop.circle.fill")
        
        cell.imageview.tintColor = .red
        
            
        
        
        return cell
        
    }
    
   
     
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
            
        
        if  segue.identifier == "WaterCutDetailsSegue" {
            view.endEditing(true)
            if let destination = segue.destination as? WaterCutDetails
                ,let rowIndex = tableview.indexPathForSelectedRow?.row
            {
                
                destination.waterCut = filteredWaterCuts[rowIndex]
                
                if let selectionIndexPath = tableview.indexPathForSelectedRow {
                    tableview.deselectRow(at: selectionIndexPath, animated: true )
                }
            }
        }
    }
    
    
    func updateUI() {
        tableview.reloadData()
      }
  
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredWaterCuts = searchText.isEmpty ? viewModel.waterCuts : viewModel.waterCuts.filter { message in
             return (message.IlceAdi.range(of: searchText, options: .caseInsensitive) != nil) ||
                    (message.Mahalleler.range(of: searchText, options: .caseInsensitive) != nil)
         }
        
         tableview.reloadData()
     }


}
