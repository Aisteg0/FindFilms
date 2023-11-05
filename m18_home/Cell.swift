//
//  Cell.swift
//  m18_home
//
//  Created by Михаил Ганин on 13.04.2023.
//

import Foundation
import UIKit
import SnapKit

class Cell: UITableViewCell {
    

        
    let cellIdentifer = "cellIdentifier"
    
    var networkService = NetworkService()
    var textToShow: String? {
        didSet {
            imageOfFilm2 = textToShow
        }
    }

   
    var imageOfFilm2: String? = nil
    
    private lazy var imageForCell: UIImageView = {
        let imageForCell = UIImageView()
        return imageForCell
        
    }()
    
    
    
    private lazy var labelForCell: UILabel = {
       let labelForCell = UILabel()
        labelForCell.text = textToShow
        return labelForCell
    }()
    
    func initCell(item: Result) {
        networkService.loadImage(imageFromResult: item.image) { [self] image in
            imageForCell.image = image
        }
        textToShow? = item.title
    }
    

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addView()
        addConstraints2()
            }
    
    private func addView() {
        contentView.addSubview(imageForCell)
        contentView.addSubview(labelForCell)
    }
    
    private func addConstraints2() {
        imageForCell.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.height.equalTo(55)
            make.width.equalTo(40)
            make.top.equalTo(15)
        }
        labelForCell.snp.makeConstraints({ make in
            make.left.equalTo(imageForCell).inset(50)
            make.top.equalTo(15)
            
        })
    }
   
}



