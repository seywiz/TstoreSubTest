//
//  ListCellViewController.swift
//  TstoreSubTest
//
//  Created by iz on 2017. 6. 2..
//  Copyright © 2017년 iz. All rights reserved.
//

import Foundation
import UIKit

class ListCellViewController : UITableViewController {
    //데이터 바구니 생성
    
    var list = [AppVO]()
    
    override func viewDidLoad() {
        CallDataForMain()
    }
    
    // 데이터에 맞게 화면 구성
    // 리스트 갯수 정의
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    // 리스트 쎌 구성
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as UITableViewCell!
        
        tempCell?.textLabel?.text = list[indexPath.row].categoryName
        tempCell?.detailTextLabel?.text = list[indexPath.row].categoryCode

        return tempCell!
    }
    
    
    
    
    //공통 기능 - 데이터 통신 및 파싱
    func CallDataForMain () {
        let url = "http://apis.skplanetx.com/tstore/categories?version=1&appKey=5454a982-8dae-3ba8-958e-b47dbf1f3624"
        let apiURL : URL! = URL(string: url)
        // url 로부터 통신 및 데이터 수령
        let apiData = try! Data(contentsOf: apiURL)
        let apiDataToConvert = NSString(data: apiData, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog(" \(apiDataToConvert)")
        
        do {
        let parsingData = try JSONSerialization.jsonObject(with: apiData, options: []) as! NSDictionary
        
            let tstore = parsingData["tstore"] as! NSDictionary
            let categories = tstore["categories"] as! NSDictionary
            let category = categories["category"] as! NSArray
            
            for row in category {
                
                //배열로 받은 row 를 딕셔너리로 형변환
                let r = row as! NSDictionary

                let avo = AppVO()
                avo.categoryName = r["categoryName"] as? String
                avo.categoryCode = r["categoryCode"] as? String
                
                list.append(avo)
            }
        
        }catch{
            
        }
    }
}
