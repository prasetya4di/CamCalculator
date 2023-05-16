//
//  SettingRepository.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

protocol SettingRepository {
    func read() -> Setting
    func update(_ setting: Setting)
}
