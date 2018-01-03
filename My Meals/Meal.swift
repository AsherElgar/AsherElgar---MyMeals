//
//  Meal.swift
//  My Meals
//
//  Created by Asher Elgar on 03/01/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

import UIKit


class Meal: CustomStringConvertible {
    var title:String
    var image:UIImage?
    var rating:CGFloat?
    
    var description: String{
        return title
    }
    
    init(title:String, image:UIImage?, rating:CGFloat) {
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

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
}
