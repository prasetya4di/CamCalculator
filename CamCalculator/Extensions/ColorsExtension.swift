//
//  ColorsExtension.swift
//  CamCalculator
//
//  Created by Prasetya on 20/05/23.
//

import SwiftUI

extension Color {
    static var primaryColor: Color {
    	#if APP_RED_BUILT_IN_CAMERA || APP_RED_CAMERA_ROLL
        return .red
		#elseif APP_GREEN_FILE_SYSTEM || APP_GREEN_CAMERA_ROLL
        return .green
        #else
        return .black
		#endif
    }
}
