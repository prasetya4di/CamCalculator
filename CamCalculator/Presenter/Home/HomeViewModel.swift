//
//  HomeViewModel.swift
//  CamCalculator
//
//  Created by Prasetya on 18/05/23.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    private var viewStateSubject = CurrentValueSubject<HomeViewState, Never>(.idle())
    
    @Published private(set) var viewState: HomeViewState = .idle()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let intentSubject = PassthroughSubject<HomeViewIntent, Never>()
    
    private let saveScanData: SaveScanData
    private let readScanData: ReadScanData
    private let readDatabaseSource: ReadDatabaseSource
    private let updateDatabaseSource: UpdateDatabaseSource
    private let calculateOperation: CalculateOperation
    
    init (
        _ saveScanData: SaveScanData,
        _ readScanData: ReadScanData,
        _ readDatabaseSource: ReadDatabaseSource,
        _ updateDatabaseSource: UpdateDatabaseSource,
        _ calculateOperation: CalculateOperation
    ) {
        self.saveScanData = saveScanData
        self.readScanData = readScanData
        self.readDatabaseSource = readDatabaseSource
        self.updateDatabaseSource = updateDatabaseSource
        self.calculateOperation = calculateOperation
        
        bind()
    }
    
    func dispatch(_ intent: HomeViewIntent) {
        intentSubject.send(intent)
    }
    
    private func bind() {
        viewStateSubject
            .sink(receiveValue: { [unowned self] newState in
                self.viewState = newState
            })
            .store(in: &cancellables)
        
        intentSubject
            .receive(on: DispatchQueue.main)
            .flatMap { [unowned self] intent in
                self.process(intent)
            }
            .combineLatest(viewStateSubject)
            .map { [unowned self] intentResult, currentState in
                self.reduce(currentState, intentResult)
            }
            .sink { [unowned self] newState in
                self.viewStateSubject.send(newState)
            }
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
                    try self.updateDatabaseSource.call(databaseSource)
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
            case .insertScan(let input):
                return createPublisher { [unowned self] in
                    self.calculateOperation.call(input: input)
                }
                .flatMap { result in
                    createPublisher { [unowned self] in
                        try self.saveScanData.call(input, result)
                    }
                    .eraseToAnyPublisher()
                }
                .flatMap { scanData in
                    return Just(.insertScanDataResult(.success(scanData)))
                }
                .catch { err in
                    return Just(.insertScanDataResult(.error(err)))
                }
                .prepend(.insertScanDataResult(.loading))
                .eraseToAnyPublisher()
        }
    }
    
    private func reduce(_ prevState: HomeViewState, _ result: HomeViewResult) -> HomeViewState {
        var state = prevState
        switch result {
            case .fetchAllDataResult(let status):
                switch status {
                    case .loading:
                        state.isLoading = true
                        break
                    case .success(let source, let scanDatas):
                        state.isLoading = false
                        state.databaseSource = source
                        state.scanDatas = scanDatas
                        break
                    case .error(let error):
                        state.isLoading = false
                        state.error = error
                        break
                }
            case .changeDatabaseSourceResult(let status):
                switch status {
                    case .loading:
                        state.isLoading = true
                        break
                    case .success(let source, let scanDatas):
                        state.isLoading = false
                        state.databaseSource = source
                        state.scanDatas = scanDatas
                        break
                    case .error(let error):
                        state.isLoading = false
                        state.error = error
                        print("Error when update database source")
                        print(error)
                        print(error.localizedDescription)
                        break
                }
            case .insertScanDataResult(let status):
                switch status {
                    case .loading:
                        state.isLoading = true
                        break
                    case .success(let scanData):
                        state.isLoading = false
                        state.scanDatas.append(scanData)
                        break
                    case .error(let error):
                        state.isLoading = false
                        state.error = error
                        break
                }
            case .nothing:
                break
        }
        
        return state
    }
}
