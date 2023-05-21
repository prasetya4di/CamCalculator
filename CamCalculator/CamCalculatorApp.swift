//
//  CamCalculatorApp.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import RealmSwift
import SwiftUI

@main
struct CamCalculatorApp: SwiftUI.App {
    @StateObject private var homeViewModel: HomeViewModel
    
    init() {
        var realm: Realm!
        
        do {
            realm = try Realm()
        } catch {
            print("Error when init app")
        }
        
        let fileManager = FileManager.default
        let filename = "data.enc"
        // Get the appropriate directory URL for file creation
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to access document directory.")
        }
        let fileURL = documentDirectory.appendingPathComponent(filename)
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            // Create the file
            fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        }
        
        let encryptedFileManager = EncryptedFileManager<ScanDataTable>(
            filePath: fileURL,
            packageName: Bundle.main.bundleIdentifier ?? ""
        )
        
        let settingLocalSource: SettingLocalSource = SettingLocalSourceImpl(realm: realm)
        let scanLocalSource: ScanLocalSource = ScanLocalSourceImpl(realm: realm)
        let scanEncryptedFileSource: ScanLocalSource = ScanEncryptedFileSource(
            fileManager: encryptedFileManager)
        
        let settingRepository: SettingRepository = SettingRepositoryImpl(
            settingLocalSource: settingLocalSource
        )
        let scanDataRepository: ScanDataRepository = ScanDataRepositoryImpl(
            settingLocalSource: settingLocalSource,
            scanLocalSource: scanLocalSource,
            scanEncryptedFile: scanEncryptedFileSource
        )
        
        let saveScanData: SaveScanData = SaveScanDataImpl(
            repository: scanDataRepository)
        let readScanData: ReadScanData = ReadScanDataImpl(
            repository: scanDataRepository)
        let readDatabaseSource: ReadDatabaseSource = ReadDatabaseSourceImpl(
            repository: settingRepository)
        let updateDatabaseSource: UpdateDatabaseSource = UpdateDatabaseSourceImpl(
            repository: settingRepository)
        let calculateOperation: CalculateOperation = CalculateOperationImpl()
        let scanImage: ScanImage = ScanImageImpl()
        
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(
            saveScanData,
            readScanData,
            readDatabaseSource,
            updateDatabaseSource,
            calculateOperation,
            scanImage
        ))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
        }
    }
}
