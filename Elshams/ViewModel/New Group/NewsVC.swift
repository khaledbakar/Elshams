//
//  NewsVC.swift
//  Elshams
//
//  Created by mac on 12/6/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class NewsVC: BaseViewController , UIScrollViewDelegate ,  UITableViewDelegate , UITableViewDataSource{
   // @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var normalNewsTableView: UITableView!
    
    var newsList = Array<NewsData>()
    var topNewsList = Array<NewsData>()
    var scrolImageUrl : String?


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
       
       
        loadNewsData()
    }
  
    func loadTopNews()  {
        scrollContainer.contentSize = CGSize(width: (scrollContainer.frame.size.width * CGFloat(topNewsList .count)) , height: scrollContainer.frame.size.height)
        scrollContainer.delegate = self
        newsControl.numberOfPages = topNewsList.count
        for index in 0..<topNewsList.count {
            frame.origin.x = scrollContainer.frame.size.width * CGFloat(index)
            frame.size = CGSize(width: scrollContainer.frame.size.width , height: 233.0)
            
            let titleLbl = UILabel(frame: frameTitle)
            titleLbl.text = topNewsList[index].newsTitle
            titleLbl.numberOfLines = 2
            titleLbl.textColor = UIColor.white
            titleLbl.font = titleLbl.font.withSize(22.0)
            titleLbl.tag = index + 1
            print(titleLbl.tag)

            // newTitle.text = newsList[0].newsTitle
            
            let topNewsTitle = UITapGestureRecognizer(target: self, action: #selector(NewsVC.topNewsTitleFunc))
            titleLbl.isUserInteractionEnabled = true
            titleLbl.addGestureRecognizer(topNewsTitle)
            
            let imgView = UIImageView(frame: frame)
            scrolImageUrl = topNewsList[index].newsImgUrl
           // imgView.image = UIImage(named: images[index])
            imgScrollUrl(imgUrl: scrolImageUrl!, ScrollImage: imgView)
            imgView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width)
            imgView.topAnchor.constraint(equalTo:  scrollContainer.topAnchor, constant: 0)
            imgView.bottomAnchor.constraint(equalTo:  scrollContainer.bottomAnchor, constant: 0)
            imgView.tag = index + 1

            
            
            let titleView = UIView(frame: frame)
            titleView.backgroundColor = UIColor.black
            titleView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            let topNewsImage = UITapGestureRecognizer(target: self, action: #selector(NewsVC.topNewsImageFunc))
            titleView.isUserInteractionEnabled = true
         //   topNewsImage.valu
            titleView.addGestureRecognizer(topNewsImage)
            titleView.tag = index + 1
            print(titleView.tag)

            titleView.addSubview(titleLbl)
            
            scrollContainer.addSubview(imgView)
            scrollContainer.addSubview(titleView)
        }
    }

    @objc func topNewsTitleFunc(sender:UIGestureRecognizer) {//UIGestureRecognizer
      //  guard let TagRe = (sender.view as? UILabel)?.text else { return }
          guard let tag = (sender.view as? UILabel)?.tag else { return }
        performSegue(withIdentifier: "newsdetail", sender: topNewsList[tag - 1]) //topNewsList[]

    }
    @objc func topNewsImageFunc(sender:UIGestureRecognizer) {//UIGestureRecognizer
        guard let tag = (sender.view as? UIView)?.tag else { return }
        performSegue(withIdentifier: "newsdetail", sender: topNewsList[tag - 1])
    }
    func loadNewsData()  {
        Service.getService(url: "\(URLs.getNews)/50/1"){
            (response) in
            print(response)
            
            let result = JSON(response)
            let topNews = result["topNews"]
            let normalNews = result["normalNews"]

            var iDTopNotNull = true
            var iDNormalNotNull = true

            var indexTop = 0
            var indexNormal = 0

            while iDTopNotNull {
                let newsTop_ID = topNews[indexTop]["id"].string
                if newsTop_ID == nil || newsTop_ID?.trimmed == "" ||
                    newsTop_ID == "null" || newsTop_ID == "nil" {
                    iDTopNotNull = false
                    break
                }
            
                let newsTop_Title = topNews[indexTop]["title"].string
                let newsTop_ImageUrl = topNews[indexTop]["imageUrl"].string
                let newsTop_Content = topNews[indexTop]["content"].string
                let newsTop_Date = topNews[indexTop]["date"].string
                self.topNewsList.append(NewsData(NewsTitle: newsTop_Title ?? "", NewsImageUrl: newsTop_ImageUrl ?? "", NewsContent: newsTop_Content ?? "", NewsDate: newsTop_Date ?? "", NewsID: newsTop_ID ?? ""))
                indexTop = indexTop + 1
            }
            while iDNormalNotNull {
                let newsNormal_ID = normalNews[indexNormal]["id"].string
                if newsNormal_ID == nil || newsNormal_ID?.trimmed == "" ||
                    newsNormal_ID == "null" || newsNormal_ID == "nil" {
                    iDNormalNotNull = false
                    break
                }
                
                let newsNormal_Title = normalNews[indexNormal]["title"].string
                let newsNormal_ImageUrl = normalNews[indexNormal]["imageUrl"].string
                let newsNormal_Content = normalNews[indexNormal]["content"].string
                let newsNormal_date = normalNews[indexNormal]["date"].string
                self.newsList.append(NewsData(NewsTitle: newsNormal_Title ?? "", NewsImageUrl: newsNormal_ImageUrl ?? "", NewsContent: newsNormal_Content ?? "", NewsDate: newsNormal_date ?? "", NewsID: newsNormal_ID ?? ""))
                indexNormal = indexNormal + 1
            }
            
           self.normalNewsTableView.reloadData()
            self.loadTopNews()
           /* self.activityLoader.isHidden = true
            self.activityLoader.stopAnimating()
            self.notifyTableView.isHidden = false */
        }
    }
    func imgScrollUrl(imgUrl:String,ScrollImage:UIImageView)  {
        if let imagUrlAl = imgUrl as? String {
            Alamofire.request(imagUrlAl).responseImage(completionHandler: { (response) in
                print(response)
                if let image = response.result.value {
                    DispatchQueue.main.async{
                        ScrollImage.image = image
                    }
                }
            })
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
