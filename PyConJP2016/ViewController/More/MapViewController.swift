//
//  MapViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/10.
//  Copyright © 2016年 Yutaro Muta. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let location = CLLocationCoordinate2D(latitude: 35.4941, longitude: 139.4315)
        mapView.setCenterCoordinate(location, animated: true)
        
        var region:MKCoordinateRegion = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        mapView.setRegion(region,animated:true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "foobar"
        mapView.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
