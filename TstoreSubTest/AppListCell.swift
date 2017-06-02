//
//  AppListCell.swift
//  TstoreSubTest
//
//  Created by iz on 2017. 6. 2..
//  Copyright © 2017년 iz. All rights reserved.
//

import Foundation
import UIKit

class AppListCell : UITableViewCell {

    @IBOutlet var thumbnailUrl: UIImageView? // 앱 썸네일
    @IBOutlet var name: UILabel?    // 앱 이름
    @IBOutlet var webUrl: UILabel?  // URL
    @IBOutlet var downloadCount: UILabel? //다운로드수
    @IBOutlet var score: UILabel? //평점
    
    
    
}
