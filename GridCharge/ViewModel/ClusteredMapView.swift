//
//  ClusteredMapView.swift
//  GridCharge
//
//  Created by Michael Lam on 1/5/2025.
//

import Foundation
import SwiftUI
import MapKit

struct ClusteredMapView: UIViewRepresentable { // UIViewRepresentable -> UIKit wrapper into SwiftUI
    let stations : [ChargingStation] // StationLoader -> TestView -> ClusteredMapView
    @Binding var selectedStation: ChargingStation? // Add binding for selected station
    
    ///
    /// These functions are made to conform with the protocol above: UIViewRepresentable
    /// makeUIView: creates a UIKit view
    /// updateUIView: updates the view when the SwiftUI "@State" changes
    ///
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator // Assigns to a Coordinator object (used to customise annotation views)
        
        // Create either a singular 'station' or a 'cluster'
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Station")
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Cluster")
        
        // apple map default options like compass, scale/distance and userlocation
        mapView.pointOfInterestFilter = .excludingAll
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = false
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations) // clear old annotations from map
        
        // converts each ChargingStation into a StationAnnotation
        let annotations = stations.map { StationAnnotation(station: $0) }
        uiView.addAnnotations(annotations) // create new annotations
        
        // sets the visible map region based on the first annotation, so the map auto-zooms on load
        if let first = annotations.first {
            let region = MKCoordinateRegion(center: first.coordinate, span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0))
            uiView.setRegion(region, animated: true)
        }
    }
    
    // for handling delegation
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: ClusteredMapView
        
        init(parent: ClusteredMapView) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let stationAnnotation = view.annotation as? StationAnnotation {
                parent.selectedStation = stationAnnotation.station
            } else if let clusterAnnotation = view.annotation as? MKClusterAnnotation {
                // If it's a cluster, zoom in to see individual stations
                let region = MKCoordinateRegion(
                    center: clusterAnnotation.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                mapView.setRegion(region, animated: true)
            }
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // Cluster
            if let cluster = annotation as? MKClusterAnnotation {
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: "Cluster", for: annotation) as! MKMarkerAnnotationView
                // decoration
                view.markerTintColor = .blue
                view.glyphText = "\(cluster.memberAnnotations.count)"
                view.titleVisibility = .visible
                return view 
            }
            // Station
            guard let annotation = annotation as? StationAnnotation else { return nil } // check if Station just in case

            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "Station", for: annotation) as! MKMarkerAnnotationView
            // decoration
            view.markerTintColor = .red
            view.glyphImage = UIImage(systemName: "bolt.car")
            view.clusteringIdentifier = "stationCluster"
            return view
        }
    }
}
