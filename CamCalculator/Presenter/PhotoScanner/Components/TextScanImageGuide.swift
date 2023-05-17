//
//  TextGuide.swift
//  CamCalculator
//
//  Created by Prasetya on 17/05/23.
//

import SwiftUI

struct TextScanImageGuide: View {
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

struct TextGuide_Previews: PreviewProvider {
    static var previews: some View {
        TextScanImageGuide()
    }
}
