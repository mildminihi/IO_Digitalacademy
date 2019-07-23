import Foundation
import Alamofire

class TimeCounterServices {
    
    static let timeCounter = TimeCounterServices()
    
    let url = URL(string: Constants.refreshTokenServiceUrl)!
    var authLoginResponseArray: [AuthLoginResponse] = []
    var successCode: Int = 1000
    var wrongDataCode: Int  = 1656
    
    private init() { }
    
    func tokenTimeCounter(date: Date, min: Int,key: String){
        let startDate = date
        let expireDate = startDate.addingTimeInterval(TimeInterval(min * 60))
        UserDefaults.standard.setValue(expireDate, forKey: key)
        print(key)
        print(startDate)
        print(expireDate)
    }
    
    func checkTokenTime(dateNow: Date, accessExpire: Date, refreshExpire: Date,view: UIViewController){
//        self.authLoginResponseArray = []
        if UserDefaults.standard.string(forKey: "access_token").unsafelyUnwrapped != ""{
            if (dateNow >= accessExpire){
                print("----Expire----")
                if (dateNow < refreshExpire){
                    let headers: HTTPHeaders = ["refreshToken": "Bearer \(UserDefaults.standard.string(forKey: "refresh_token").unsafelyUnwrapped)"]
                        AF.request(url, method: .get, headers: headers).responseJSON { (response) in
                            switch response.result{
                            case .success:
                                do {
                                    let result = try JSONDecoder().decode(AuthLoginResponse.self, from: response.data!)
                                    self.authLoginResponseArray = [result]
                                    let code = (self.authLoginResponseArray[0].status.code)
                                    if code == self.successCode{
                                        UserDefaults.standard.setValue((self.authLoginResponseArray[0].data.accessToken), forKey: "access_token")
                                        UserDefaults.standard.setValue((self.authLoginResponseArray[0].data.refreshToken), forKey: "refresh_token")
                                        print("SUCCESS")
                                        self.tokenTimeCounter(date: Date(), min: 1, key: "access_token_expire")
                                        self.tokenTimeCounter(date: Date(), min: 1140, key: "refresh_token_expire")
                                    }
                                } catch {
                                    let alert = UIAlertController(title: "Session Expire", message: "please login again", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
                                        view.dismiss(animated: true, completion: nil)
                                        
                                        UserDefaults.standard.set("", forKey: "access_token")
                                        UserDefaults.standard.set("", forKey: "refresh_token")
                                        UserDefaults.standard.set("", forKey: "username")
                                        UserDefaults.standard.set(Date(), forKey: "access_token_expire")
                                        UserDefaults.standard.set(Date(), forKey: "refresh_token_expire")
                                    }))
                                    view.present(alert, animated: true, completion: nil)
                                }
                            case .failure(let error):
                                self.alertFromActionLogin(title: "No Internet", msg: "Please try again")
                                print("Network Error: \(error.localizedDescription)")
                            }
                    }
                } else {
                    print("-----CATCH------")
                    let alert = UIAlertController(title: "Session Expire", message: "please login again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
                        view.dismiss(animated: true, completion: nil)
                        
                        UserDefaults.standard.set("", forKey: "access_token")
                        UserDefaults.standard.set("", forKey: "refresh_token")
                        UserDefaults.standard.set("", forKey: "username")
                        UserDefaults.standard.set(Date(), forKey: "access_token_expire")
                        UserDefaults.standard.set(Date(), forKey: "refresh_token_expire")
                    }))
                    view.present(alert, animated: true, completion: nil)
                }
            } else {
                print("Access token is alive")
            }
        }
    }
    
    func alertFromActionLogin(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        // show the alert
        UIViewController.init().present(alert, animated: true, completion: nil)
    }
    
}
