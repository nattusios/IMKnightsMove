
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
            self.imgView.image = UIImage.init(named: "current-knight")
            knight.isKnight = false
        }else {
            self.bgView.backgroundColor = UIColor.clear
            if knight.isVisited {
                self.imgView.image = UIImage.init(named: "")
            }else {
                self.imgView.image = UIImage.init(named: "off")
            }
            if knight.isAvailableToMove {
                self.imgView.image = UIImage.init(named: "on")
            }
        }
    }
}
