//
//  NetworkManager.swift
//  20220622-RedghyJean-NYCSchools
//
//  Created by Redghy on 6/23/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func getData(urlString: String?, completion: @escaping (([ResponseModel]?, NetworkError?)) -> ())}

class NetworkManager: NetworkManagerProtocol {
    
    func getData(urlString: String?, completion: @escaping (([ResponseModel]?, NetworkError?)) -> ()) {
        guard let urlUnwraped = urlString else { return }

        guard let url = URL(string: urlUnwraped) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion((nil, NetworkError.other(error)))
            } else if let data = data {
                
                do {
                    let schoolList = try JSONDecoder().decode([ResponseModel].self, from: data)
                    completion((schoolList, nil))
                } catch {
                    print(error)
                    completion((nil, NetworkError.other(error)))
                }
                                
            }
            
        }.resume()
        
    }
    
}
