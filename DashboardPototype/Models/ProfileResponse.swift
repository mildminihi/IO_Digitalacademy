// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let profileResponse = try? newJSONDecoder().decode(ProfileResponse.self, from: jsonData)

import Foundation


// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    //    let profiles: DataClass
    let status: ProfileStatus
    let data: ProfileDataClass
}

// MARK: - DataClass
struct ProfileDataClass: Codable {
    let id: Int
    let lastNameTH, firstNameTH, address, position: String
    let profilePhotoPath, birthDate, registerDate, mobileNo: String
    let emailNotificationFlag, lastNameEN, firstNameEN, nationality: String
    let religion, email: String
    let userID: Int
    
    var dictionary: [String: Any] {
        return ["id": id,
                "lastName_TH": lastNameTH,
                "firstName_TH": firstNameTH,
                "address": address,
                "position": position,
                "profilePhotoPath": profilePhotoPath,
                "birth_date": birthDate,
                "registerDate": registerDate,
                "mobileNo": mobileNo,
                "email_notification_flag": emailNotificationFlag,
                "lastName_EN": lastNameEN,
                "firstName_EN": firstNameEN,
                "nationality": nationality,
                "religion": religion,
                "email": email,
                "userId": userID]
    }
    
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    
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

//// MARK: - Status
struct ProfileStatus: Codable {
    let code, message: String
}
