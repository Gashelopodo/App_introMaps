//
//  PrimerMapaViewController.swift
//  App_introMaps
//
//  Created by cice on 17/2/17.
//  Copyright © 2017 gashe. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

enum MapaType : Int{
    case standard = 0
    case hibrido = 1
    case satelite = 2
}

class PrimerMapaViewController: UIViewController {
    
    
    //MARK: - variables locales
    var locationManager = CLLocationManager()
    
    
    
    //MARK: - outlet
    
    @IBOutlet weak var mySegmentMapa: UISegmentedControl!
    @IBOutlet weak var myMapa: MKMapView!
    @IBOutlet weak var myDescriptionMapa: UILabel!
    
    
    //MARK: - action
    
    @IBAction func muestraMapa(_ sender: AnyObject) {
        
        //coordenadas
        let latitud = 40.389925
        let longitud = -3.760911
        
        //zoom
        let latDelta = 0.001
        let longDelta = 0.001
        
        let location = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region = MKCoordinateRegion(center: location, span: span)
        
        myMapa.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Estamos en clase de iOS"
        annotation.subtitle = "Aquí currando"
        myMapa.addAnnotation(annotation)
        
    }
    
    @IBAction func muestraNuevoMapa(_ sender: AnyObject) {
        
        let mapa = MapaType(rawValue: mySegmentMapa.selectedSegmentIndex)
        switch mapa! {
        case .standard:
            myMapa.mapType = MKMapType.standard
            break
        case .hibrido:
            myMapa.mapType = MKMapType.hybrid
        case .satelite:
            myMapa.mapType = MKMapType.satellite
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // DELEGADO DEL MAPA    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Creamos un gesto de reconocimiento
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(self.muestraGR(_:)))
        longPressGR.minimumPressDuration = 2
        myMapa.addGestureRecognizer(longPressGR)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - utils
    
    func muestraGR(_ gesture: UIGestureRecognizer){
        
        if gesture.state == UIGestureRecognizerState.began{
        
            let puntoTocado = gesture.location(in: myMapa)
            let nuevaCoordenada = myMapa.convert(puntoTocado, toCoordinateFrom: myMapa)
        
            let annotation = MKPointAnnotation()
            annotation.coordinate = nuevaCoordenada
            annotation.title = "Nueva etiqueta en el mapa"
            annotation.subtitle = "Aqui seguimos"
            myMapa.addAnnotation(annotation)
        
        }
        
    }
    


}


extension PrimerMapaViewController : CLLocationManagerDelegate{

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.first!
        
        let latitud = userLocation.coordinate.latitude
        let longitud = userLocation.coordinate.longitude
        let latDelta = 0.001
        let longDelta = 0.001
        let location = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region = MKCoordinateRegion(center: location, span: span)
        myMapa.setRegion(region, animated: true)
        myDescriptionMapa.text = "\(userLocation)"
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = userLocation.coordinate
        annotation.title = "Nueva etiqueta"
        annotation.subtitle = "Aquí seguimos en iOS"
        myMapa.addAnnotation(annotation)
        
        
        
    }

}
























