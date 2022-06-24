//
//  NetworkError.swift
//  20220622-RedghyJean-NYCSchools
//
//  Created by Redghy on 6/23/22.
//

import Foundation

enum NetworkError: Error {
    
    case badURL
    case other(Error?)

}

