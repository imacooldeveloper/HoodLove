//
//  AlertButton.swift
//  HoodLove
//
//  Created by Martin Gallardo on 5/18/20.
//  Copyright © 2020 Martin Gallardo. All rights reserved.
//

import UIKit


struct Colors {
    static let seanRed = UIColor(red: 255/255, green: 71/255, blue: 56/255, alpha: 1)
}


struct Fonts {
    static let avenirNextMedium = "AvenirNext-Medium"
}

class AlertButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    private func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor     = Colors.seanRed
        titleLabel?.font    = UIFont(name: Fonts.avenirNextMedium, size: 20)
        layer.cornerRadius  = frame.size.height/2
    }
}
