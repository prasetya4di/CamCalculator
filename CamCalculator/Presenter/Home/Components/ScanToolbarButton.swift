//
//  ScanToolbarButton.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct ScanToolbarButton: View {
    var body: some View {
        NavigationLink {
            ScannerView()
        } label: {
            Text("Add Input")
        }

    }
}

struct ScanToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanToolbarButton()
    }
}
