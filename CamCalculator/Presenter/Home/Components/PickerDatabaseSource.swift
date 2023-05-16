//
//  PickerDatabaseSource.swift
//  CamCalculator
//
//  Created by Prasetya on 16/05/23.
//

import SwiftUI

struct PickerDatabaseSource: View {
    @Binding var databaseSource: DatabaseSource
    
    var body: some View {
        Picker("Select Source", selection: $databaseSource) {
            Text("Database").tag(DatabaseSource.realmDb)
            Text("File").tag(DatabaseSource.file)
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

struct PickerDatabaseSource_Previews: PreviewProvider {
    static var previews: some View {
        PickerDatabaseSource(
            databaseSource: .constant(.realmDb)
        )
    }
}
