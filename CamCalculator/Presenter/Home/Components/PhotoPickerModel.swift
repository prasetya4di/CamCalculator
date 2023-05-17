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
class PhotoPickerModel: ObservableObject {
    
    enum ImageState: Equatable {
        case empty
        case loading(Progress)
        case success(UIImage)
        case failure(Error)
        
        static func == (lhs: PhotoPickerModel.ImageState, rhs: PhotoPickerModel.ImageState) -> Bool {
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
        let image: UIImage
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = uiImage
                return PhotoScannerImage(image: image)
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
                    case .success(let photo?):
                        self.imageState = .success(photo.image)
                    case .success(nil):
                        self.imageState = .empty
                    case .failure(let error):
                        self.imageState = .failure(error)
                }
            }
        }
    }
}
