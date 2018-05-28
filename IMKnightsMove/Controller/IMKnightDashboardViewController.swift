
import UIKit

class IMKnightDashboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Button Actions
    
    @IBAction func fiveGridButtonAction(_ sender: Any) {
        self.navigateToGameVCWith(row: 5, col: 5)
    }
    
    @IBAction func sixGridButtonAction(_ sender: Any) {
        self.navigateToGameVCWith(row: 6, col: 6)
    }
    
    @IBAction func sevenGridButtonAction(_ sender: Any) {
        self.navigateToGameVCWith(row: 7, col: 7)
    }
    
    
    @IBAction func eightGridButtonAction(_ sender: Any) {
        self.navigateToGameVCWith(row: 8, col: 8)
    }
    
    func navigateToGameVCWith(row:Int, col:Int) {
        let gameVC:IMGameViewController = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "IMGameViewController") as! IMGameViewController
        gameVC.MAXROW = row
        gameVC.MAXCOL = col
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
}
