//
//  NetworkError.swift
//  20220622-RedghyJean-NYCSchools
//
//  Created by Redghy on 6/23/22.
//

import Foundation
// Network error with two cases
enum NetworkError: Error {
    
    case badURL
    case other(Error?)

}

