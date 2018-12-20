//
//  ViewController.swift
//  MOBIOTICS TASK
//
//  Created by Murali on 19/12/18.
//  Copyright © 2018 NadboyTechnology. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet var tableview: UITableView!
    @IBOutlet var searchBarController: UISearchBar!
    
    var names = [String]()
    var lastName = [String]()
    var imageView =  UIImage()
    var filteredData: [String]!
    var imageArray = [String]();
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tappedInView))
        self.view.addGestureRecognizer(tapped)
        searchBarController.delegate = self
       
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "firstName") as! String)
                names.append(data.value(forKey: "firstName") as! String)
                lastName.append(data.value(forKey: "lastName") as! String)
                filteredData = names
                 imageView = UIImage(data: data.value(forKey: "image") as! Data)!
           
            }
        } catch {
            
            print("Failed")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func tappedInView(){
        self.view.endEditing(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @objc func btn_clicked(_ sender: UIBarButtonItem) {
        // Do something
    }
    
    
    
    
    
    
    //MARK : UITableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if filteredData != nil {
        return filteredData.count
        }
      return 0
      
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNameCell") as! MyNameCell
        
        cell.nameLabel.text = filteredData[indexPath.row]
        cell.imgViewProfile?.image = imageView
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75;
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? names : names.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableview.reloadData()
    }
    
    
    @IBAction func clearTxtBtn(_ sender: Any) {
        searchBarController.text =  "";
        filteredData = names
        tableview.reloadData();
        
    }
    

    @IBAction func addContactBtn(_ sender: Any) {
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddContactViewController") as! AddContactViewController
         self.navigationController?.pushViewController(vc, animated: true)
    }
}

