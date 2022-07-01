//
//  ResponseModel.swift
//  20220622-RedghyJean-NYCSchools
//
//  Created by Redghy on 6/23/22.
//

import Foundation

struct ResponseModel: Codable {

    let id: String?
    let schoolName: String?
    let reading: String?
    let math: String?
    let writing: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
        case reading = "sat_critical_reading_avg_score"
        case math = "sat_math_avg_score"
        case writing = "sat_writing_avg_score" 
    }
}


