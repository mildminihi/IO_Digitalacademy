import Foundation
import Alamofire

class TimeCounterServices {
    
    static let timeCounter = TimeCounterServices()
    
    let url = URL(string: Constants.refreshTokenServiceUrl)!
    var authLoginResponseArray: [AuthLoginResponse] = []
    var successCode: Int = 1000
    var wrongDataCode: Int  = 1656
    
    private init() { }
    
    func tokenTimeCounter(date: Date, hour: Int){
        let startDate = date
        print(startDate)
        //        let expireDate = startDate.addingTimeInterval(TimeInterval(hour * 3600))
        let expireDate = startDate.addingTimeInterval(TimeInterval(5))
        print(expireDate)
        UserDefaults.standard.setValue(expireDate, forKey: "token_expire")
    }
    
    func checkTokenTime(dateNow: Date, dateExpire: Date,view: UIViewController){
        self.authLoginResponseArray = []
        if (dateNow >= dateExpire){
            print(UserDefaults.standard.string(forKey: "refresh_token").unsafelyUnwrapped)
            print("----Expire----")
            if UserDefaults.standard.string(forKey: "access_token").unsafelyUnwrapped != ""{
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
                                print(UserDefaults.standard.string(forKey: "refresh_token").unsafelyUnwrapped)
                                self.tokenTimeCounter(date: Date(), hour: 168)
                            }else if code == self.wrongDataCode{
                                self.alertFromActionLogin(title: "Expire Auth", msg: "Please login again")
                            }
                        } catch {
                            print("-----CATCH------")
                            let alert = UIAlertController(title: "Session Expire", message: "please login again", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
                                view.dismiss(animated: true, completion: nil)
                                UserDefaults.standard.set("", forKey: "access_token")
                                UserDefaults.standard.set("", forKey: "refresh_token")
                                UserDefaults.standard.set("", forKey: "username")
                                UserDefaults.standard.set(Date(), forKey: "token_expire")
                            }))
                            view.present(alert, animated: true, completion: nil)
                        }
                    case .failure(let error):
                        self.alertFromActionLogin(title: "No Internet", msg: "Please try again")
                        print("Network Error: \(error.localizedDescription)")
                    }
                }
            }
        }else{
            print("Alive")
        }
    }
    
    func alertFromActionLogin(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        // show the alert
        UIViewController.init().present(alert, animated: true, completion: nil)
    }
    
}
