//
//  CountryMapView.swift
//  CountriesApp-SwiftUI
//
//  Created by user241339 on 9/28/23.
//

import SwiftUI
import MapKit

struct CountryMapView: UIViewRepresentable {
    var latitude: Double
    var longitude: Double

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        uiView.addAnnotation(annotation)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: CountryMapView

        init(_ parent: CountryMapView) {
            self.parent = parent
        }
    }
}

struct CountryMapView_Previews: PreviewProvider {
    static var previews: some View {
        CountryMapView(latitude: -15.79, longitude: -47.88)
    }
}
