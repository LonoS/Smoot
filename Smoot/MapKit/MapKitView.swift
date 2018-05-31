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

    @IBOutlet weak var departureTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    
     var overlay : MKTileOverlay?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DELEGATES
        mapView.delegate = self
        departureTextField.delegate = self
        destinationTextField.delegate = self
        
        
        //DESIGN TEXT FIELDS
        redesignTextFields()
        
        //SETUP TAP LISTENER
        setupTapListener()
        
        //ADD THE MAP TILE
        mapView.add(setupTileRenderer())
        
        
        //ADD THE NAVIGATION LINE
        let n = Navigator.init()
        let nav = n.navigate(source: CLLocationCoordinate2D.init(latitude: 40.712775, longitude: -74.005973), destination: .init(latitude: 34.052234, longitude: -118.243685), sourceDate: Date.init(), transport: .AUTO, mapView: mapView)
        
        
    }

    
    
    
}

extension MapView_NewRoute: UITextFieldDelegate{
    func redesignTextFields(){
        let border = CALayer()
        let border2 = CALayer()
        
        let width = CGFloat(3.0)
        
        
        
        border.borderColor = UIColor.lightGray.cgColor
        border2.borderColor = UIColor.lightGray.cgColor
        
        
        border.frame = CGRect(x: 0, y: destinationTextField.frame.size.height - width, width: destinationTextField.frame.size.width, height: destinationTextField.frame.size.height)
        border2.frame = CGRect(x: 0, y: departureTextField.frame.size.height - width, width:  departureTextField.frame.size.width, height: departureTextField.frame.size.height)
        
        border.borderWidth = width
        border2.borderWidth = width
        
        destinationTextField.layer.addSublayer(border)
        departureTextField.layer.addSublayer(border2)
        
        
        destinationTextField.layer.masksToBounds = true
        departureTextField.layer.masksToBounds = true
        
        
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.layer.sublayers![0].borderColor = UIColor.gray.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.layer.sublayers![0].borderColor = UIColor.white.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        destinationTextField.resignFirstResponder()
        departureTextField.resignFirstResponder()
        
        return true
    }
    
    @objc func dissmissKeyboard() {
        destinationTextField.resignFirstResponder()
        departureTextField.resignFirstResponder()
        
       
    }

    func setupTapListener(){
        var tapper = UITapGestureRecognizer.init(target: self, action: #selector(dissmissKeyboard))
        self.view.addGestureRecognizer(tapper)
        
    }
    
}
//MARK: MAP-FUNCTIONS
extension MapView_NewRoute{
        
        public func setupTileRenderer() -> MKTileOverlay {
            overlay = MapOverlay()
            overlay!.canReplaceMapContent = true
            return overlay!
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

    

class MapOverlay: MKTileOverlay{
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        
        let template = "https://b.basemaps.cartocdn.com/rastertiles/dark_all/\(path.z)/\(path.x)/\(path.y).png"
        
        return URL(string: template)!
    }
    
    
}




