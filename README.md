# AsherElgar---MyMeals

requires:

pod install

also unlock the libary AARatingBar and use the automatic fix for fixing the problem

  
    /// AARatingBar rating tap gesture
    var ratingTapGesture: UITapGestureRecognizer  {
        get {
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(didTapped(_:)))
            tapGesture.numberOfTapsRequired = 1
            return tapGesture
        }
    }
