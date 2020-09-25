//
//  PrayerReadingViewController.swift
//  OrthodoxPrayers
//
//  Created by Andrei Marincas on 30/08/2020.
//  Copyright © 2020 Andrei Marincas. All rights reserved.
//

import UIKit

class PrayerReadingViewController: UIViewController {
    private var textView: DropCapTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView = DropCapTextView()
        textView.bodyFont = UIFont(name: "Georgia", size: 17)!
        textView.glyphFont = UIFont(name: "Arhaic", size: 70)!
        textView.backgroundColor = .clear
        
//        textView.text = "Tatăl nostru, Care ești în ceruri, sfințească-Se numele Tău, vie împărăția Ta, facă-se voia Ta, precum în cer așa și pe pământ. Pâinea noastră cea de toate zilele, dă-ne-o nouă astăzi, și ne iartă nouă greșalele noastre, precum și noi iertăm greșiților noștri. Și nu ne duce pe noi în ispită, ci ne izbăvește de cel rău."
        
        textView.text = "Doamne Iisuse Hristoase, Fiul lui Dumnezeu, pentru rugăciunile Preacuratei Maicii Tale și ale tuturor Sfinților, miluiește-ne pe noi. Amin."
        
//        textView.text = "Împărate Ceresc, Mângâietorule, Duhul Adevărului, Care pretutindenea ești și toate le plinești, Vistierul bunătăților și Dătătorule de viață, vino și Te sălășluiește întru noi și ne curățește pe noi de toată spurcăciunea și mântuiește, Bunule, sufletele noastre."
        
//        textView.text = "Sfinte Dumnezeule, Sfinte tare, Sfinte fără de moarte, miluiește-ne pe noi (de 3 ori)."
        
//        textView.text = "Sfinte Dumnezeule, Sfinte tare, Sfinte fără de moarte, miluiește-ne pe noi. Sfinte Dumnezeule, Sfinte tare, Sfinte fără de moarte, miluiește-ne pe noi. Sfinte Dumnezeule, Sfinte tare, Sfinte fără de moarte, miluiește-ne pe noi."
        
        view.addSubview(textView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.sizeToFit()
        textView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
    }
}
