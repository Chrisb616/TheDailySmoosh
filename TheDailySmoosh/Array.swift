//
//  Array.swift
//  TheDailySmoosh
//
//  Created by Christopher Boynton on 12/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import Foundation

extension Array {
    
    func returnRandomElement() -> Element {
        let rand = Int(arc4random_uniform(UInt32(self.count)))
        
        return self[rand]
    }
    
}
