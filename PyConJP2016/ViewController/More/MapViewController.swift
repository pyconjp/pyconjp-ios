//
//  MapViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 2016/03/10.
//  Copyright © 2016 Yutaro Muta. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    private var venue: Venue?
    
    class func build(venue: Venue) -> MapViewController {
    	let mapViewController = UIStoryboard(name: "More", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("MapViewController") as! MapViewController
        mapViewController.venue = venue
        return mapViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let venue = venue else { return }
        
        textView.text = venue.address
        
        mapView.setCenterCoordinate(venue.location, animated: true)
        
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum Venue {
        case Waseda
        case Microsoft
        
        var name: String {
            switch self {
            case .Waseda:
                return "早稲田大学西早稲田キャンパス"
            case .Microsoft:
                return "日本マイクロソフト株式会社"
            }
        }
        
        var location: CLLocationCoordinate2D {
            switch self {
            case .Waseda:
                return CLLocationCoordinate2D(latitude: 35.706069, longitude: 139.706809)
            case .Microsoft:
                return CLLocationCoordinate2D(latitude: 35.626670, longitude: 139.740375)
            }
        }
        
        var address: String {
            switch self {
            case .Waseda:
                return "〒169-8555\n東京都新宿区大久保 3-4-1\n早稲田大学西早稲田キャンパス"
            case .Microsoft:
                return "〒108-0075\n東京都港区港南 2-16-3\n品川グランドセントラルタワー"
            }
        }
        
    }

}
