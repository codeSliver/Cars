//
//  MapViewController.swift
//  Cars
//
//  Created by Arslan Faisal on 29/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit
import MapKit

/// Shows Mapview
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var viewModel: MapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
}
//MARK:- View Model setup
extension MapViewController {
    
    /// Binds view  model closures
    private func bindViewModel() {
        viewModel?.cars.bind({ [weak self] _ in
            self?.addAndShowMapAnnotations()
        })
    }
}
//MARK:- MKMapViewDelegate and map helper methods
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CarAnnotation else { return nil }
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: MapIdentifiers.carMapdentifier)
            as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = viewForAnnotation(annotation)
        }
        return view
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.viewWithTag(MapIdentifiers.carMapViewTag)?.isHidden = false
        if let coordinate = view.annotation?.coordinate {
            mapView.setCenter(coordinate, animated: true)
        }
        
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
         view.viewWithTag(MapIdentifiers.carMapViewTag)?.isHidden = true
    }
}
//MARK:- MKMapView helper methods
extension MapViewController {
    
    /// Creates and returns a *MKPinAnnotationView* for displaying when car pin is tapped
    /// - Parameter annotation: *carAnnotation* user tapped
    func viewForAnnotation(_ annotation: CarAnnotation) -> MKPinAnnotationView {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: MapIdentifiers.carMapdentifier)
        view.annotation = annotation
        view.addSubview(carViewForAnnotation(annotation))
        view.image = #imageLiteral(resourceName: "carIcon")
        view.canShowCallout = false
        return view
    }
    
    /// Creates and returns a custom view for displaying car info when car pin is tapped
    /// - Parameter annotation: *carAnnotation* user tapped
    private func carViewForAnnotation(_ annotation: CarAnnotation) -> CarView {
        let carView = CarView(frame: CGRect(x: -((MapIdentifiers.mapAnnotationViewWidth/2) - 7), y: -MapIdentifiers.mapAnnotationViewHeight, width: MapIdentifiers.mapAnnotationViewWidth, height: MapIdentifiers.mapAnnotationViewHeight))
        carView.setUpView(annotation.car)
        carView.tag = MapIdentifiers.carMapViewTag
        carView.isHidden = true
        return carView
    }
    
    /// Adds and show all the cars on the map
    private func addAndShowMapAnnotations() {
        guard let annotations = viewModel?.mapAnnotations() else { return }
        DispatchQueue.main.async { [weak self] in
            guard let unwrappedSelf = self else { return }
            unwrappedSelf.mapView.removeAnnotations(unwrappedSelf.mapView.annotations)
            unwrappedSelf.mapView.addAnnotations(annotations)
            unwrappedSelf.mapView.showAnnotations(annotations, animated: true)
        }

    }
}
