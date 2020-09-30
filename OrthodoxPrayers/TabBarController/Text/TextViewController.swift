//
//  TextViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 23/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    @IBOutlet weak var textView: TextView!
    @IBOutlet weak var slider: UISlider!
    
    let minBodyTextSize: CGFloat = 15
    let maxBodyTextSize: CGFloat = 26
    
    private let prayerReadingAttributes: PrayerReadingAttributes = {
        let defaultAttributes = PrayerReadingAttributes.default
        let textSize = CGFloat(UserDefaults.standard.textSize)
        return defaultAttributes.scaledTo(normalFontSize: textSize)
    }()
    
    private var lastSliderValue: Float = 0
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        configureSlider()
    }
    
    private func configureTextView() {
        textView.dropCapLetterFont = prayerReadingAttributes.dropCapLetterFont
        textView.bodyTextFont = prayerReadingAttributes.normalFont
        textView.text = "Tatăl nostru, Care ești în ceruri, sfințească-Se numele Tău, vie împărăția Ta, facă-se voia Ta, precum în cer așa și pe pământ. Pâinea noastră cea de toate zilele, dă-ne-o nouă astăzi, și ne iartă nouă greșalele noastre, precum și noi iertăm greșiților noștri. Și nu ne duce pe noi în ispită, ci ne izbăvește de cel rău."
    }
    
    private func configureSlider() {
        let max = maxBodyTextSize
        let min = minBodyTextSize
        let bodyTextSize = prayerReadingAttributes.normalFont.pointSize
        slider.value = Float(1 - (max - bodyTextSize) / (max - min))
        lastSliderValue = slider.value
        slider.addTarget(self, action: #selector(handleSliderTouch(_:forEvent:)), for: .allTouchEvents)
    }
    
    @IBAction func sliderValueChanged() {
        // Update font size for body text & drop cap letter
        let min = minBodyTextSize
        let max = maxBodyTextSize
        let newBodyTextSize = min + CGFloat(slider.value) * (max - min)
        
        let defaultAttributes = PrayerReadingAttributes.default
        let attrs = defaultAttributes.scaledTo(normalFontSize: newBodyTextSize)
        let newDropCapLetterSize = attrs.dropCapLetterFont.pointSize
        
        textView.updateFontSize(dropCapSize: newDropCapLetterSize, bodyTextSize: newBodyTextSize)
        
        // Generate haptic feedback when slider value reaches min/max
        let reachedMinimumValue = (slider.value == slider.minimumValue) && (lastSliderValue > slider.minimumValue)
        let reachedMaximumValue = (slider.value == slider.maximumValue) && (lastSliderValue < slider.maximumValue)
        if reachedMinimumValue || reachedMaximumValue {
            feedbackGenerator.impactOccurred()
        }
        lastSliderValue = slider.value
    }
    
    @objc func handleSliderTouch(_ slider: UISlider, forEvent event: UIEvent) {
        guard let touch = event.allTouches?.first else { return }
        switch touch.phase {
        case .ended:
            let textSize = Float(textView.bodyTextFont.pointSize)
            UserDefaults.standard.textSize = textSize
        default:
            break
        }
    }
}
