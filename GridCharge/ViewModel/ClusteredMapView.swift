//
//  ClusteredMapView.swift
//  GridCharge
//
//  Created by Michael Lam on 1/5/2025.
//

import Foundation
import SwiftUI
import MapKit

struct ClusteredMapView: UIViewRepresentable {
    let stations: [ChargingStation]

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Station")
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Cluster")
        mapView.pointOfInterestFilter = .excludingAll
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsUserLocation = false
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)

        let annotations = stations.map { StationAnnotation(station: $0) }
        uiView.addAnnotations(annotations)

        if let first = annotations.first {
            let region = MKCoordinateRegion(center: first.coordinate, span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0))
            uiView.setRegion(region, animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let cluster = annotation as? MKClusterAnnotation {
                let view = mapView.dequeueReusableAnnotationView(withIdentifier: "Cluster", for: annotation) as! MKMarkerAnnotationView
                view.markerTintColor = .blue
                view.glyphText = "\(cluster.memberAnnotations.count)"
                view.titleVisibility = .visible
                return view
            }

            guard let annotation = annotation as? StationAnnotation else { return nil }

            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "Station", for: annotation) as! MKMarkerAnnotationView
            view.markerTintColor = .red
            view.glyphImage = UIImage(systemName: "bolt.car")
            view.clusteringIdentifier = "stationCluster"
            return view
        }
    }
}
