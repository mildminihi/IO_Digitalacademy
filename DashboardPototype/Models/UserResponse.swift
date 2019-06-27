// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userResponse = try? newJSONDecoder().decode(UserResponse.self, from: jsonData)

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let status: Status
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int
    let lastNameTH, firstNameTH, address, position: String
    let profilePhotoPath, birthDate, registerDate, mobileNo: String
    let emailNotificationFlag, lastNameEN, firstNameEN, nationality: String
    let religion, email: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastNameTH = "lastName_TH"
        case firstNameTH = "firstName_TH"
        case address, position, profilePhotoPath
        case birthDate = "birth_date"
        case registerDate, mobileNo
        case emailNotificationFlag = "email_notification_flag"
        case lastNameEN = "lastName_EN"
        case firstNameEN = "firstName_EN"
        case nationality, religion, email
        case userID = "userId"
    }
}

// MARK: - Status
struct Status: Codable {
    let code, message: String
}
