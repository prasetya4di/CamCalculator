//
//  ScanToolbarButton.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct ScanToolbarButton: View {
    var body: some View {
        Button {
            //Todo add navigate to camera or gallery
        } label: {
         	Text("Scan")
        }
    }
}

struct ScanToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanToolbarButton()
    }
}
