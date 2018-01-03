//
//  Your MealsTableViewController.swift
//  My Meals
//
//  Created by Asher Elgar on 03/01/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

import UIKit
import AARatingBar


 var newMeal = [Meal]()
class Your_MealsTableViewController: UITableViewController {

    
    
    var nameMeal:String = ""
    var rating: CGFloat = 0
    var image:UIImage?
    
    var r = AARatingBar()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
       
        r.isEnabled = false


        navigationItem.leftBarButtonItem = editButtonItem
        
        
        var i = 0
        if newMeal.count == 0{
            
        let sampleMeal = Meal(title: "Cannellini Bruschetta", image: #imageLiteral(resourceName: "meal"), rating: 3)
            newMeal = [sampleMeal]
            i+=1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newMeal.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath)  as! MealTableViewCell
        
        

        let meals = newMeal[indexPath.row]
        
       
        
        cell.nameMAel.text = meals.title
        cell.rating.value = meals.rating!
        cell.mealImage.image = meals.image
    
        cell.rating.isEnabled = false

        return cell
    }
  

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        newMeal.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
 
  
    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        
        var decodedimage = UIImage(data: decodedData! as Data)
        
        return decodedimage!
        
    }
    
}
