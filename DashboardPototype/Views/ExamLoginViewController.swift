import UIKit
import Lottie
import Alamofire

class ExamLoginViewController: UIViewController{
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
//    let authResponseArray: [StatusAuth] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayAnimate()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
        self.usernameField.center.x -= self.view.bounds.width
        self.passwordField.center.x -= self.view.bounds.width
        self.loginButton.center.x -= self.view.bounds.width
        
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
        print("Login")
        let url = URL(string: "http://192.168.111.23:10080/api/auth")!
//        AF.request(url, method: .get).responseJSON { (response) in
//            if let data = response.data,
//                let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
//                print(urlContent)
//            } else {
//                print("Error")
//            }
        // prepare json data
        let json: [String: Any] = ["username": usernameField.text, "password": passwordField.text]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
}
