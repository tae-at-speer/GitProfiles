//
//  NetworkManager.swift
//  GitProfiles
//
//  Created by Mithun Karun Suma on 2022-09-14.
//

import Foundation


struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){ }
    
    //MARK: - Generic API call helper
    func makeNetworkCall<T: Codable>(_ urlPath: String,parms:[String:Any]?,method: String, completion: @escaping((Result<T, Error>)->Void)){
        
        guard let url = URL(string: urlPath) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parms ?? [:], options: [])
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, err in
            if err != nil{
                print("API error: ",err ?? "")
                completion(.failure(err!))
            }
            guard let data = data else {
                return
            }
            do{
                let result = try JSONDecoder().decode( T.self, from: data)
                completion(.success(result))
            } catch let err {
                print("JSON Error: ", err)
                completion(.failure(err))
            }
            
        }.resume()
    }
}
