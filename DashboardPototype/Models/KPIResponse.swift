//
//  KPIResponse.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 17/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation

// MARK: - KPIResponse
struct KPIResponse: Codable {
    let status: KPIStatus
    let data: KPIDataClass
}

// MARK: - DataClass
struct KPIDataClass: Codable {
    let finalRatingScore: Int
    
    enum CodingKeys: String, CodingKey {
        case finalRatingScore = "final_rating_score"
    }
}

// MARK: - Status
struct KPIStatus: Codable {
    let code: Int
    let message: String
}
