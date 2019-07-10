//
//  RecentExamResponse.swift
//  DashboardPototype
//
//  Created by Supanat Wanroj on 4/7/2562 BE.
//  Copyright © 2562 Supanat Wanroj. All rights reserved.
//

import Foundation


import Foundation

// MARK: - RecentExamResponse
struct RecentExamResponse: Codable {
    let status: StatusRecentExam
    let data: DataClassRecentExam
}

// MARK: - DataClass
struct DataClassRecentExam: Codable {
    let countDoExam, countExam: Int
    let lastDo: [LastDo]
    
    enum CodingKeys: String, CodingKey {
        case countDoExam = "count_do_exam"
        case countExam = "count_exam"
        case lastDo = "last_do"
    }
}

// MARK: - LastDo
struct LastDo: Codable {
    let examID: Int
    let examName: String
    let examTotalScore, countQuestion: Int
    let timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case examID = "exam_id"
        case examName = "exam_name"
        case examTotalScore = "exam_total_score"
        case countQuestion = "count_question"
        case timestamp
    }
}

// MARK: - Status
struct StatusRecentExam: Codable {
    let code, message: String
}
