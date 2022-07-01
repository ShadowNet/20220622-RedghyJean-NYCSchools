//
//  NetworkManager.swift
//  20220622-RedghyJean-NYCSchools
//
//  Created by Redghy on 6/23/22.
//

import Foundation
/*
 NetworkManagerProtocol uses the getData function which takes in urlString and a
 completionhandler then returns an array of the ResponseModel and an optional NetworkError
*/
protocol NetworkManagerProtocol {
    func getData(urlString: String?, completion: @escaping (([ResponseModel]?, NetworkError?)) -> ())}

//class inherits from the NetworkManagerProtocol and defines the getData function.
class NetworkManager: NetworkManagerProtocol {
    /*
     getData function has a guard statement that unwraps the urlString parameter.
     then we have a guard statement that creates a URL object from the urlString parameter.
     then uses the URLSession shared instance to create a data task with the URL. The data task
     has a completion handler that takes in data, response, and error parameters.
     */
    func getData(urlString: String?, completion: @escaping (([ResponseModel]?, NetworkError?)) -> ()) {
        guard let urlUnwraped = urlString else { return }

        guard let url = URL(string: urlUnwraped) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            //if statement checks for errors. If there is an error, the function prints the error's localized description and calls the completion handler with nil for the schoolList parameter and the error for the NetworkError parameter.
            if let error = error {
                print(error.localizedDescription)
                completion((nil, NetworkError.other(error)))
            } else if let data = data {
                /*
                in my do catch block, the completion handler tries to decode the data into an array of ResponseModel objects. If the decoding is successful, the completion handler is called with the schoolList and nil for the NetworkError parameter. If the decoding is unsuccessful, the completion handler is called with nil for the schoolList parameter and the error for the NetworkError parameter.
                 */
                do {
                    let schoolList = try JSONDecoder().decode([ResponseModel].self, from: data)
                    completion((schoolList, nil))
                } catch {
                    print(error)
                    completion((nil, NetworkError.other(error)))
                }
                                
            }
            //data task is resumed and this starts the task
        }.resume()
        
    }
    
}
