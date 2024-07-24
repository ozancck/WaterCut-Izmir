//
//  MaviBayrakDetailVC.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 20.07.2024.
//

import MapKit
import UIKit

class MaviBayrakDetailVC: UIViewController {
    var maviBayrak: OnemliYer?

    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet var mapKit: MKMapView!

    @IBOutlet var nameTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        backButton.addgesture(target: self, action: #selector(backButtonTapped))
        
        nameTitle.text = maviBayrak?.adi

        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: maviBayrak!.enlem, longitude: maviBayrak!.boylam)
        annotation.title = maviBayrak?.adi
        annotation.subtitle = ""
        mapKit.addAnnotation(annotation)
        
        
        let coordinate = CLLocationCoordinate2D(latitude: maviBayrak!.enlem, longitude: maviBayrak!.boylam)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapKit.setRegion(region, animated: true)
    }
                              
                              
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
                              
                              
                              
}
