//
//  MapViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/10.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    private var venue: Venue?
    
    class func build(venue: Venue) -> MapViewController {
        let mapViewController = UIStoryboard(name: "More", bundle: Bundle.main).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapViewController.venue = venue
        return mapViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let venue = venue else { return }
        
        textView.text = venue.address
        
        mapView.setCenter(venue.location, animated: true)
        
        var region: MKCoordinateRegion = mapView.region
        region.center = venue.location
        region.span.latitudeDelta = 0.01
        region.span.longitudeDelta = 0.01
        mapView.setRegion(region, animated:true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = venue.location
        annotation.title = venue.name
        mapView.addAnnotation(annotation)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.setContentOffset(.zero, animated: false)
    }
    
    enum Venue {
        case waseda
        case microsoft
        
        var name: String {
            switch self {
            case .waseda: return NSLocalizedString("NameWaseda", tableName: "Map", comment: "")
            case .microsoft: return NSLocalizedString("NameMicrosoft", tableName: "Map", comment: "")
            }
        }
        
        var location: CLLocationCoordinate2D {
            switch self {
            case .waseda: return CLLocationCoordinate2D(latitude: 35.706069, longitude: 139.706809)
            case .microsoft: return CLLocationCoordinate2D(latitude: 35.626670, longitude: 139.740375)
            }
        }
        
        var address: String {
            switch self {
            case .waseda: return NSLocalizedString("AddressWaseda", tableName: "Map", comment: "")
            case .microsoft: return NSLocalizedString("AddressMicrosoft", tableName: "Map", comment: "")
            }
        }
        
    }
    
}
