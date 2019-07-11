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
    let countAllDo, examTotalScore, countQuestion: Int
    
    enum CodingKeys: String, CodingKey {
        case examID = "exam_id"
        case examName = "exam_name"
        case countAllDo = "count_all_do"
        case examTotalScore = "exam_total_score"
        case countQuestion = "count_question"
    }
}

// MARK: - Status
struct StatusMostExam: Codable {
    let code, message: String
}
