//
//  StringExtension.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import Foundation

extension String {
    func extractMatchingSubstring(with pattern: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(self.startIndex..<self.endIndex, in: self)
            
            if let match = regex.firstMatch(in: self, options: [], range: range) {
                let matchRange = match.range
                return String(self[Range(matchRange, in: self)!])
            }
        } catch {
            print("Error creating regex: \(error)")
        }
        
        return nil
    }
    
    func matchesRegex(pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: self.utf16.count)
            let matches = regex.matches(in: self, options: [], range: range)
            return !matches.isEmpty
        } catch {
            print("Invalid regex pattern: \(error.localizedDescription)")
            return false
        }
    }
}
