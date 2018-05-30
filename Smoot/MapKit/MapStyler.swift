//
//  MapStyler.swift
//  Smoot
//
//  Created by Julian Kronlachner on 30.05.18.
//  Copyright © 2018 73. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension MapView{
    
    public func setupTileRenderer() -> MKTileOverlay {
        overlay = MapOverlay()
        overlay!.canReplaceMapContent = true
        return overlay!
    }
    
    
    
    

    
}

class MapOverlay: MKTileOverlay{
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        
        let template = "https://b.basemaps.cartocdn.com/rastertiles/dark_all/\(path.z)/\(path.x)/\(path.y).png"
        
        return URL(string: template)!
    }
    
    
}



