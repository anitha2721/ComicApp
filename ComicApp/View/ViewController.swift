//
//  ViewController.swift
//  ComicApp
//
//  Created by Anitha Selvarajan on 9/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = .max
        descriptionLabel.font = UIFont(name: "Arial", size: 16.0)
        return descriptionLabel
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        return titleLabel
    }()
    
    var res = ""
    let comicViewModel = ComicViewModel()
    let imageArr = [Thumbnail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        view.addSubview(titleLabel)
        
        setWidthHeightConstrains(subView: titleLabel, width: 200, height: 50)
        setWidthHeightConstrains(subView: descriptionLabel, width: 250, height: 250)
        
        someImageViewConstraints()
        getData()
    }
    
    func setWidthHeightConstrains(subView: UILabel, width: CGFloat, height: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        subView.widthAnchor.constraint(equalToConstant: width).isActive = true
        subView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func someImageViewConstraints() {
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 70).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func getData() {
        comicViewModel.getData { [self] in
            let result = comicViewModel.comicArray
            for item in result {
                self.titleLabel.text = item.title
                self.descriptionLabel.text = String(describing: item.resultDescription)
                self.res = [item.thumbnail?.path, item.thumbnail?.thumbnailExtension].compactMap { $0 }.joined(separator:".")
            }
            self.imageView.loadImg(stringUrl: self.res)
        }    }
}
