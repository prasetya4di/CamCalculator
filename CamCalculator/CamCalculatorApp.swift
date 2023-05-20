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
        var realm2: Realm!
        
        do {
            realm = try Realm()
            realm2 = try Realm()
        } catch {
            print("Error when init app")
        }
        
        let fileManager = FileManager.default
        let currentPathURL = URL(fileURLWithPath: fileManager.currentDirectoryPath)
        let filename = "data.enc"
        let fileURL = currentPathURL.appendingPathComponent(filename)
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            // Create the file
            fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
        }
        
        let encryptedFileManager = EncryptedFileManager<ScanDataTable>(
            filePath: fileURL,
            packageName: "com.pras.app"
        )
        
        let settingLocalSource: SettingLocalSource = SettingLocalSourceImpl(realm: realm)
        let scanLocalSource: ScanLocalSource = ScanLocalSourceImpl(realm: realm)
        let scanEncryptedFileSource: ScanLocalSource = ScanLocalSourceImpl(realm: realm2)
        
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
        
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(
            saveScanData,
            readScanData,
            readDatabaseSource,
            updateDatabaseSource,
            calculateOperation
        ))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
        }
    }
}
