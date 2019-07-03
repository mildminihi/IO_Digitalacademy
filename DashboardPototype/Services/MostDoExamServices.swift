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
    
    func getMostDoExamService(completion: @escaping (MostDoExamResponse) -> Void) {
        
        var mostDoArray:MostDoExamResponse?
        let url = "http://localhost:1150/api/exam/exam_most"
        AF.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    let result = try JSONDecoder().decode(MostDoExamResponse.self, from: response.data!)
                    print("🇧🇮🇧🇮🇧🇮🇧🇮\(result.data)🇧🇮🇧🇮🇧🇮🇧🇮")
                    mostDoArray = result
                    
                }
                catch {
                }
            case .failure(let error):
                print("Network error: \(error.localizedDescription)")
                
            }
            completion(mostDoArray!)
        }
        
    }
    
}
