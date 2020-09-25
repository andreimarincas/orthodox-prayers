//
//  ToggleButton.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 31/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class ToggleButton: UIButton {
    var image: UIImage? {
        didSet {
            updateImages()
        }
    }
    
    var selectedImage: UIImage? {
        didSet {
            updateImages()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateImages()
        }
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle() {
        isSelected.toggle()
    }
    
    private func updateImages() {
        // The image for normal state is always used by UIButton to be drawn darker
        // when highlighted (pressed), regardless if selected or not.
        setImage(isSelected ? selectedImage : image, for: .normal)
        setImage(selectedImage, for: .selected)
    }
}
