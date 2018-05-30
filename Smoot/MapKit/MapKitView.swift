//
//  MapKitView.swift
//  Smoot
//
//  Created by Julian Kronlachner on 30.05.18.
//  Copyright © 2018 73. All rights reserved.
//

import UIKit
import MapKit


class MapView: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        

        setupTileRenderer()
    }

    func setupTileRenderer() {
        overlay = MapOverlay()
        overlay!.canReplaceMapContent = true
        mapView.add(overlay!, level: .aboveLabels)
    }
    var overlay : MKTileOverlay?
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        if let tileOverlay = overlay as? MKTileOverlay {
//            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
//        } else {
//            return MKOverlayRenderer(overlay: overlay)
//        }
        return MKTileOverlayRenderer.init(overlay: self.overlay!)
    }
    
}

class MapOverlay: MKTileOverlay{
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {

        let template = "https://b.basemaps.cartocdn.com/rastertiles/dark_all/\(path.z)/\(path.x)/\(path.y).png"
        
        return URL(string: template)!
    }
    
    
}

