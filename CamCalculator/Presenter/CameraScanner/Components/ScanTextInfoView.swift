//
//  ScanTextInfoView.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct ScanTextInfoView: View {
    var body: some View {
        Text("Tap on text to select")
            .padding()
            .foregroundColor(.white)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(.black.opacity(0.5))
            }
    }
}

struct ScanTextInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ScanTextInfoView()
    }
}
