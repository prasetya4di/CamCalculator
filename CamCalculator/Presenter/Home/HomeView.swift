//
//  HomeView.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                ScanResults(scanDatas: [])
            }
        }
        .navigationTitle("Cam Calculator")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                ScanToolbarButton()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
