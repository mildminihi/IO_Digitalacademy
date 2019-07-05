import  Foundation
import UIKit

extension String{
    func toURL() -> URL{
        return URL(string: self)!
    }
}

extension UIView{
    func drawAsCircle(radius: CGFloat? = nil) {
        self.layer.masksToBounds = true
        
        if let cornerRadius = radius{
            self.layer.cornerRadius = cornerRadius
        }else{
            self.layer.cornerRadius = self.bounds.height / 2
        }
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: -0.15, height: 0.15)
        self.layer.shadowRadius = 2
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

extension UIAlertController {
    func alertWithOneOption(title: String, msg : String?, option :String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: option, style: .cancel, handler: nil))
        return alert
    }
}
