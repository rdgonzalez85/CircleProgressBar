//
//  GetValuesViewController.swift
//  CircleProgressBar
//
//  Created by Rodrigo Gonzalez on 09/02/2018.
//  Copyright © 2018 Rodrigo Gonzalez. All rights reserved.
//

import UIKit

class GetValuesViewController: UIViewController {

    @IBOutlet weak var circleView: CircleView!
    var presenter: GetValuesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getValues()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // color styles
    let passColor = UIColor(red:0.98, green:0.76, blue:0.45, alpha:1.00)
    let failColor = UIColor.red
    
    // font size styles
    let bigFontSize: CGFloat = 50
    let normalFontSize: CGFloat = 20
}

extension GetValuesViewController: GetValuesPresenterDelegate {
    func valueReady(value: VisualValue) {
        circleView.minValue = value.minScoreValue
        circleView.maxValue = value.maxScoreValue
        circleView.currentValue = value.score
        circleView.animateCircleColor = (value.status == .pass) ? passColor : failColor
        
        circleView.text = createAttributedText(title: value.title, isMainColor: value.status == .pass)
        circleView.animateCircle(duration: 1.0)
    }
    
    func createAttributedText(title: Title, isMainColor: Bool) -> NSAttributedString {
        
        let attributedText = NSMutableAttributedString()
        
        let textAttribute = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: normalFontSize) ]
        let text = NSMutableAttributedString(string: title.text, attributes: textAttribute)

        let valueAttribute = [ NSAttributedStringKey.font: UIFont.systemFont(ofSize: bigFontSize),
                               NSAttributedStringKey.foregroundColor: isMainColor ? passColor : failColor]
        
        let value = NSMutableAttributedString(string: title.value, attributes: valueAttribute)
        
        let text2 = NSMutableAttributedString(string: "\(title.text2) \(title.value2)", attributes: textAttribute)
        
        attributedText.append(text)
        attributedText.append(value)
        attributedText.append(text2)
        
        return attributedText
    }
    
    func valueError(error: Error) {
        // TODO: present an error
    }
}
