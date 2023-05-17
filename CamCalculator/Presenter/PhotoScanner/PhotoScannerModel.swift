//
//  PhotoScannerModel.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI
import PhotosUI
import CoreTransferable

@MainActor
class PhotoScannerModel: ObservableObject {
    
    // MARK: - Photo Scanner Image
    
    enum ImageState: Equatable {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
        
        static func == (lhs: PhotoScannerModel.ImageState, rhs: PhotoScannerModel.ImageState) -> Bool {
            switch(lhs, rhs) {
                case (.empty, .empty),
                    (.loading, .loading),
                    (.success, .success),
                    (.failure, .failure):
                    return true
                default:
                    return false
            }
        }
    }
    
    enum TransferError: Error {
        case importFailed
    }
    
    struct PhotoScannerImage: Transferable {
        let image: Image
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
            #if canImport(AppKit)
                guard let nsImage = NSImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(nsImage: nsImage)
                return PhotoScannerImage(image: image)
            #elseif canImport(UIKit)
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return PhotoScannerImage(image: image)
			#else
                throw TransferError.importFailed
			#endif
            }
        }
    }
    
    @Published private(set) var imageState: ImageState = .empty
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: PhotoScannerImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                    case .success(let profileImage?):
                        self.imageState = .success(profileImage.image)
                    case .success(nil):
                        self.imageState = .empty
                    case .failure(let error):
                        self.imageState = .failure(error)
                }
            }
        }
    }
}
