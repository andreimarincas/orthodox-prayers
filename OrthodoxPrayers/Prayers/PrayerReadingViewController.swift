//
//  PrayerReadingViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 30/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let text = "D"
        //let text = "RUGĂCIUNI"
        //let text = "AĂÂÎȚȘ"
        //let text = "RUGĂCIUNI AĂÂÎȚȘ"
        //let text = "SSSSSSSSSSSSSSSS"
        let text = "C"
        //let font = UIFont.systemFont(ofSize: 50)
        let font = UIFont(name: "Arhaic", size: 180)!
        let color = UIColor(named: "textHighlightColor")!
        //let attributes = [NSAttributedString.Key.font: font]
        //let attributedText = NSAttributedString(string: text, attributes: attributes)
        
//        let label = UILabel()
//        label.attributedText = attributedText
//        label.sizeToFit()
//        label.center = CGPoint(x: 200, y: 200)
//        view.addSubview(label)
//
//        let textView = CustomTextView()
//        textView.text = attributedText
//        textView.sizeToFit()
//        textView.center = CGPoint(x: 200, y: 300)
//        view.addSubview(textView)
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.backgroundColor = .black
        label.sizeToFit()
        label.center = CGPoint(x: 100, y: 200)
        view.addSubview(label)
//        log("label.bounds: \(label.bounds)")
//        log("label.bounds.size: \(label.bounds.size)")
//        log("label.frame: \(label.frame)")
//        log("label.frame.size: \(label.frame.size)")
        
        /*let textView = CustomTextView()
        textView.text = text
        textView.font = font
        textView.textColor = color
        textView.backgroundColor = .black
        textView.sizeToFit()
        //textView.updateUI()
        textView.center = CGPoint(x: 250, y: 200)
        view.addSubview(textView)*/
//        log("textView.bounds: \(textView.bounds)")
//        log("textView.bounds.size: \(textView.bounds.size)")
//        log("textView.frame: \(textView.frame)")
//        log("textView.frame.size: \(textView.frame.size)")
        
        let glyphs: [Character] = ["A", "Ă", "Â", "B", "C", "D", "E", "F", "G", "H", "I", "Î", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "Ș", "T", "Ț", "U", "V", "W", "X", "Y", "Z"]
        
        //let glyphView = GlyphView("A")
        let glyphView = GlyphView("Ș")
        glyphView.font = font
        glyphView.textColor = color
        glyphView.backgroundColor = .black
        glyphView.sizeToFit()
        glyphView.center = CGPoint(x: 250, y: 200)
        view.addSubview(glyphView)
    }
}
