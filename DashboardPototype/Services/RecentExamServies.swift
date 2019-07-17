//
//  RecentExamServies.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 4/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//


import Foundation
import UIKit
import Alamofire

class RecentExamServices: UIViewController {
    
    func getRecentExamService(completion: @escaping ([RecentExamResponse]) -> Void) {
        
        var recentExamArray:[RecentExamResponse] = []
        let url = Constants.recentExamServiceUrl
        let headers: HTTPHeaders = [
            "token" : "1234",
            "id" : "1"
        ]
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            print(response)
            switch response.result {
            case .success:
                do {
                    let result = try JSONDecoder().decode(RecentExamResponse.self, from: response.data!)
                    recentExamArray = [result]
                }
                catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
            }
            completion(recentExamArray)
        }
        
    }
    
}
