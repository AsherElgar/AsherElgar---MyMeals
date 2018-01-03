//
//  MealtOFire.swift
//  My Meals
//
//  Created by Asher Elgar on 03/01/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

import UIKit


class MealToFire {
    var title:String
    var image:String?
    var rating:String?
    
    init(title:String, image:String?, rating:String) {
        self.title = title
        self.image = image
        self.rating = rating
    }
    
    var json:[String: Any]{
        return [
            "Name": title,
            "Image": image,
            "Rating": rating,
            
        ]
    }
    
}
