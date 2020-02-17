//
//  MapsViewController.swift
//  Meu primeiro app
//
//  Created by Jonathan on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
    @IBOutlet weak var viewMap: MKMapView!
    
    // faz o map dar zoom
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
            latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        viewMap.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
         viewMap.delegate = self
        //chamando o func para zoom do map
        centerMapOnLocation(location: initialLocation)
        // exibie a class Atwork no mapa
        let artwork = Artwork(title: "King David Kalakaua",
                              locationName: "Waikiki Gateway Park",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        viewMap.addAnnotation(artwork)
        
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//faz retornar viewMap para todas as anotações do map
extension MapsViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
