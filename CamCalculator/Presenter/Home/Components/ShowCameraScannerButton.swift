//
//  ShowCameraScannerButton.swift
//  CamCalculator
//
//  Created by Prasetya on 17/05/23.
//

import SwiftUI

struct ShowCameraScannerButton: View {
    @State private var showCameraScanner = false
    @Binding var scannedText: String
    
    var body: some View {
        Button {
            showCameraScanner = true
        } label: {
            AddInputText()
        }
        .navigationDestination(isPresented: $showCameraScanner) {
            CameraScannerView(
            	scannedText: $scannedText
            )
        }
    }
}

struct ShowCameraScannerButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowCameraScannerButton(
            scannedText: .constant("")
        )
    }
}
