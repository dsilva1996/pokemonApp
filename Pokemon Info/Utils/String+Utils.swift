//
//  String+Utils.swift
//  Pokemon Info
//
//  Created by Daniel Silva on 04/05/2021.
//

import Foundation
import UIKit

extension String {
    
    
    func getImageFromURL() -> UIImage? {
        
        var image: UIImage? = UIImage()
        
        if let url = URL(string: self) {
         
             if let data = try? Data(contentsOf: url) {
                 
                image = UIImage(data: data)
             }
        }
        
        return image
    }
}
