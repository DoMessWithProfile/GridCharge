//
//  ClusteredMapView.swift
//  GridCharge
//
//  Created by Michael Lam on 1/5/2025.
//

// TODO: selectedStation

import Foundation
import SwiftUI
import MapKit

///
/// DC Chargers only
/// unique annotations for
/// "Operator": "Tesla Supercharge"
///

struct ClusteredMapView: UIViewRepresentable { // UIViewRepresentable -> UIKit wrapper into SwiftUI
//    let stations : [ChargingStation] // StationLoader -> TestView -> ClusteredMapView
    @Binding var selectedStation: ChargingStation? // Add binding for selected station
    let annotations: [StationAnnotation]
    ///
    /// These functions are made to conform with the protocol above: UIViewRepresentable
    /// makeUIView: creates a UIKit view
    /// updateUIView: updates the view when the SwiftUI "@State" changes
    ///
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator // Assigns to a Coordinator object (used to customise annotation views)
        
        // Create either a singular 'station' or a 'cluster'
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(StationAnnotation.self))
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        mapView.addAnnotations(annotations)
        
        // apple map default options like compass, scale/distance and userlocation
        mapView.pointOfInterestFilter = .excludingAll
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = false
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations) // clear old annotations from map
        uiView.addAnnotations(annotations) // create new annotations
        
        // sets the visible map region based on the first annotation, so the map auto-zooms on load
        if !context.coordinator.hasSetInitialRegion, let first = annotations.first {
            let region = MKCoordinateRegion(center: first.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            uiView.setRegion(region, animated: true)
            context.coordinator.hasSetInitialRegion = true // disabled snap-back to first station
        }
    }
    
    // for handling delegation
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ClusteredMapView
        var hasSetInitialRegion = false
                
        init(parent: ClusteredMapView) {
            self.parent = parent
            super.init()
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let cluster = annotation as? MKClusterAnnotation {
                // If it's a cluster, zoom in to see individual stations
                let clusterView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier, for: annotation) as! MKMarkerAnnotationView
                clusterView.markerTintColor = .green
                clusterView.glyphText = "\(cluster.memberAnnotations.count)"
                return clusterView
            }
            
            guard let stationAnnotation = annotation as? StationAnnotation else { return nil }

            let identifier = NSStringFromClass(StationAnnotation.self)
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier, for: annotation) as! MKMarkerAnnotationView

            view.canShowCallout = true
            view.clusteringIdentifier = "charger" // Enables clustering
            
            // decoration
            switch stationAnnotation.chargerType {
            case .ac:
                view.markerTintColor = UIColor(.blue)
                view.glyphImage = UIImage(systemName: "ev.plug.ac.type.1")
            case .dc:
                view.markerTintColor = UIColor(.yellow)
                view.glyphImage = UIImage(systemName: "ev.plug.dc.ccs1")
            case .upcoming:
                view.markerTintColor = UIColor(.gray)
                view.glyphImage = UIImage(systemName: "hourglass")
            case .community:
                view.markerTintColor = UIColor(.purple)
                view.glyphImage = UIImage(systemName: "house")
            case .tesla:
                view.markerTintColor = UIColor(.red)
                view.glyphImage = UIImage(systemName: "bolt")
            }

            return view
        }
        
        // for StationDetailPopup
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation as? StationAnnotation {
                parent.selectedStation = annotation.station
                
                // un-comment if you want add zoom-in animation for a station
//               let region = MKCoordinateRegion(
//                  center: annotation.coordinate,
//                  span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//               )
//                mapView.setRegion(region, animated: true)
                
            } else if let cluster = view.annotation as? MKClusterAnnotation {
                let region = MKCoordinateRegion(
                    center: cluster.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                mapView.setRegion(region, animated: true)
            }
        }
    }
}
