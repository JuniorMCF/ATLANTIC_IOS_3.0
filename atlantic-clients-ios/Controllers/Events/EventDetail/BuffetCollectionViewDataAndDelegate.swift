import UIKit


class BuffetCollectionViewDataAndDelegate: NSObject {
    private var buffets = [[String]]()
    
    init(buffets : [[String]]){
        self.buffets = buffets
    }
}


extension BuffetCollectionViewDataAndDelegate: UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return buffets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buffets[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buffetCell", for: indexPath) as! BuffetCell
        
        
        if(indexPath.row == 0){
            cell.txtTitle.font = UIFont.boldSystemFont(ofSize: cell.txtTitle.font.pointSize + CGFloat(2.0))
        }else{
            cell.txtTitle.textColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        }
        
        cell.txtTitle.text = buffets[indexPath.section][indexPath.row]
        
        return cell
    }
    
    
    
    
  
    
}

extension BuffetCollectionViewDataAndDelegate: UICollectionViewDelegateFlowLayout{
   
 
  }
