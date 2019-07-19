//
//  HistoryServices.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 9/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class HistoryServices: UIViewController {
    
    func getHistoryService(completion: @escaping ([HistoryResponse]) -> Void) {
        
        var historyArray:[HistoryResponse] = []
        let url = Constants.historyServiceUrl
        let headers: HTTPHeaders = [
            "accessToken" : "Bearer \(UserDefaults.standard.string(forKey: "access_token").unsafelyUnwrapped)"
        ]
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let result = try JSONDecoder().decode(HistoryResponse.self, from: response.data!)
                    historyArray = [result]
                    print(result)
                }
                catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
            }
            completion(historyArray)
        }
        
    }
    
}
