//
//  ViewController.swift
//  venue
//
//  Created by Dmitriy Butin on 10.05.2020.
//  Copyright © 2020 Dmitriy Butin. All rights reserved.
//

import UIKit
import GoogleMaps
import Foundation

class MainScreenViewController: UIViewController {
    
    var presenter: MainScreenPresenterProtocol!
    var isMark: Bool = false
    
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var intervalSC: UISegmentedControl!
    @IBOutlet weak var zoomLabel: UILabel!
    @IBOutlet weak var zoomSlider: UISlider!
    @IBOutlet weak var mapView: GMSMapView!
    
    let infoMarker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        
        ModuleBulder.mainScreenConfigure(view: self)
        navigationController?.navigationBar.isHidden = true
        sliderSetup()
        presenter.startLocationService()
        mapViewSetup()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAccount()
        if isMark {
            mapView.clear()
            presenter.createMarkers()
        }
    }

    func checkAccount() {
        if UserDefaults.standard.bool(forKey: "logined"){
            accountButton.setBackgroundImage(
                UIImage(systemName: "person.fill"), for: .normal)
        } else {
            accountButton.setBackgroundImage(
                UIImage(systemName: "person"), for: .normal)
        }
    }
    
    func mapViewSetup() {
        mapView.isMyLocationEnabled = true
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.settings.indoorPicker = true
    }
    
    func sliderSetup() {
        zoomSlider.minimumValue = 0
        zoomSlider.maximumValue = 20
        zoomSlider.value = 16
    }
    
    
    @IBAction func zoomSliderAction(_ sender: UISlider) {
        mapView.animate(toZoom: zoomSlider.value)
        zoomLabel.text = String(format: "Zoom: %.1f ",
                                zoomSlider.value * 5) + "%"
    }
    
    @IBAction func addNewMarkerButtonTap() {
        addNewMarker()
    }
    
    @IBAction func accountButtonTap() {
        presenter.checkUserLoginStatus()
        //presenter.goLoginScreen()
    }
    
    @IBAction func unwindToMain(_ :UIStoryboardSegue) -> Void {}
    
    func addNewMarker() {
        if UserDefaults.standard.bool(forKey: "logined") {
            if isMark {
                presenter.goAddMarkerScreen()
            } else {
                zoomLabel.text = "укажите точку на карте"
            }
        } else {
            presenter.goAccountScreen()
        }
    }
    
    
} //ViewController

extension MainScreenViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        mapView.clear()
        presenter.createMarkers()
        isMark = true
        EventData.shared.coordinateEvent = coordinate
        EventData.shared.placeEvent = ""
        marker.map = mapView
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("\(marker.title ?? "No marker")")
        return false
    }
    

    // Attach an info window to the POI using the GMSMarker.
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        isMark = true
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0
        EventData.shared.coordinateEvent = location
        EventData.shared.placeEvent = name
        //infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }
    
}


extension MainScreenViewController: MainScreenProtocol {
    
    func setMarkers(markers: [GMSMarker]) {
        for marker in markers {
            marker.map = mapView
        }
    }

    
}
