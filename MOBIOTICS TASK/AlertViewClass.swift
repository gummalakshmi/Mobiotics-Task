//
//  AlertViewClass.swift
//  SwatchhBharat
//
//  Created by Venky Peddineni on 12/12/17.
//  Copyright © 2017 Nadboy Technology Pvt.Ltd. All rights reserved.
//

import UIKit

class AlertViewClass: NSObject {
    
    weak var isDelegate : AlertViewClassDelegate?
    class func alertControllerWithTitle(title:String, message:String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alerAction:UIAlertAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        controller.addAction(alerAction)
        UIApplication.shared.delegate?.window??.rootViewController?.present(controller, animated: true, completion: nil)
    }
    
    
    func showAlert(withButtons:[String],withTitle:String,withMessage:String){
        let controller = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
        let cancelAction:UIAlertAction = UIAlertAction.init(title:withButtons[0], style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        let doneAction:UIAlertAction = UIAlertAction.init(title: withButtons[1], style: .default) { (doneAction) in
            
            self.isDelegate?.buttonClickedWith(senderTag:1)
        }
        controller.addAction(doneAction)
        UIApplication.shared.delegate?.window??.rootViewController?.present(controller, animated: true, completion: nil)
        
    }
    
}

protocol AlertViewClassDelegate :class{
    func buttonClickedWith(senderTag:Int)
}
