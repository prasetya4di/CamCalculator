//
//  ContentView.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScannerView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
