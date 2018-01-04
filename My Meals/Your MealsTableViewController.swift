//
//  Your MealsTableViewController.swift
//  My Meals
//
//  Created by Asher Elgar on 03/01/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

import UIKit
import AARatingBar
import CoreData

//var newMeal = [Meal]()

class Your_MealsTableViewController: UITableViewController {

    
    var newMeal1 = [Meal]()
    
     var coreMeal: [NSManagedObject] = []
    
    var nameMeal:String = ""
    var rating: CGFloat = 0
    var image:UIImage?
    
    var r = AARatingBar()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        tableView.reloadData()
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MealCore")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "mealTitle") as! String)
                print(data.value(forKey: "mealImage") as! Data)
                print(data.value(forKey: "rate") as! CGFloat)
                
               var mealT = data.value(forKey: "mealTitle") as! String
                var mealImg = data.value(forKey: "mealImage") as! Data
                var mealR = data.value(forKey: "rate") as! CGFloat

                var img = UIImage(data: mealImg as! Data)

                newMeal1.append(Meal(title: mealT, image: img, rating: mealR))
                coreMeal.append(data)
                
            }
            tableView.reloadData()
            
        } catch {
            
            print("Failed")
        }
        
        self.navigationItem.hidesBackButton = true
       
        r.isEnabled = false


        navigationItem.leftBarButtonItem = editButtonItem
        
        
        var i = 0
        if newMeal1.count == 0{
            
        let sampleMeal = Meal(title: "Cannellini Bruschetta", image: #imageLiteral(resourceName: "meal"), rating: 3.0)
            newMeal1 = [sampleMeal]
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
        return newMeal1.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath)  as! MealTableViewCell
        
        

        let meals = newMeal1[indexPath.row]
        
       
//        var img = MealCore.value(forKeyPath: "mealImage") as? Data
//        var ti = MealCore.value(forKeyPath: "mealTitle") as? String
//        var ra = MealCore.value(forKeyPath: "rate") as? CGFloat
//
//        
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
       
      
            let noteEntity = "MealCore" //Entity Name
            
            let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let note = coreMeal[indexPath.row]
            
            if editingStyle == .delete {
                newMeal1.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

                managedContext.delete(note)
                
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print("Error While Deleting Note: \(error.userInfo)")
                }
                
            }
            
            //Code to Fetch New Data From The DB and Reload Table.
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)
            
            do {
                coreMeal = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            } catch let error as NSError {
                print("Error While Fetching Data From DB: \(error.userInfo)")
            }
            tableView.reloadData()
       
    }
 
  
    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0) )
        
        var decodedimage = UIImage(data: decodedData! as Data)
        
        return decodedimage!
        
    }
    
}
