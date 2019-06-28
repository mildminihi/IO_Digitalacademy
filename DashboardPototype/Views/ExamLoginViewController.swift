import UIKit
import Lottie
import Alamofire

class ExamLoginViewController: UIViewController{
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayAnimate()
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
        let url = "http://192.168.43.112:10080/api/auth"
        AF.request(url, method: .get).responseJSON { (response) in
            if let data = response.data,
                let urlContent = NSString(data: data, encoding: String.Encoding.ascii.rawValue) {
                print(urlContent)
            } else {
                print("Error")
            }
        }
    }
}
