//
//  MostDoExamServices.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 3/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class MostDoExamServices: UIViewController {
    
    func getMostDoExamService(completion: @escaping ([MostDoExamResponse]) -> Void) {
        
        var mostDoArray:[MostDoExamResponse] = []
        let url = "http://localhost:9000/e-xam/api/exam/exam_most"
        let headers: HTTPHeaders = [
            "token" : "1234"
        ]
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let result = try JSONDecoder().decode(MostDoExamResponse.self, from: response.data!)
                    mostDoArray = [result]
                }
                catch {
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
            }
            completion(mostDoArray)
        }
        
    }
    
}
