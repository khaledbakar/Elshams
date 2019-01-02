//
//  NewsVC.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class NewsVC: BaseViewController , UIScrollViewDelegate ,  UITableViewDelegate , UITableViewDataSource{
   // @IBOutlet weak var newTitle: UILabel!
    
    var newsList = Array<NewsData>()
    @IBOutlet weak var scrollContainer: UIScrollView!
    @IBOutlet weak var newsControl: UIPageControl!
 //   @IBOutlet weak var newsImg: UIImageView!
    var timer:Timer!
    var updateCounter : Int!
    var images = ["rest","map_ic","profile1","profile2"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var frameView = CGRect(x: 0, y: 0, width: 0, height: 0)

    var frameTitle = CGRect(x: 20, y: 110, width: 320, height: 70)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
      //  newTitle.isHidden = true
        self.navigationItem.title = "News"
        newsList.append(NewsData(NewsTitle: "Integer ut placerat purued non dignissim neque we share love enjoy and happiness ", NewsImageUrl: "rest", NewsDetail: "sar7 ms2ool en el donya htb2a r5isa tani w kd wafk glaltho 3la el matlbyn ", NewsDate: "4,jan 2018"))
        newsList.append(NewsData(NewsTitle: "Khaled bakar has a new Award", NewsImageUrl: "profile2", NewsDetail: "7az bakar 3la 2 awards in the same year fe mgalin mo5tlfin , golden image in photography and programmer of the year in ios development ", NewsDate: "2,Aug 2018"))
       
        scrollContainer.contentSize = CGSize(width: (scrollContainer.frame.size.width * CGFloat(images.count)) , height: scrollContainer.frame.size.height)
        scrollContainer.delegate = self
        newsControl.numberOfPages = images.count
        
        for index in 0..<images.count {
            frame.origin.x = scrollContainer.frame.size.width * CGFloat(index)
              frame.size = CGSize(width: scrollContainer.frame.size.width , height: 233.0)
            
            let titleLbl = UILabel(frame: frameTitle)
            titleLbl.text = newsList[0].newsTitle
            titleLbl.numberOfLines = 2
            titleLbl.textColor = UIColor.white
            titleLbl.font = titleLbl.font.withSize(22.0)
           // newTitle.text = newsList[0].newsTitle
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: images[index])
            
            imgView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width)
            imgView.topAnchor.constraint(equalTo:  scrollContainer.topAnchor, constant: 0)
            imgView.bottomAnchor.constraint(equalTo:  scrollContainer.bottomAnchor, constant: 0)
            

            let titleView = UIView(frame: frame)
            titleView.backgroundColor = UIColor.black
            titleView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            titleView.addSubview(titleLbl)

            scrollContainer.addSubview(imgView)
            scrollContainer.addSubview(titleView)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newscell") as! AllNewsCell
        cell.setNewsCell(newsList: newsList[indexPath.row])
        return cell
    
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newsdetail", sender:  newsList[indexPath.row])
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dis = segue.destination as? NewsDetails {
            if let favDetail = sender as? NewsData {
                dis.singleItem = favDetail
            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollContainer.contentOffset.x / scrollContainer.frame.size.width
        newsControl.currentPage = Int(pageNumber)
    }
    
}
