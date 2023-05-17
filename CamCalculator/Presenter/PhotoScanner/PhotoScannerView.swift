//
//  PhotoScannerView.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import AlertToast
import SwiftUI
import PhotosUI

struct PhotoScannerView: View {
    @ObservedObject var viewModel = PhotoScannerModel()
    @State private var showInvalidTextToast = false
    @State private var scannedText = ""
    
    var body: some View {
        ZStack {
            if case let .success(image) = viewModel.imageState {
                image
                    .resizable()
                    .scaledToFill()
            }
            
            TextScanImageGuide()
        }
        .toast(isPresenting: $showInvalidTextToast) {
            AlertToast(
                displayMode: .banner(.pop),
                type: .regular,
                title: "Invalid Math Equations")
        }
    }
}

struct ProfileImage: View {
    let imageState: PhotoScannerModel.ImageState
    
    var body: some View {
        switch imageState {
            case .success(let image):
                image.resizable()
            case .loading:
                ProgressView()
            case .empty:
                Image(systemName: "person.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            case .failure:
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
        }
    }
}

struct CircularProfileImage: View {
    let imageState: PhotoScannerModel.ImageState
    
    var body: some View {
        ProfileImage(imageState: imageState)
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .background {
                Circle().fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}

struct PhotoScannerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoScannerView()
    }
}
