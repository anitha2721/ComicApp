//
//  Extension.swift
//  ComicApp
//
//  Created by Anitha Selvarajan on 9/11/22.
//

import UIKit

///  UIImageView extension  to get image from url
extension UIImageView {
    func loadImg(stringUrl : String)  {
        guard let url = URL(string: stringUrl) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


