//
//  ViewController.swift
//  Demo
//
//  Created by Sopan M. Sanap on 20/08/19.
//  Copyright © 2019 Sopan M. Sanap. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var txtfTag: UITextField!
    
    var tagArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "TagCell", bundle: nil), forCellWithReuseIdentifier: "TagCell")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func removeTag(sender: UIButton){
    
        tagArr.remove(at: sender.tag)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }


}

extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagNewCell", for: indexPath) as? TagNewCell{
            
            cell.lblTag.text = "#"+tagArr[indexPath.item]
            
           cell.btnRemoveTag.addTarget(self, action: #selector(removeTag(sender:)), for: .touchUpInside)
            cell.btnRemoveTag.tag = indexPath.item
            DispatchQueue.main.async {
                
                cell.tagContainerView.layer.cornerRadius = cell.tagContainerView.frame.height/2
                cell.tagContainerView.layer.masksToBounds = true
            }
            
           
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = tagArr[indexPath.item]
        label.sizeToFit()
        let height:CGFloat?
        let width: CGFloat?
        
        if label.frame.width > self.collectionView.frame.width-51 && label.frame.width < 2 * self.collectionView.frame.width-51{
            height = label.frame.height+30
            width = self.collectionView.frame.width
        }else if label.frame.width > 2 * self.collectionView.frame.width-51 && label.frame.width < 3 * self.collectionView.frame.width-51{
            height = label.frame.height+60
            width = self.collectionView.frame.width
        }else if label.frame.width > 3 * self.collectionView.frame.width-51 && label.frame.width < 4 * self.collectionView.frame.width-51{
            height = label.frame.height+90
            width = self.collectionView.frame.width
        }else if label.frame.width < self.collectionView.frame.width-51 {
            height = label.frame.height+15
            width = label.frame.width+60
        }else{
            height = label.frame.height+120
            width = self.collectionView.frame.width
        }

        return CGSize(width:width!, height: height!)
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension ViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !(textField.text?.isEmpty)!{
            tagArr.append(textField.text!)
             DispatchQueue.main.async {
            self.collectionView.reloadData()
            }
            textField.text = ""
            textField.resignFirstResponder()
            return true
        }else{
            textField.resignFirstResponder()
            return false
        }
        
    }
}
