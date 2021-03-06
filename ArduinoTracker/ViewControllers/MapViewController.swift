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
import Firebase

class MapViewController: UIViewController, CLLocationManagerDelegate {
//class MapViewController: UIViewController {
        
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()

    // Current location is hard coded to NYC
    
    
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
    
    func useCurrentLoc() -> Bool
    {
        return false
    }
    
    //Using current location of the device
    func locationManager(_ manager: CLLocationManager, didUpdateLocations
        location: [CLLocation])
    {
        print(useCurrentLoc())
        if (useCurrentLoc() == true)
        {
            
            guard let location = location.last else {return}
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(region, animated: true)
        }
        else
        {
            //readDBLocation()

            let db = Firestore.firestore()
            
            let docRef = db.collection("userLocation").document("Hofstra")
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists
                {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    let lat = document.get("latitude") as! Double
                    let long = document.get("longitude") as! Double
                    let coord = CLLocationCoordinate2DMake(lat, long)
                    let region = MKCoordinateRegion.init(center: coord, latitudinalMeters: 200, longitudinalMeters: 200)
                    self.mapView.setRegion(region, animated: true)
                }
                
                else
                {
                    print("Document does not exist")
                }
            }


        }
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
        {
            //checkLocationAuthorization()
        }
    }
    

    /*func readDBLocation() -> CLLocationCoordinate2D
    {
        let db = Firestore.firestore()
        
        let docRef = db.collection("userLocation").document("Hofstra")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists
            {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                let lat = document.get("latitude") as! Double
                let long = document.get("longitude") as! Double
                var coord = CLLocationCoordinate2DMake(lat, long)
                return coord

            }
            
            else
            {
                print("Document does not exist")
            }
        }

    }*/
/*
       // self.mapView
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location[0].coordinate.latitude, longitude: location[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)) // For zooming into the map
            mapView.setRegion(region, animated: true)

        }

    }

/*extension MapScreen: CLLocationManagerDelegate {
    
}*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
*/

}
