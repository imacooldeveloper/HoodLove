//
//  LocationSearchCell.swift
//  HoodLove
//
//  Created by Martin Gallardo on 5/18/20.
//  Copyright © 2020 Martin Gallardo. All rights reserved.
//

import UIKit

class LocationSearchCell: UITableViewCell {
    
    let cellBackgroundView = UIView()
    let titleCellName = UILabel(text: "", font: .systemFont(ofSize: 20, weight: .medium))
    let secondtitleCellName = UILabel(text: "", font: .systemFont(ofSize: 15, weight: .light))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        detailTextLabel != nil
        
        
        addSubview(cellBackgroundView)
        //cellBackgroundView.layer.borderWidth = 0.2
        //cellBackgroundView.layer.borderColor = #colorLiteral(red: 0.516300559, green: 0.8177587986, blue: 0.6682328582, alpha: 1)
//        cellBackgroundView.layer.cornerRadius = 6
//        cellBackgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        addSubview(titleCellName)
        titleCellName.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 14, left: 20, bottom: 0, right: 0),size: .init(width: 0, height: 0))
        
        addSubview(secondtitleCellName)
        secondtitleCellName.anchor(top: titleCellName.bottomAnchor, leading: titleCellName.leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 8, left: 10, bottom: 0, right: 0),size: .init(width: 0, height: 0))
        addSubview(cellBackgroundView)
        cellBackgroundView.layer.borderWidth = 1.2
                cellBackgroundView.layer.borderColor = #colorLiteral(red: 0.516300559, green: 0.8177587986, blue: 0.6682328582, alpha: 1)
               cellBackgroundView.layer.cornerRadius = 6
        cellBackgroundView.anchor(top: nil, leading: secondtitleCellName.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 0),size: .init(width: 0, height: 1))
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
