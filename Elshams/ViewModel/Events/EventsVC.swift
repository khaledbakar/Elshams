//
//  EventsVC.swift
//  Elshams
//
//  Created by mac on 12/3/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class EventsVC: UIViewController , UICollectionViewDataSource ,UICollectionViewDelegate {
    
    var eventList = Array<CollectionViewItems>()

    override func viewDidLoad() {
        super.viewDidLoad()
        eventList.append(CollectionViewItems(Name: "EmaarMasr", Address: "Cairo,Egypt", Detail: "the most famous", ImageUrl: "rest"))
         eventList.append(CollectionViewItems(Name: "EmaarMasr2", Address: "Cairo,Egypt2", Detail: "the most famous2", ImageUrl: "rest"))
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return eventList.count
             }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     performSegue(withIdentifier: "eventdetail", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventscell", for: indexPath) as! EventsCell
    cell.setEventsCell(EventItemsList: eventList[indexPath.row])
    return cell
            }
    
}
