//
//  HomeViewState.swift
//  CamCalculator
//
//  Created by Prasetya on 18/05/23.
//

import Foundation

struct HomeViewState: Equatable {
    var isLoading = false
    var databaseSource: DatabaseSource = .realmDb
    var scanDatas: [ScanData] = []
    var error: Error? = nil
    
    static func idle() -> HomeViewState {
        HomeViewState()
    }
    
    static func == (lhs: HomeViewState, rhs: HomeViewState) -> Bool {
        return lhs.isLoading == rhs.isLoading
        && lhs.databaseSource == rhs.databaseSource
        && lhs.scanDatas == rhs.scanDatas
        && lhs.error?.localizedDescription == rhs.error?.localizedDescription
    }
}
