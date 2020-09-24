//
//  MapViewController.swift
//  ArduinoTracker
//
//  Created by Rob Piccirillo on 9/14/20.
//  Copyright © 2020 Rob Piccirillo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
//class MapViewController: UIViewController {
        
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()

    // Current location 
    
    
    //fileprivate let locationManager:CLLocationManager = CLLocationManager()
 //   let manager = CLLocationManager()
    
 //   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  //  {
//        let location = locations[0]
//        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
//        mapView.setRegion(region, animated: true)
        
//        print(location.altitude)
//        print(location.speed)
        
//        self.mapView.showsUserLocation = true
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled() == true {
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
                
            }
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            print("Please turn on location services ")
        }
        
      //  manager.delegate = self
      //  manager.desiredAccuracy = kCLLocationAccuracyBest
      //  manager.requestWhenInUseAuthorization()
      //  manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations
        location: [CLLocation]){
       // self.mapView
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location[0].coordinate.latitude, longitude: location[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            mapView.setRegion(region, animated: true)

        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


