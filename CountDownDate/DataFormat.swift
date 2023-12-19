//
//  DataFormat.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/17.
//

import Foundation
import SwiftData

@Model
class DataFormat {
    
    var thingDate: String
    var thingName: String
    var thingState: Bool
    
    init(thingDate: String, thingName: String, thingState: Bool) {
        self.thingDate = thingDate
        self.thingName = thingName
        self.thingState = thingState
    }
    
}
