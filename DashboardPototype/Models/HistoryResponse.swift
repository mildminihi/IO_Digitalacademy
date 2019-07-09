//
//  HistoryResponse.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 9/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation

// MARK: - HistoryResponse
struct HistoryResponse: Codable {
    let status: HistoryStatus
    let data: HistoryDataClass
}

// MARK: - DataClass
struct HistoryDataClass: Codable {
    let allHistory: [AllHistory]
    
    enum CodingKeys: String, CodingKey {
        case allHistory = "all_history"
    }
}

// MARK: - AllHistory
struct AllHistory: Codable {
    let examID: Int
    let examName: String
    let pointUser, pointExam, timestamp: Int
    
    enum CodingKeys: String, CodingKey {
        case examID = "exam_id"
        case examName = "exam_name"
        case pointUser = "point_user"
        case pointExam = "point_exam"
        case timestamp
    }
}

// MARK: - Status
struct HistoryStatus: Codable {
    let code, message: String
}
