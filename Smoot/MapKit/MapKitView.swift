//
//  MapKitView.swift
//  Smoot
//
//  Created by Julian Kronlachner on 30.05.18.
//  Copyright © 2018 73. All rights reserved.
//

import UIKit
import MapKit


class MapView_NewRoute: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var overlay : MKTileOverlay?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        

        mapView.add(setupTileRenderer())
        let n = Navigator.init()
        let nav = n.navigate(source: CLLocationCoordinate2D.init(latitude: 40.712775, longitude: -74.005973), destination: .init(latitude: 34.052234, longitude: -118.243685), sourceDate: Date.init(), transport: .AUTO, mapView: mapView)
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if(overlay.isKind(of: MKPolyline.classForCoder())){
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 4.0
            return renderer
        }else if(overlay.isKind(of: MKTileOverlay.classForCoder())){
            return MKTileOverlayRenderer.init(overlay: self.overlay!)
        }else{
            return MKTileOverlayRenderer.init(overlay: overlay)
        }
    }
    
    
}

