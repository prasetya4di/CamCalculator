//
//  HomeViewModel.swift
//  CamCalculator
//
//  Created by Prasetya on 18/05/23.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published private(set) var viewState = HomeViewState.idle()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let intentSubject = PassthroughSubject<HomeViewIntent, Never>()
    
    private let saveScanData: SaveScanData
    private let readScanData: ReadScanData
    private let readDatabaseSource: ReadDatabaseSource
    private let updateDatabaseSource: UpdateDatabaseSource
    
    init (
        _ saveScanData: SaveScanData,
        _ readScanData: ReadScanData,
        _ readDatabaseSource: ReadDatabaseSource,
        _ updateDatabaseSource: UpdateDatabaseSource
    ) {
        self.saveScanData = saveScanData
        self.readScanData = readScanData
        self.readDatabaseSource = readDatabaseSource
        self.updateDatabaseSource = updateDatabaseSource
        
        bind()
    }
    
    func dispatch(_ intent: HomeViewIntent) {
        intentSubject.send(intent)
    }
    
    private func bind() {
        intentSubject
            .receive(on: DispatchQueue.main)
            .flatMap { [unowned self] intent in
                self.process(intent)
            }
            .sink(receiveValue: reduce(_:))
            .store(in: &cancellables)
    }
    
    private func process(_ intent: HomeViewIntent) -> AnyPublisher<HomeViewResult, Never> {
        switch intent {
            case .getAllData:
                return createPublisher { [unowned self] in
                    try self.readDatabaseSource.call()
                }
                .zip (
                    createPublisher {
                    	try self.readScanData.call()
                	}
                    .eraseToAnyPublisher()
                )
                .flatMap { source, scanDatas in
                    return Just(.fetchAllDataResult(.success(source, scanDatas)))
                }
                .catch { err in
                    return Just(.fetchAllDataResult(.error(err)))
                }
                .prepend(.fetchAllDataResult(.loading))
                .eraseToAnyPublisher()
            case .changeDatabaseSource(let databaseSource):
                return createPublisher { [unowned self] in
                    try await self.updateDatabaseSource.call(databaseSource)
                }
                .flatMap {
                    return createPublisher {
                        try self.readScanData.call()
                    }
                    .eraseToAnyPublisher()
                }
                .flatMap { scanDatas in
                    return Just(.changeDatabaseSourceResult(.success(databaseSource, scanDatas)))
                }
                .catch { err in
                    return Just(.changeDatabaseSourceResult(.error(err)))
                }
                .prepend(.changeDatabaseSourceResult(.loading))
                .eraseToAnyPublisher()
        }
    }
    
    private func reduce(_ result: HomeViewResult) {
        
    }
}
