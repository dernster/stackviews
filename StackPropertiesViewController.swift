//
//  StackPropertiesViewController.swift
//  StackViewsOnBeta
//
//  Created by Diego Ernst on 11/6/15.
//  Copyright © 2015 Diego Ernst. All rights reserved.
//

import UIKit

extension UIStackViewAlignment{
    var description : String{
        switch self{
        case .Center:
            return "Center"
        case .Fill:
            return "Fill"
        case .FirstBaseline:
            return "First Baseline"
        case .LastBaseline:
            return "Last Baseline"
        case .Leading:
            return "Leading"
        case .Trailing:
            return "Trailing"
        }
    }
}

extension UIStackViewDistribution{
    var description : String{
        switch self{
        case .EqualCentering:
            return "Equal Centering"
        case .EqualSpacing:
            return "Equal Spacing"
        case .Fill:
            return "Fill"
        case .FillEqually:
            return "Fill Equally"
        case .FillProportionally:
            return "Fill Proportionally"
        }
    }
}

class StackPropertiesViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var alignmentPicker: UIPickerView!
    @IBOutlet weak var distributionPicker: UIPickerView!
    
    var alignment : [UIStackViewAlignment] {
        if stackView.axis == .Horizontal{
            return [.Fill,.Center,.Leading,.Trailing,.FirstBaseline,.LastBaseline]
        }else{
            return [.Fill,.Center,.Leading,.Trailing]
        }
    }
    
    var distribution : [UIStackViewDistribution] = [.Fill,.FillEqually,.FillProportionally,.EqualCentering,.EqualSpacing]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Properties"
        alignmentPicker.dataSource = self
        alignmentPicker.delegate = self
        distributionPicker.dataSource = self
        distributionPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAlignment(alignment : UIStackViewAlignment){
        UIView.animateWithDuration(0.7) {
            self.stackView.alignment = alignment
        }
    }
    
    func setDistribution(distribution : UIStackViewDistribution){
        UIView.animateWithDuration(0.7) {
            self.stackView.distribution = distribution
        }
    }

    
    @IBAction func axisChanged(sender: UISegmentedControl) {
        UIView.animateWithDuration(0.7, animations: {
            
            if sender.selectedSegmentIndex == 0{
                self.stackView.axis = .Horizontal
            }else{
                self.stackView.axis = .Vertical
            }
        }, completion: { _ in
            self.alignmentPicker.reloadAllComponents()
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension StackPropertiesViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerView == alignmentPicker ? alignment.count : distribution.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return pickerView == alignmentPicker ? alignment[row].description : distribution[row].description
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == alignmentPicker{
            self.setAlignment(alignment[row])
        }else{
            self.setDistribution(distribution[row])
        }
    }
}
