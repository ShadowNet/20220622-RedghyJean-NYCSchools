//
//  ViewModel.swift
//  20220622-RedghyJean-NYCSchools
//
//  Created by Redghy on 6/23/22.
//

import Foundation
import UIKit

protocol NetworkDelegate: AnyObject {
    func dataFinished()
    func errorOccured(error: Error)
}

protocol  ViewModelControllerProtocal {
    func createData(urlString: String)
    func getName(_ row: Int) -> String?
    func getCount() -> Int
    var count: Int { get }
    func getID(_ row: Int) -> String?
    func getReadingScore() -> String
    func getMathScore() -> String
    func getWritingScore() -> String
}

class ViewModel: ViewModelControllerProtocal {
   
    var responseData = [ResponseModel]()
    weak var loadData: NetworkDelegate?
    
    private let networkManager: NetworkManagerProtocol?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()){
        self.networkManager = networkManager
    }
    
    func createData(urlString: String = NetworkURL.url) {
        createData(url: urlString)
    }
    
    private func createData(url: String? ) {
        networkManager?.getData(urlString: url){ schoolData in
            if let response = schoolData.0 {
                self.responseData = response.sorted(by: { lhs, rhs in
                    return (lhs.schoolName ?? "") < (rhs.schoolName ?? "")
                })
                DispatchQueue.main.async {
                    self.loadData?.dataFinished()
                }
            } else if let error = schoolData.1 {
                self.loadData?.errorOccured(error: error)
            }
        }
    }
    
    func getName(_ row: Int) -> String? {
        responseData[row].schoolName
    }
    
    func getCount() -> Int {
        responseData.count
    }
    
    var count: Int {
        responseData.count
    }
   
    func getID(_ row: Int) -> String? {
        responseData[row].id
    }
    
    func getReadingScore() -> String {
        responseData.first?.reading ?? "N/A"
    }
    
    var readingScore: String {
        return responseData.first?.reading ?? "N/A"
    }
    
    func getMathScore() -> String {
        responseData.first?.math ?? "N/A"
    }
    
    func getWritingScore() -> String {
        responseData.first?.writing ?? "N/A"
    }
    
}


