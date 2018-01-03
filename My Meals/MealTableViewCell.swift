//
//  MealTableViewCell.swift
//  My Meals
//
//  Created by Asher Elgar on 03/01/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

import UIKit
import AARatingBar

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var mealImage: UIImageView!
    
    @IBOutlet weak var nameMAel: UILabel!
    @IBOutlet weak var rating: AARatingBar!
}
