//
//  PauseViewController.swift
//  little game
//
//  Created by Stephen on 2021/6/17.
//

import UIKit

class PauseViewController: UIViewController {
    
    
    @IBOutlet weak var pauseImageView: UIImageView!
    
    
    let urlStr = "https://live.staticflickr.com/65535/51252223682_fe998a311f_o.gif"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //下載並顯示GIF圖片
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let cfData = data as CFData
                    CGAnimateImageDataWithBlock(cfData, nil) { _, cgImage, _ in
                        DispatchQueue.main.async {
                            self.pauseImageView.image = UIImage(cgImage: cgImage)
                        }
                    }
                }
            }.resume()
        }
    }
    
}
