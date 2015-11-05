//
//  ViewController.swift
//  StackViewsOnBeta
//
//  Created by Diego Ernst on 11/4/15.
//  Copyright © 2015 Diego Ernst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var chartsStack: UIStackView!
    @IBOutlet weak var outerStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Nested stacks"
        
        for stackView in chartsStack.arrangedSubviews as! [UIStackView]{
            let doubleTap = UITapGestureRecognizer(target: self, action: "doubleTap:")
            doubleTap.numberOfTapsRequired = 2
            stackView.addGestureRecognizer(doubleTap)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        for stackView in chartsStack.arrangedSubviews as! [UIStackView]{
            stackView.arrangedSubviews[1].hidden = true
            stackView.arrangedSubviews[1].alpha = 0
        }
    }
    
    func doubleTap(gesture: UITapGestureRecognizer){
        if let innerStack = gesture.view as? UIStackView{
            animateStackChart(innerStack, duration: 0.3, startFrom: 0.0)
        }
    }
    
    func animateStackChart(stack: UIStackView, duration: Double, startFrom: Double){
        UIView.animateWithDuration(duration, delay: startFrom, options: .CurveLinear, animations: {
            stack.arrangedSubviews[1].hidden = !stack.arrangedSubviews[1].hidden
            stack.arrangedSubviews[1].alpha = 1 - stack.arrangedSubviews[1].alpha
        }, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        for stackView in chartsStack.arrangedSubviews as! [UIStackView]{
            animateStackChart(stackView, duration: 0.8, startFrom: 0.3)
        }
    }


}

