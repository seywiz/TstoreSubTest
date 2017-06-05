//
//  AppListViewController.swift
//  TstoreSubTest
//
//  Created by iz on 2017. 6. 2..
//  Copyright © 2017년 iz. All rights reserved.
//

import Foundation

import UIKit

class AppListViewController : UITableViewController {
    //앱 정보 저장 배열
    var appInfo = [AppVO]()
    
    var page = 1
    //var categoryParam : String

    @IBOutlet var moreBtn: UIButton!

    
    override func viewDidLoad() {
        callDataforSub()
    }

    
    //쎌 그리기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(withIdentifier: "appCell") as! AppListCell
        
        NSLog("그리는중 : \(indexPath.row)")
        
        aCell.name?.text = appInfo[indexPath.row].appName
        aCell.webUrl?.text = appInfo[indexPath.row].webUrl
        aCell.downloadCount?.text = "\(appInfo[indexPath.row].downloadCount!)"
        aCell.score?.text = "\(appInfo[indexPath.row].score!)"
        aCell.desc?.text = appInfo[indexPath.row].desc

        DispatchQueue.main.async(execute:
            {
            aCell.thumbnailUrl?.image = self.getThumbnailImage(indexPath.row)
            }
        )
        
        
        return aCell
    }
    
    @IBAction func more(_ sender: AnyObject) {
        self.page += 1
        callDataforSub()
        self.tableView.reloadData()

    }
    
    
    // api 호출 함수
    func callDataforSub () {
        let moreUrl = "http://apis.skplanetx.com/tstore/categories/DP01?count=10&order=R&page=\(self.page)&version=1&appKey=5454a982-8dae-3ba8-958e-b47dbf1f3624"
        let appURL : URL! = URL(string: moreUrl)
        //URL로 부터 테이터 받아오기 --> try! Data(contentsOf : url)
        let appData = try! Data(contentsOf: appURL)
        
        do{
            let parsingAppData = try JSONSerialization.jsonObject(with: appData, options: []) as! NSDictionary
            
            let tstore = parsingAppData["tstore"] as! NSDictionary
            let products = tstore["products"] as! NSDictionary
            let product = products["product"] as! NSArray

            
            for row in product {
                //배열을 딕셔너리로 변경
                let r = row as! NSDictionary
                
                let avo = AppVO()
                avo.appName = r["name"] as? String
                avo.thumbnailUrl = r["thumbnailUrl"] as? String
                avo.webUrl = r["webUrl"] as? String
                avo.downloadCount = r["downloadCount"] as? Int
                avo.score = r["score"] as? Float
                avo.desc = r["description"] as? String
                
                appInfo.append(avo)
            
            }

            //버튼 숨김 처리
            let category = tstore["category"] as! NSDictionary
            let totalCount = category["totalCount"] as! Int

            if self.appInfo.count >= totalCount {
                self.moreBtn.isHidden = true
            }

            
        }catch{
            
        }
    }
    
    func getThumbnailImage(_ index:Int) -> UIImage {
        let aVO = self.appInfo[index]
        
        if let savedImage = aVO.thumbnailImage {
            return savedImage
        }else{
            let url : URL! = URL (string:aVO.thumbnailUrl!)
            let imageData = try! Data(contentsOf: url)
            aVO.thumbnailImage = UIImage(data: imageData)

            NSLog("비동기 실행중")

            return aVO.thumbnailImage!

        }
    }
}
