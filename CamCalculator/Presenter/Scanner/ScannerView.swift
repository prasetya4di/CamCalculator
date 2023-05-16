//
//  ScannerVIew.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct ScannerView: View {
    @State private var scannedText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Scanned Text: \(scannedText)")
                .padding()
            
            CameraView { result in
                DispatchQueue.main.async {
                    scannedText = result
                }
            }
        }
    }
}

struct ScannerVIew_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
