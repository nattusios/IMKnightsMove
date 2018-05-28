
import UIKit

let IMGridCellReusableId = "IMGridCellReusableId"

class IMGridCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupKnightCell(knight:IMKnight) {
        if knight.isKnight {
            knight.isAvailableToMove = false
            self.imgView.image = UIImage.init(named: "knight")
            self.bgView.backgroundColor = UIColor.init(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255, alpha: 0.7) // For Indicating current knight position.
            knight.isKnight = false
        }else {
            self.bgView.backgroundColor = UIColor.clear
            if knight.isVisited {
                self.imgView.image = UIImage.init(named: "knight")
            }else {
                self.imgView.image = UIImage.init(named: "off")
            }
            if knight.isAvailableToMove {
                self.imgView.image = UIImage.init(named: "on")
            }
        }
    }
}
