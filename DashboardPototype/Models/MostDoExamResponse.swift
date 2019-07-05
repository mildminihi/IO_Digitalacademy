import Foundation

// MARK: - MostDoExamResponse
struct MostDoExamResponse: Codable {
    let status: StatusMostExam
    let data: DataClassMostExam
}

// MARK: - DataClass
struct DataClassMostExam: Codable {
    let historyMostDo: [HistoryMostDo]
    
    enum CodingKeys: String, CodingKey {
        case historyMostDo = "history_most_do"
    }
}

// MARK: - HistoryMostDo
struct HistoryMostDo: Codable {
    let examID: Int
    let examName: String
    let countAllUserDo: Int?
    
    enum CodingKeys: String, CodingKey {
        case examID = "exam_id"
        case examName = "exam_name"
        case countAllUserDo = "count_all_user_do"
    }
}

// MARK: - Status
struct StatusMostExam: Codable {
    let code, message: String
}
