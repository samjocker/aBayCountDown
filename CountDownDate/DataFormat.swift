//
//  DataFormat.swift
//  CountDownDate
//
//  Created by 江祐鈞 on 2023/12/17.
//

import Foundation
import SwiftData

@Model
class DataFormat: Codable {
    
    enum toDoThings: CodingKey {
        case thingDay
    }
    
    var thingDay: String
    
    init(thingDay: String) {
        self.thingDay = thingDay
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: toDoThings.self)
        self.thingDay = try container.decode(String.self, forKey: .thingDay)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: toDoThings.self)
        try container.encode(thingDay, forKey: .thingDay)
    }
    
}
