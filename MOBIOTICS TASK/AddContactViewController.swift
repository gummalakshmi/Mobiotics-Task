//
//  AddContactViewController.swift
//  MOBIOTICS TASK
//
//  Created by Murali on 19/12/18.
//  Copyright © 2018 NadboyTechnology. All rights reserved.
//

import UIKit
import CoreData
class AddContactViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate, UITableViewDelegate {

    @IBOutlet var fristNameTxtFd: kTextFiledPlaceHolder!
    @IBOutlet var lastNameTxtFd: kTextFiledPlaceHolder!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var gmailTxtFd: kTextFiledPlaceHolder!
    @IBOutlet var phonetxtFd: kTextFiledPlaceHolder!
    @IBOutlet var areaNametxtFd: kTextFiledPlaceHolder!
    var activeTF: UITextField?
    
     var tableviewDropDown : DropDownListTableView!
    var selectAryNames = [String]()
    var capital = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let tapped = UITapGestureRecognizer(target: self, action: #selector(tappedInView))
        tapped.numberOfTapsRequired = 2;
        self.view.addGestureRecognizer(tapped)
        //   MARK: For Image as Round Shape
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.clipsToBounds = true
        
       // For drop Down table
        tableviewDropDown = DropDownListTableView();
        tableviewDropDown.separatorStyle = UITableViewCellSeparatorStyle.none
        tableviewDropDown.delegate = self
        
        
      serivceCallingForCapital()
    
        
      
    
    
    }
    
    // MARK: - UITextField Method
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.activeTF?.endEditing(true)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeTF = textField
        if textField == areaNametxtFd{
            textField.textAlignment = .center
            tableviewDropDown.setFrameWith(textField: areaNametxtFd, arryElements:self.capital as NSArray)
            self.view.addSubview(tableviewDropDown);
            tableviewDropDown.reloadData()
            tableviewDropDown.isHidden = false
            return false
        }
        return true
    }
    
    
    
    // MARK: - UITableViewDelagate
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if tableView == tableviewDropDown {
            areaNametxtFd.text = self.capital[indexPath.row]
        }
        tableviewDropDown.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tappedInView(){
        self.view.endEditing(true)
        
    }
    
//     For Image Picker
    @IBAction func profilePicSelect(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            picker.sourceType = .camera
            picker.delegate =  self
            
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            picker.sourceType = .photoLibrary
            picker.delegate =  self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = image
            dismiss(animated:true, completion: nil)
        } else{
        }
        
    }

    
//     To Submit Data
    @IBAction func Submit(_ sender: Any) {
        if (fristNameTxtFd.text?.isEmpty)! {
             AlertViewClass.alertControllerWithTitle(title: "Alert", message: "Please First Name")
            } else if   (lastNameTxtFd.text?.isEmpty)!{
             AlertViewClass.alertControllerWithTitle(title: "Alert", message: "Please Fill Last Name")
        } else if (gmailTxtFd.text?.isEmpty)! {
             AlertViewClass.alertControllerWithTitle(title: "Alert", message: "Please Fill all GmailId")
        } else if (areaNametxtFd.text?.isEmpty)!{
            AlertViewClass.alertControllerWithTitle(title: "Alert", message: "Please Fill all Country Code")
        }else if (phonetxtFd.text?.isEmpty)!  {
            AlertViewClass.alertControllerWithTitle(title: "Alert", message: "Please Fill Contact Number ")
        }
        else {
           self.dataValidations()
            if isValidEmail(testStr: gmailTxtFd.text!){
                print("Validate EmailID")
            }
            else{
               AlertViewClass.alertControllerWithTitle(title: "Alert", message: "Please Fill Valid Email id ")
                print("invalide EmailID")
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(fristNameTxtFd.text!, forKey: "firstName")
            newUser.setValue(lastNameTxtFd.text!, forKey: "lastName")
            newUser.setValue(gmailTxtFd.text!, forKey: "gmailID")
            newUser.setValue(phonetxtFd.text!, forKey: "phone")
            newUser.setValue(areaNametxtFd.text!, forKey: "country")
            let dataValue = UIImagePNGRepresentation(profileImageView.image!)
            newUser.setValue(dataValue, forKey: "image")
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
      
        
        
        
      
    }
    
    
    //     For Gmail Validation:
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
    
    
    //MARK:- phone Number  Validations
    func dataValidations()-> Bool{
        let PHONE_REGEX = "^[789]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        if (self.phonetxtFd.text?.count)! < 10{
            AlertViewClass.alertControllerWithTitle(title: "Mobile Number!", message: "Please enter a valid mobile number.")
            return false
        }
        else if phoneTest.evaluate(with: phonetxtFd.text) == false{
            AlertViewClass.alertControllerWithTitle(title: "Mobile Number!", message: "Please enter a valid mobile number.")
            return false
        }
        return true;
    }
    
    
    
    
    // MARK: - UITextfield Delagate Methods
    @objc func mobilenumbervalidating(sender:UITextField){
        if (sender.text?.count)! >= 10 {
            sender.resignFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == phonetxtFd{
            if textField.text?.count == 10{
            }
            else{
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phonetxtFd{
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
        else{
            return true
        }
    }
    
    
//    function
    func serivceCallingForCapital(){
        guard let url = URL(string: "https://restcountries.eu/rest/v1/all")
            else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
             
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                
                for dic in jsonArray{
                    guard let title = dic["alpha2Code"] as? String  else { return }
                    self.capital.append(title)
                 
                }
                //Response result
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
    }

}
