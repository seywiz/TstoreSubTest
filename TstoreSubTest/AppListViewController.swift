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
    
    override func viewDidLoad() {
        callDataforSub()
    }

    
    //쎌 그리기
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appInfo.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aCell = tableView.dequeueReusableCell(withIdentifier: "appCell") as! AppListCell
        
        aCell.name?.text = appInfo[indexPath.row].appName
        aCell.webUrl?.text = appInfo[indexPath.row].webUrl
        aCell.downloadCount?.text = "\(appInfo[indexPath.row].downloadCount!)"
        aCell.score?.text = "\(appInfo[indexPath.row].score!)"
        
        let url = appInfo[indexPath.row].thumbnailUrl
        let imgCellUrl : URL! = URL (string: url!)
        let imgData = try! Data(contentsOf: imgCellUrl)
        aCell.thumbnailUrl?.image = UIImage(data:imgData)
        
        
        
        return aCell
    }
    
    // api 호출 함수
    func callDataforSub () {
        let url2 = "http://apis.skplanetx.com/tstore/categories/DP01?count=10&order=R&page=1&version=1&appKey=5454a982-8dae-3ba8-958e-b47dbf1f3624"
        let appURL : URL! = URL(string: url2)
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

                appInfo.append(avo)
            }
        }catch{
            
        }
    }
}
