//
//  BusLocationVC.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 21.07.2024.
//

import MapKit
import UIKit

class BusLocationVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var mapKit: MKMapView!

    var busLocationFetcher: BusLocationFetcher!
    var busAnnotations: [MKPointAnnotation] = []
    var locationManager: CLLocationManager!

    var userAnnotation: MKPointAnnotation?
    var initialRegionSet = false

    @IBOutlet var textField: UITextField!
    @IBOutlet var textFieldBackground: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldBackground.backgroundColor = .white
        textFieldBackground.applyCornerRadiusWithShadow()

        mapKit.delegate = self
        mapKit.showsUserLocation = true

        // CLLocationManager ayarlama
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // Konum izni isteme
        locationManager.startUpdatingLocation()
    }

    @IBAction func getbuttonClicked(_ sender: Any) {
        resetMapView()

        busLocationFetcher = BusLocationFetcher(routeNumber: textField.text ?? "")
        busLocationFetcher.startFetching { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(busLocations):
                    self?.updateBusLocationsOnMap(busLocations)
                    if !(self?.initialRegionSet ?? false) {
                        self?.setRegionForAnnotations()
                        self?.initialRegionSet = true
                    }
                case let .failure(error):
                    print("Hata: \(error)")
                }
            }
        }
    }

    func updateBusLocationsOnMap(_ busLocations: [BusLocation]) {
        // Mevcut anotasyonları kaldır
        mapKit.removeAnnotations(busAnnotations)
        busAnnotations.removeAll()

        for bus in busLocations {
            let annotation = MKPointAnnotation()

            if let latitude = Double(bus.koorX.replacingOccurrences(of: ",", with: ".")),
               let longitude = Double(bus.koorY.replacingOccurrences(of: ",", with: ".")) {
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                annotation.title = "Otobüs ID: \(bus.otobusId)"
                annotation.subtitle = "Yön: \(bus.yon)"
                busAnnotations.append(annotation)
            }
        }

        mapKit.addAnnotations(busAnnotations)
    }

    func setRegionForAnnotations() {
        var zoomRect = MKMapRect.null

        for annotation in busAnnotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.1, height: 0.1)
            zoomRect = zoomRect.union(pointRect)
        }

        if let userLocation = mapKit.userLocation.location {
            let userPoint = MKMapPoint(userLocation.coordinate)
            let userRect = MKMapRect(x: userPoint.x, y: userPoint.y, width: 0.1, height: 0.1)
            zoomRect = zoomRect.union(userRect)
        }

        mapKit.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
    }

    // CLLocationManagerDelegate methodları
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Kullanıcı konumu burada güncellenmez
    }

    func resetMapView() {
        // 1. Tüm anotasyonları kaldırın
        mapKit.removeAnnotations(mapKit.annotations)

        // 2. Haritanın bölgesini varsayılan bir konuma ayarlayın
        let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // Örneğin San Francisco
        let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let defaultRegion = MKCoordinateRegion(center: defaultCoordinate, span: defaultSpan)
        mapKit.setRegion(defaultRegion, animated: true)

        // 3. Diğer durum değişkenlerini sıfırlayın (örneğin initialRegionSet)
        initialRegionSet = false
    }
}
