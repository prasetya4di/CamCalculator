//
//  ShowCameraScannerButton.swift
//  CamCalculator
//
//  Created by Prasetya on 17/05/23.
//

import SwiftUI

struct ShowCameraScannerButton: View {
    @State private var showCameraScanner = false
    
    var body: some View {
        Button {
            showCameraScanner = true
        } label: {
            Text("Add Input")
        }
        .navigationDestination(isPresented: $showCameraScanner) {
            CameraScannerView()
        }
    }
}

struct ShowCameraScannerButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowCameraScannerButton()
    }
}
