import UIKit
import Lottie
import Alamofire

class ExamLoginViewController: UIViewController{
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var authLoginResponseArray: [AuthLoginResponse] = []
    let url = URL(string: Constants.loginServiceUrl)!
    
    var successCode: String = "1000"
    var noDataCode: String  = "1699"
    var wrongDataCode: String  = "1599"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameField.center.x -= self.view.bounds.width
        self.passwordField.center.x -= self.view.bounds.width
        self.loginButton.center.x -= self.view.bounds.width
        self.textFieldDidBeginEditing(usernameField)
//        self.textFieldShouldEndEditing(usernameField)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.usernameField.center.x -= self.view.bounds.width
        self.passwordField.center.x -= self.view.bounds.width
        self.loginButton.center.x -= self.view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.displayAnimate()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            //email
            self.usernameField.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            //password
            self.passwordField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.6, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: [.curveEaseOut], animations: {
            //btnLogin
            self.loginButton.center.x += self.view.bounds.width
        }, completion: nil)
    }
    
    func displayAnimate(){
        //setting slide animation
        
        //setting blue wave
        let animationWave = Animation.named("1152-blue-waves")
        let animationWaveView = AnimationView(animation: animationWave)
        animationWaveView.frame = CGRect(x: 0, y: 500, width: self.view.frame.width, height: self.view.frame.height-400)
        self.preferredContentSize = animationWaveView.bounds.size
        view.addSubview(animationWaveView)
        animationWaveView.loopMode = .loop
        animationWaveView.play()
        self.view.sendSubviewToBack(animationWaveView)
    }
    
    @IBAction func btnLogin(){
        
        if usernameField.text?.isEmpty ?? true || passwordField.text?.isEmpty ?? true{
            print("textField is empty")
            self.alertFromActionLogin(title: "No Information", msg: "Please fields username/password")
        } else {
            self.postData()
            self.goToMain()
        }
    }
    
    func postData(){
        let body: [String: String] = ["username": usernameField.text!, "password": (passwordField.text!.sha256())]
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success:
                do {
                    let result = try JSONDecoder().decode(AuthLoginResponse.self, from: response.data!)
                    self.authLoginResponseArray = [result]
                    let code = (self.authLoginResponseArray[0].status.code)
                    if code == self.successCode{
                        UserDefaults.standard.setValue((self.authLoginResponseArray[0].data.accessToken), forKey: "token")
                        UserDefaults.standard.setValue(self.usernameField.text!, forKey: "username")
//                        print(UserDefaults.standard.string(forKey: "token"))
                        print("SUCCESS")
                    }else if code == self.noDataCode{
                        self.alertFromActionLogin(title: "Username is not registered", msg: "Please register")
                    }else if code == self.wrongDataCode{
                       self.alertFromActionLogin(title: "Wrong Username/Password", msg: "Please try again")
                    }
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                self.alertFromActionLogin(title: "No Internet", msg: "Please try again")
                print("Network Error: \(error.localizedDescription)")
            }
        }
    }
    
    func alertFromActionLogin(title: String, msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func goToMain(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "main_storyboard")
        self.present(storyBoard, animated: true, completion: nil)
    }
}

extension String {
    
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        return hexString
    }
}

extension ExamLoginViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isFirstResponder == true {
            textField.placeholder = "UsernameXX"
        }
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) {
        self.usernameField.placeholder = ""
        
    }
}

