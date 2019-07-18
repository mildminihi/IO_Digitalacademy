// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let historyResponse = try? newJSONDecoder().decode(HistoryResponse.self, from: jsonData)

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
    let examTotalScore, pointExam: Int
    let timestamp: String
    
    enum CodingKeys: String, CodingKey {
        case examID = "exam_id"
        case examName = "exam_name"
        case examTotalScore = "exam_total_score"
        case pointExam = "point_exam"
        case timestamp
    }
}

// MARK: - Status
struct HistoryStatus: Codable {
    let code: Int
    let message: String
}
