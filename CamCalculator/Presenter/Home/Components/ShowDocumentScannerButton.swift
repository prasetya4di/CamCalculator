//
//  ShowDocumentScannerButton.swift
//  CamCalculator
//
//  Created by Prasetya on 18/05/23.
//

import SwiftUI

struct ShowDocumentScannerButton: View {
    @State private var showFilePicker = false
    @Binding var scannedText: String
    let scanPhoto: (UIImage) -> Void
    
    var body: some View {
        Button {
            showFilePicker.toggle()
        } label: {
            AddInputText()
        }
        .fileImporter(
            isPresented: $showFilePicker,
            allowedContentTypes: [.image],
            allowsMultipleSelection: false) { result in
                do {
                    let fileURL = try result.get().first
                    if let fileURL, fileURL.startAccessingSecurityScopedResource() {
                        let data = try! Data(contentsOf: fileURL)
                        let photo = UIImage.init(data: data)
                        if let photo {
                            scanPhoto(photo)
                        }
                        fileURL.stopAccessingSecurityScopedResource()
                    }
                }
                catch {
                    print("error reading file \(error.localizedDescription)")
                }
            }
    }
}

struct ShowDocumentScannerButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowDocumentScannerButton(
            scannedText: .constant("")) { _ in }
    }
}
