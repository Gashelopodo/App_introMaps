//
//  DireccionesViewController.swift
//  App_introMaps
//
//  Created by cice on 17/2/17.
//  Copyright © 2017 gashe. All rights reserved.
//

import UIKit
import CoreLocation

class DireccionesViewController: UIViewController {
    
    //MARK: - variables locales
    
    var locationsManager = CLLocationManager()
    
    
    //MARK: - outlet
    
    @IBOutlet weak var myLatitudLable: UILabel!
    @IBOutlet weak var myLongitudLable: UILabel!
    @IBOutlet weak var myRumboLable: UILabel!
    @IBOutlet weak var myVelocidadLable: UILabel!
    @IBOutlet weak var myAltitudLable: UILabel!
    @IBOutlet weak var myDireccionLabel: UILabel!
    
    //MARK: - life VC
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationsManager.delegate = self
        locationsManager.desiredAccuracy = kCLLocationAccuracyBest
        locationsManager.requestWhenInUseAuthorization()
        locationsManager.startUpdatingLocation()
        
        
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

}

extension DireccionesViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let userLocation = locations.first{
            
            myLatitudLable.text = "\(userLocation.coordinate.latitude)"
            myLongitudLable.text = "\(userLocation.coordinate.longitude)"
            myRumboLable.text = "\(userLocation.course)"
            myVelocidadLable.text = "\(userLocation.speed)"
            myAltitudLable.text = "\(userLocation.altitude)"
            
            CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) in
                
                if error != nil{
                    print(error?.localizedDescription)
                }else{
                    if let placemarksDes = placemarks?[0]{
                        print(placemarksDes.thoroughfare!)
                    }
                }
                
            })
            
        }
        
        
    }
    
}
