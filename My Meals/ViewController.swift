//
//  ViewController.swift
//  My Meals
//
//  Created by Asher Elgar on 03/01/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

import UIKit
import AARatingBar
import Firebase


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {

    @IBOutlet weak var rating: AARatingBar!
    @IBOutlet weak var nameMeal: UITextField!
    @IBOutlet weak var imageMeal: UIImageView!
  
    var data = Database.database()
    
     var newMeal2: Meal?
   
    
    let tapRec = UITapGestureRecognizer()
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameMeal.delegate  = self
     
        imagePicker.delegate = self
        
        tapRec.addTarget(self, action: #selector(addAlert))
        imageMeal.addGestureRecognizer(tapRec)
        
        imageMeal.isUserInteractionEnabled = true
    
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func changeImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageMeal.image = image
        dismiss(animated:true, completion: nil)
    }
    
    
    @objc func addAlert(){
            let alertController = UIAlertController(title: "Choose", message: "Camera or Libary", preferredStyle: .alert)
            
        let defaultAction = UIAlertAction(title: "Camera", style: .default) { (ok) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                var imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        let cAction = UIAlertAction(title: "Libary", style: .cancel) { (ok) in
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            
            self.present(self.imagePicker, animated: true, completion: nil)
        }
            alertController.addAction(defaultAction)
        alertController.addAction(cAction)
            
            present(alertController, animated: true, completion: nil)
            // Do any additional setup after loading the view, typically from a nib.
       
    }
   
  
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        
//        let userImage:UIImage = imageMeal.image!
//        let imageData:NSData = UIImagePNGRepresentation(userImage)! as NSData
//        let dataImage = imageData.base64EncodedString(options: .lineLength64Characters)
        
        
        if nameMeal.text == ""{
            let alertController = UIAlertController(title: "Error", message: "You must fill", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        
        let image = imageMeal.image
        let rate = rating.value
        let name = nameMeal.text ?? ""
        
        newMeal2 = Meal(title: name, image: image, rating: rate)

    performSegue(withIdentifier: "saveToTable", sender: newMeal)

    }

   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? Your_MealsTableViewController{
            
            guard let meal = newMeal2 else{return}

            newMeal.append(meal)
            

        }

    }



}
