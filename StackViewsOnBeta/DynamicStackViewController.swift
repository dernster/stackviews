//
//  DynamicStackViewController.swift
//  StackViewsOnBeta
//
//  Created by Diego Ernst on 11/5/15.
//  Copyright © 2015 Diego Ernst. All rights reserved.
//

import UIKit

class DynamicStackViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    enum Constants{
        static let animationDuration = 0.5
    }
    
    lazy var itemHeight : CGFloat = { [unowned self] in
        return self.stackView.arrangedSubviews.last!.bounds.height
    }()
    
    lazy var addItemButton : UIButton = { [unowned self] in
        return self.stackView.arrangedSubviews.last! as! UIButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Dynamic insert"
        let button = stackView.arrangedSubviews.first! as! UIButton
        button.addTarget(self, action: "addItem", forControlEvents: .TouchDown)
        
        for _ in 1...7{
            addItem()
        }
    }
    
    func addItem(){
        
        let newButton : UIButton = {
            let button = UIButton(type: .System)
            button.setTitle("Delete me!", forState: .Normal)
            button.addTarget(self, action: "deleteItem:", forControlEvents: .TouchDown)
            button.alpha = 0.0
            button.hidden = true
            return button
        }()
        
        let index = stackView.arrangedSubviews.count - 1
        stackView.insertArrangedSubview(newButton, atIndex: index)
        
        UIView.animateWithDuration(Constants.animationDuration) {
            newButton.alpha = 1
            newButton.hidden = false
            
            self.scrollView.contentOffset.y += self.addItemButton.bounds.size.height
        }
    }
    
    func deleteItem(button : UIButton){
        
        UIView.animateWithDuration(Constants.animationDuration, animations: {
            
                button.alpha = 0
                button.hidden = true
            
            }, completion: { _ in
                
                button.removeFromSuperview()
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
