//
//  Navigator.swift
//  Smoot
//
//  Created by Julian Kronlachner on 30.05.18.
//  Copyright © 2018 73. All rights reserved.
//

import UIKit
import MapKit

class Navigator{
    
    
    public func navigate(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, sourceDate : Date, transport: TransportTypes) -> (TimeInterval, MKRoute)?{
        let directioner = MKDirectionsRequest()
        
        let sourcePlaceMark = MKPlacemark(coordinate: source)
        let destinationPlaceMark = MKPlacemark(coordinate: destination)
        
        let transportType : MKDirectionsTransportType
        
        //Choosing transport Type
        if(transport == TransportTypes.AUTO){
            transportType = .automobile
        }else if(transport == TransportTypes.TRANSIT){
            
            if(AppSettings.isTransitAllowed){
                    transportType = .transit
                }else{
                    transportType = .automobile
                }
        }else if(transport == TransportTypes.WALKING){
            
            transportType = .walking
        }else{
            
            transportType = .automobile
        }
        
        
        directioner.source = MKMapItem(placemark: sourcePlaceMark)
        directioner.destination = MKMapItem(placemark: destinationPlaceMark)
        directioner.departureDate = sourceDate
        directioner.transportType = transportType
        
        
        var route : MKRoute? = nil
        
        let directions = MKDirections(request: directioner)
        directions.calculate { (response, error) in
            
            guard let directionResponse = response else{
                
                if let error = error{
                    print("There was a error while getting directions: \n ------------------------- \n \(error.localizedDescription)")
                }
                return
            }
            
            
            let routes = directionResponse.routes[0]
            route = routes
            
        }
        
        
        if let route = route{
            return (route.expectedTravelTime, route)
        }else{
            return nil
        }
        
        
        
    }
        
        
        
        
    }
    
    
    
    
    

