//
//  DropDownListTableView.swift
//  Created by NADBOY TECHNOLOGIES on 28/10/17.
//  Copyright © 2017 Nadboy Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class DropDownListTableView: UITableView,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    var numberOfRows:NSArray = [];
    var tableviewP : DropDownListTableView!
    var naneArray  =  [String] ()
    var activeTF: UITextField?

    func setFrameWith(textField:UITextField, arryElements : NSArray){
        var frame : CGRect = textField.frame
        frame.origin.y = frame.origin.y + frame.size.height;
        frame.size.height = CGFloat((arryElements.count > 5 ? 5*25:arryElements.count * 25));
        numberOfRows = arryElements;
        self.frame = frame;
        self.dataSource = self;
        self.reloadData();
    }
    
    func setFrameAndReload(textField:UITextField, arryElements : NSArray){
        var frame : CGRect = textField.frame
        frame.origin.y = frame.origin.y + frame.size.height;
        frame.size.height = CGFloat((arryElements.count > 5 ? 5*25:arryElements.count * 25));
        numberOfRows = arryElements;
        self.frame = frame;
        self.dataSource = self;
        self.reloadData();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return numberOfRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = numberOfRows.object(at: indexPath.row) as? String
        cell.layer.borderWidth = 0.5
       
        cell.selectionStyle = .none
        //cell.separatorStyle = .none
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 12.0)
       // cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell;
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        activeTF?.text = naneArray[indexPath.row]
        activeTF?.textAlignment = .right
        tableviewP.isHidden = true
    }
}
