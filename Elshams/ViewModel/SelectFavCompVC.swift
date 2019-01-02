//
//  SelectFavCompVC.swift
//  Elshams
//
//  Created by mac on 11/27/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class SelectFavCompVC: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
   
    
    let  arr:[String] = ["Emaar Misr","2","3","7","12"]
    let  arrAdd:[String] = ["5th Avnue,5th elobour,Egypt","5th Avnue,5th elobour,Egypt","5th Avnue,5th elobour,Egypt","5th Avnue,5th elobour,Egypt","5th Avnue,5th elobour,Egypt"]
    let  arrDetail:[String] = ["Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pec","Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pec","3","7","12"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectFavCompCVC
        cell.companyName.text = arr[indexPath.row]
        cell.companyAddress.text = arrAdd[indexPath.row]
        cell.companyDetail.text = arrDetail[indexPath.row]
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
