//
//  Smoosher.swift
//  TheDailySmoosh
//
//  Created by Christopher Boynton on 12/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import Foundation

class Smoosher {
    
    private init() { }
    
    static func smooshNews(_ dictionary: [String:String]) -> (headline: String, article: String) {
        var headlines = [String]()
        var articles = [String]()
        
        for item in dictionary {
            headlines.append(item.key)
            articles.append(item.value)
        }
        
        let headline = smoosh(headlines)
        let article = smoosh(articles)
        
        return (headline: headline, article: article)
    }
    
    static func smoosh(_ strings: [String]) -> String {
        var completeStrings = [[String]]()
        
        for string in strings {
            completeStrings.append(string.components(separatedBy: " "))
        }
        
        var currentWord = completeStrings.returnRandomElement()[0]
        var resultString = currentWord
        
        var shouldContinue = true
        
        while shouldContinue {
            var wordInstanceIndicies = [(string: Int, word: Int)]()
            
            for (stringIndex, string) in completeStrings.enumerated() {
                for (wordIndex, word) in string.enumerated() {
                    if word == currentWord {
                        let wordInstanceIndex = (string: stringIndex, word: wordIndex)
                        wordInstanceIndicies.append(wordInstanceIndex)
                    }
                }
            }
            
            let chosen = wordInstanceIndicies.returnRandomElement()

            if completeStrings[chosen.string].count - 1 == chosen.word {
                shouldContinue = false
            } else {
                
                currentWord = completeStrings[chosen.string][chosen.word + 1]
                
                resultString += " \(currentWord)"
            }
        }
        
        
        return resultString
    }
    
}
