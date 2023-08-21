//
//  CheckBoxButton.swift
//  MyChore
//
//  Created by sole on 2023/08/09.
//

import UIKit

class CheckBoxButton: UIButton {
    var width: Double
    var height: Double
    
    var isChecked: Bool = false {
        didSet {
            updateImage()
        }
    }
    
    init(width: Double = 24,
         height: Double = 24) {
        self.width = width
        self.height = height
        
        super.init(frame: .zero)
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        updateImage()
    }
    
    private func updateImage() {
        let image = UIImage(systemName: isChecked ? "checkmark.square" : "square")
        
        // 이미지 크기 조절
        let resizedImage = image?.setSizeAndColor(width: self.width,
                               height: self.height,
                               color: .mcMainGreen)
        
        setImage(resizedImage, for: .normal)
    }
    
    @objc private func buttonTapped() {
        isChecked.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
