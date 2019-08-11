//
//  DetailViewController.swift
//  SlideshowApp
//
//  Created by Hitoshi KAMADA on 2019/08/11.
//  Copyright © 2019 hitoshi.kamada. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    // 選択された画像名
    var selectedImageName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = selectedImageName
        
        // 画像名がセットされていれば画像を表示する
        if !selectedImageName.isEmpty {
            imageView.image = UIImage(named: selectedImageName)
        }
    }
}
