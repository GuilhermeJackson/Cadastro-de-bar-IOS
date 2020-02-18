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
    let regionRadius: CLLocationDistance = 2000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
            latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        viewMap.setRegion(coordinateRegion, animated: true)
    }
    
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        viewMap.showsUserLocation = true
        
        
    
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
         viewMap.delegate = self
        //chamando o func para zoom do map
        centerMapOnLocation(location: locationManager.location ?? initialLocation)
        // exibie a class Atwork no mapa
        let artwork = Artwork(title: "King David Kalakaua",
                             locationName: "Waikiki Gateway Park",
                             discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        viewMap.addAnnotation(artwork)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    // array dos objetos a ser achado no map
    //var artworks: [Artwork] = []
    
    /*func loadInitialData() {
        // 1    -   lê o arquivo PublicArt.json em um objeto Data.
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            // 2 - usa JSONSerialization para obter um objeto JSON.
            let json = try? JSONSerialization.jsonObject(with: data),
            // 3 - erifica se o objeto JSON é um dicionário com chaves String de qualquer valor.
            let dictionary = json as? [String: Any],
            // 4 - pega  apenas no objeto JSON cuja chave é "dados".
            let works = dictionary["data"] as? [[Any]]
            else { return }
        // 5 - adicionar à classe Artwork e anexa o validWorks resultante à matriz de obras de arte.
        let validWorks = works.flatMap { Artwork(json: $0) }
        artworks.append(contentsOf: validWorks)
    }*/
    
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



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
