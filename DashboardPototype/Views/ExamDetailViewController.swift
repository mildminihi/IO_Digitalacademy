import UIKit

class ExamDetailViewController: UIViewController {
    
    @IBOutlet weak var examTitle: UILabel!
    var examName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        examTitle.text = examName

    }
    

}
