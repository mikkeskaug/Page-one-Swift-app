//
//  MapViewController.swift
//  Page one - Din lokale Apple forhandler
//
//  Created by Jon Mikael Skaug on 23.02.2018.
//  Copyright © 2018 MiTo Creative. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

//  Add stuff from storyboard
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var veiLabel: UIButton!
    
    let locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Kart"
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
       
        
//      Initiate map type
        mapView.mapType = MKMapType.standard
        
//      Set Location
        let location = CLLocationCoordinate2D(latitude: 59.268865,longitude: 10.410264)
        
        
//      Add store location to map
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Page one Consultants AS"
        annotation.subtitle = "Tønsberg"
        mapView.addAnnotation(annotation)
        
//      Add user location to map
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = userLocation
        annotation2.title = "Min posisjon"
        mapView.addAnnotation(annotation2)
       
        let span = MKCoordinateSpan.init(latitudeDelta: 0.5, longitudeDelta:
        0.5)
        let coordinate = CLLocationCoordinate2D.init(latitude: location.latitude, longitude: location.longitude) // provide you lat and long
        let region = MKCoordinateRegion.init(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
       
        
       
        locationManager.stopUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
            print("locations = \(locValue.latitude) \(locValue.longitude)")
        
            userLocation.longitude = locValue.longitude
            userLocation.latitude = locValue.latitude
            
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
//  Button action for veibeskrivelse
    @IBAction func btnPress(_ sender: Any) {
        
        let longitude = userLocation.longitude
        let latitude = userLocation.latitude
        
        
        
        let directionsURL = "http://maps.apple.com/?saddr=\(latitude),\(longitude)&daddr=59.268865,10.410264"
        guard let url = URL(string: directionsURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
//  viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
    }
    



}
    



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
