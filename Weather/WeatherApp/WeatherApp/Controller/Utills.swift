//
//  Utills.swift
//  WeatherApp
//
//  Created by user147463 on 3/12/19.
//  Copyright © 2019 Manibhushan Masabattina. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static let screenSize = UIScreen.main.bounds
    class func getStringDateFromTimeStamp(longNumber : Double , requiredDateFormat : String) -> String? {
        let date = Date(timeIntervalSince1970: longNumber)
        let formatter = DateFormatter()
        formatter.dateFormat = requiredDateFormat
        return formatter.string(from: date)
    }
    class func startLabelAnimation(label : UILabel , moveOptions : UIView.AnimationOptions) {
        
        DispatchQueue.main.async(execute: {
            
            UIView.animate(withDuration: 6.0, delay: 0.10, options: moveOptions, animations: {() -> Void in
                label.center = CGPoint(x: 0 - label.bounds.size.width / 2, y: label.center.y)
                
            }, completion:  nil)
            
        })
    }
    
}
extension UIViewController {
    func alertWithTitle(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
// MARK :- Custom Class For UIView
@IBDesignable class CustomView : UIView {
    @IBInspectable var startColor: UIColor = UIColor.white {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.black {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var isHorizontal: Bool = false {
        didSet{
            setupView()
        }
    }
    @IBInspectable var isPartial: Bool = true {
        didSet{
            setupView()
        }
    }
    @IBInspectable var roundness: Bool = false {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable open var shadowOpacity : Float = 1.0 {
        didSet {
            arrangeViews()
        }
    }
    @IBInspectable open var shadowOffset : CGSize = CGSize.zero{
        didSet {
            arrangeViews()
        }
    }
    @IBInspectable open var shadowRad : CGFloat = 0.0 {
        didSet {
            arrangeViews()
        }
    }
    @IBInspectable open var shadowColor : UIColor = UIColor.clear {
        didSet {
            arrangeViews()
        }
    }
    @IBInspectable open var cornerRad : CGFloat = 0.0 {
        didSet {
            arrangeViews()
        }
    }
    @IBInspectable open var borderWidth : CGFloat = 0.0 {
        didSet {
            arrangeViews()
        }
    }
    @IBInspectable open var borderColor : UIColor = UIColor.clear {
        didSet {
            arrangeViews()
        }
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        arrangeViews()
    }
    
    private func arrangeViews() {
        self.layer.cornerRadius = cornerRad
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.frame.size = self.bounds.size
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRad).cgPath
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRad
    }
    
    // MARK: Overrides ******************************************
    
    override class var layerClass:AnyClass{
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    
    // MARK: Internal functions *********************************
    
    // Setup the view appearance
    fileprivate func setupView(){
        
        let colors:Array<CGColor> = [startColor.cgColor, endColor.cgColor]
        if isPartial {
            gradientLayer.colors = colors
            if roundness {
                gradientLayer.cornerRadius = gradientLayer.frame.size.height*0.5
            }else {
                gradientLayer.cornerRadius = 0.0
            }
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            if (isHorizontal){
                gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            }else{
                gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            }
            
        }else{
            var colorsArray: [CGColor] = []
            var locationsArray: [NSNumber] = []
            for (index, color) in colors.enumerated() {
                // append same color twice
                colorsArray.append(color)
                colorsArray.append(color)
                locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index)))
                locationsArray.append(NSNumber(value: (1.0 / Double(colors.count)) * Double(index + 1)))
            }
            
            gradientLayer.colors = colorsArray
            gradientLayer.locations = locationsArray
        }
        
        self.setNeedsDisplay()
        
    }
    
    // Helper to return the main layer as CAGradientLayer
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
}
