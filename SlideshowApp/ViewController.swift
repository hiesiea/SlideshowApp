//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Hitoshi KAMADA on 2019/08/11.
//  Copyright © 2019 hitoshi.kamada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    // 画像リスト
    private let imageList = ["image1", "image2", "image3"]
    
    // 再生中かどうかのフラグ
    private var playing = false

    // 現在表示中の画像の位置
    private var position = 0
    
    // タイマー
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "一覧"
        imageView.image = UIImage(named: imageList[position])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 再生中なら停止する
        if playing {
            changePlayPauseButton(changePauseButton: false)
            stopTimer()
            playing = false
        }
        
        // 選択中の画像名を次画面へ渡す
        let detailViewController:DetailViewController = segue.destination as! DetailViewController
        detailViewController.selectedImageName = imageList[position]
    }
    
    // 戻るボタン押下時
    @IBAction func tappedRewind(_ sender: UIBarButtonItem) {
        changePrevImage()
        print("tappedRewind")
    }
    
    // 進むボタン押下時
    @IBAction func tappedFastForward(_ sender: UIBarButtonItem) {
        changeNextImage()
        print("tappedFastForward")
    }
    
    // 再生・停止ボタン押下時
    @IBAction func tappedPlayPause(_ sender: UIBarButtonItem) {
        print("tappedPlayPause")
        if !playing {
            changePlayPauseButton(changePauseButton: true)
            startTimer()
        } else {
            changePlayPauseButton(changePauseButton: false)
            stopTimer()
        }
        playing = !playing
    }
    
    // 一つ前の画像に戻す
    private func changePrevImage() {
        position -= 1
        
        // 要素の最初のにきたら最後まで進める
        if position < 0 {
            position = imageList.count - 1
        }
        imageView.image = UIImage(named: imageList[position])
        print("image position : \(position)")
    }
    
    // 一つ先の画像に進む
    @objc private func changeNextImage() {
        position += 1
        
        // 要素の終わりにきたら元に戻す
        if position > imageList.count - 1 {
            position = 0
        }
        imageView.image = UIImage(named: imageList[position])
        print("image position : \(position)")
    }
    
    // タイマーの開始
    private func startTimer() {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeNextImage), userInfo: nil, repeats: true)
            print("start timer")
        }
    }
    
    // タイマーの停止
    private func stopTimer() {
        if self.timer != nil {
            // タイマーを停止する
            self.timer.invalidate()
            // startTimer() の timer == nil で判断するために、 timer = nil としておく
            self.timer = nil
            print("stop timer")
        }
    }
    
    // 再生ボタン・停止ボタンの切り替え
    private func changePlayPauseButton(changePauseButton: Bool) {
        var items = toolbar.items!
        var toggleButton: UIBarButtonItem
        
        if changePauseButton {
            toggleButton = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(tappedPlayPause(_:)))
            items[0].isEnabled = false
            items[4].isEnabled = false
        } else {
            toggleButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(tappedPlayPause(_:)))
            items[0].isEnabled = true
            items[4].isEnabled = true
        }
        
        // ボタンを更新する
        items[2] = toggleButton
        toolbar.setItems(items, animated: false)
    }
}
