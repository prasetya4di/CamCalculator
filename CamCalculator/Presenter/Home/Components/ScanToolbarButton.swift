//
//  ScanToolbarButton.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI
import PhotosUI

struct ScanToolbarButton: View {
    @ObservedObject var viewModel: PhotoScannerModel
    
    var body: some View {
        #if false
        ShowCameraScannerButton()
        #else
        ShowPhotoScannerButton(
        	viewModel: viewModel
        )
        #endif
    }
}

struct ScanToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanToolbarButton(
        	viewModel: PhotoScannerModel()
        )
    }
}
