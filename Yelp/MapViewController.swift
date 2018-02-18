//
//  MapViewController.swift
//  Yelp
//
//  Created by Mario Martinez on 2/17/18.
//  Copyright © 2018 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var business: Business!
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        plotOnMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func plotOnMap() {
        if let address = business.address{
            
            self.address = address
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) {
                
                placemarks, error in
                let placemark = placemarks?.first
                let lat = placemark?.location?.coordinate.latitude
                let lon = placemark?.location?.coordinate.longitude
                let centerlocation = CLLocation(latitude: lat!, longitude: lon!)
                
                self.goToLocation(location: centerlocation)
                
            }
            
        }
    }
    
    func goToLocation(location: CLLocation) {
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        
        mapView.setRegion(region, animated: false)
        
        addAnnotationAtAddress(address: self.address, title: business.name!)
        
    }
    
    func addAnnotationAtAddress(address: String, title: String) {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    
                    let coordinate = placemarks.first!.location!
                    let annotation = MKPointAnnotation()
                    
                    annotation.coordinate = coordinate.coordinate
                    annotation.title = title
                    
                    self.mapView.addAnnotation(annotation)
                    
                }
            }
        }
    }
}
