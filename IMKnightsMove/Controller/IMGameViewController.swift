
import UIKit

class IMGameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var knightArr:[IMKnight] = [IMKnight]()
    var knightPosArr:[Int] = [Int]()
    var totalScore:Int = 0
    
    var isGameStart:Bool  = false
    var hasPosToMove:Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var showCaseView: UIView!
    
    var MAXROW:Int = 0
    var MAXCOL:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        self.collectionView.register(UINib.init(nibName: "IMGridCell", bundle: .main), forCellWithReuseIdentifier: IMGridCellReusableId)
        self.titleLabel.isHidden = true
        self.showCaseView.isHidden = true
        self.collectionView.reloadData()
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.showCaseViewTapped))
        self.showCaseView.addGestureRecognizer(tapGesture)
    }
    
    func setupModel() {
        for _ in 0...(MAXROW*MAXCOL) {
            let knight:IMKnight = IMKnight()
            self.knightArr.append(knight)
        }
    }
    
    //Mark:- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewFlowLayout
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MAXROW*MAXCOL
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gridCell:IMGridCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: IMGridCellReusableId, for: indexPath) as! IMGridCell
        gridCell.setupKnightCell(knight: self.knightArr[indexPath.row])
        return gridCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let knight:IMKnight = self.knightArr[indexPath.row]
        if !(self.isGameStart) {
            self.isGameStart = true
            knight.isVisited = true
            knight.isKnight = true
            self.totalScore = self.totalScore + 1
        }else {
            if !(knight.isVisited) && (knight.isAvailableToMove) {
                knight.isVisited = true
                knight.isKnight = true
                knight.isAvailableToMove = false
                self.totalScore = self.totalScore + 1
            }else {
                return
            }
        }
        
        knightPosArr.append(indexPath.row)
        self.scoreLabel.text = "\(self.totalScore)"
        self.updatePossibleKnightPossitionFor(index:indexPath.row)
    
        if self.isWin() || isLose() {
            knight.isKnight = false
            self.titleLabel.isHidden = false
            self.showCaseView.isHidden = false
        }
        self.collectionView.reloadData()
    }
    
    func isWin() -> Bool {
        if self.totalScore == MAXROW*MAXCOL {
            self.titleLabel.text = "GOOD JOB. YOU DONE IT !!!"
            return true
        }
        return false
    }
    
    func isLose() -> Bool {
        if !self.hasPosToMove {
            self.titleLabel.text = "YOU LOSE. TRY AGAIN..."
            return true;
        }
        self.hasPosToMove = false
        return false
    }
    
    func updatePossibleKnightPossitionFor(index:Int) {
        
        let pos = (row:index / MAXCOL, col:index % MAXROW)
        var topRightIndex = -1
        var topLeftIndex = -1
        var bottomRightIndex = -1
        var bottomLeftIndex = -1
        var leftTopIndex = -1
        var leftBottomIndex = -1
        var rightTopIndex = -1
        var rightBottomIndex = -1
        
        let topRight = (row:(pos.row - 2), col:(pos.col + 1))
        if isValid(row: topRight.row, col: topRight.col) {
            topRightIndex = (topRight.row * MAXROW) + topRight.col
        }
        let topLeft = (row:(pos.row - 2), col:(pos.col - 1))
        if isValid(row: topLeft.row, col: topLeft.col) {
            topLeftIndex = (topLeft.row * MAXROW) + topLeft.col
        }
        
        
        let bottomRight = (row:(pos.row + 2), col:(pos.col + 1))
        if isValid(row: bottomRight.row, col: bottomRight.col) {
            bottomRightIndex = (bottomRight.row * MAXROW) + bottomRight.col
        }
        let bottomLeft = (row:(pos.row + 2), col:(pos.col - 1))
        if isValid(row: bottomLeft.row, col: bottomLeft.col) {
            bottomLeftIndex = (bottomLeft.row * MAXROW) + bottomLeft.col
        }
        
        let leftTop = (row:(pos.row - 1), col:(pos.col - 2))
        if isValid(row: leftTop.row, col: leftTop.col) {
            leftTopIndex = (leftTop.row * MAXROW) + leftTop.col
        }
        let leftBottom = (row:(pos.row + 1), col:(pos.col - 2))
        if isValid(row: leftBottom.row, col: leftBottom.col) {
            leftBottomIndex = (leftBottom.row * MAXROW) + leftBottom.col
        }
        
        let rightTop = (row:(pos.row - 1), col:(pos.col + 2))
        if isValid(row: rightTop.row, col: rightTop.col) {
            rightTopIndex = (rightTop.row * MAXROW) + rightTop.col
        }
        
        let rightBottom = (row:(pos.row + 1), col:(pos.col + 2))
        if isValid(row: rightBottom.row, col: rightBottom.col) {
            rightBottomIndex = (rightBottom.row * MAXROW) + rightBottom.col
        }
        
        for index in 0...(MAXROW*MAXCOL) {
            if index == topRightIndex ||
                index == topLeftIndex ||
                index == bottomRightIndex ||
                index == bottomLeftIndex ||
                index == leftTopIndex ||
                index == leftBottomIndex ||
                index == rightTopIndex ||
                index == rightBottomIndex  {
                self.updateColorWithIndex(index: index)
            }else {
                self.resetColorWithIndex(index: index)
            }
        }
    }
    
    func updateColorWithIndex(index:Int) {
        let knight:IMKnight = self.knightArr[index]
        if !(knight.isVisited) {
            self.hasPosToMove = true
            knight.isAvailableToMove = true
        }
    }
    
    func resetColorWithIndex(index:Int) {
        let knight:IMKnight = self.knightArr[index]
        if !(knight.isVisited) {
            knight.isAvailableToMove = false
        }
    }
    
    func isValid(row:Int, col:Int)->Bool {
        if (row >= 0 && row < MAXROW) && ((col >= 0 && col < MAXCOL)) {
            return true
        }
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let emptySpace:CGFloat = CGFloat(((MAXROW-1) * 2 ) + 4)
        let width = (self.collectionView.frame.size.width - emptySpace) / CGFloat(MAXROW)
        let height = (self.collectionView.frame.size.height - emptySpace) / CGFloat(MAXROW)
        return CGSize.init(width: width, height: height)
    }
    
    //MARK:- Button Actions
    
    @IBAction func backButtonActions(_ sender: Any) {
        
        if self.knightPosArr.count > 1 {
            let lastIndex = self.knightPosArr.last
            let knight:IMKnight = self.knightArr[lastIndex!]
            knight.isKnight = false;
            knight.isVisited = false;
            self.knightPosArr.removeLast()
            self.totalScore = totalScore - 1
        }
        
        if self.knightPosArr.count > 0 {
            let index = self.knightPosArr.last
            let kn:IMKnight = self.knightArr[index!]
            kn.isKnight = true
            self.scoreLabel.text = "\(self.totalScore)"
            self.updatePossibleKnightPossitionFor(index:index!)
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func resetButtonActions(_ sender: Any) {
        self.resetGameBoard()
    }
    
    func resetGameBoard() {
        self.totalScore = 0;
        self.isGameStart = false
        self.titleLabel.isHidden = true
        self.showCaseView.isHidden = true
        self.knightArr = [IMKnight]()
        self.knightPosArr = [Int]()
        self.setupModel()
        self.scoreLabel.text = "\(self.totalScore)"
        self.collectionView.reloadData()
    }
    
    @objc func showCaseViewTapped() {
        if self.isWin() {
            if self.MAXROW != 8 {
                self.MAXROW = self.MAXROW + 1
                self.MAXCOL = self.MAXROW
                self.resetGameBoard()
                return
            }
            let _ = self.navigationController?.popViewController(animated: true)
        }else {
            self.resetGameBoard()
        }
    }
    
    @IBAction func menuButtonAction(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}
