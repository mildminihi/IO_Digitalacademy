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
        let url = "http://localhost:9000/e-xam/api/exam/last_exam"
        let headers: HTTPHeaders = [
            "token" : "1234"
        ]
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let result = try JSONDecoder().decode(RecentExamResponse.self, from: response.data!)
                    recentExamArray = [result]
                }
                catch {
                    print("🍉")
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
            }
            completion(recentExamArray)
        }
        
    }
    
}
