//
//  APIClient.swift
//  TheDailySmoosh
//
//  Created by Christopher Boynton on 12/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import Foundation

class NewsAPIClient {
    
    private init() {}
    static func bbcDataPull (completion: @escaping ([String:String]) -> Void ) {
        
        guard let url = URL(string: "http://feeds.bbci.co.uk/news/rss.xml?edition=uk") else { print("FAILURE: URL could not be created"); return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("FAILURE: Data could not be unwrapped"); return }
            
            guard let xmlString = String(data: unwrappedData, encoding: .utf8) else { print("FAILURE: Could not retieve XML String"); return }
            
            let firstLevelUnwrap = xmlString.components(separatedBy: "<title><![CDATA[")
            
            var titleAndArticle = [String]()
            
            for string in firstLevelUnwrap {
                titleAndArticle.append(string.components(separatedBy: "]]></description>")[0])
            }
            
            
            var results = [String:String]()
            
            for title in titleAndArticle {
                if title.contains("]]></title>\n            <description><![CDATA[") {
                    let split = title.components(separatedBy: "]]></title>\n            <description><![CDATA[")
                    
                    results[split[0]] = split[1]
                }
            }
            
            results["BBC News - Home"] = nil
            
            completion(results)
            
        }
        
        task.resume()
    }
    
    static func cnnDataPull (completion: @escaping ([String:String]) -> Void ) {
        
        guard let url = URL(string: "http://rss.cnn.com/rss/cnn_topstories.rss") else { print("FAILURE: URL could not be created"); return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("FAILURE: Data could not be unwrapped"); return }
            
            guard let xmlString = String(data: unwrappedData, encoding: .utf8) else { print("FAILURE: Could not retieve XML String"); return }
            
            let firstLevelUnwrap = xmlString.components(separatedBy: "<![CDATA[")
            
            var titleAndArticle = [String]()
            
            for string in firstLevelUnwrap {
                titleAndArticle.append(string.components(separatedBy: "&lt;")[0])
            }
            
            var results = [String:String]()
            
            for title in titleAndArticle {
                if title.contains("]]></title><description>") {
                    let split = title.components(separatedBy: "]]></title><description>")
                    
                    results[split[0]] = split[1]
                }
            }
            
            results["CNN.com - RSS Channel - Mobile App Manual"] = nil
            
            completion(results)
            
        }
        
        task.resume()
    }
    
    static func newYorkerDataPull(completion: @escaping ([String:String]) -> Void) {
        
        guard let url = URL(string: "http://www.newyorker.com/feed/everything") else { print("FAILURE: URL could not be created"); return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("FAILURE: Data could not be unwrapped"); return }
            
            guard let xmlString = String(data: unwrappedData, encoding: .utf8) else { print("FAILURE: Could not retieve XML String"); return }
            
            let firstLevelUnwrap = xmlString.components(separatedBy: "<title>")
            
            var titleAndArticle = [String]()
            
            for string in firstLevelUnwrap {
                titleAndArticle.append(string.components(separatedBy: "</p>]]></description>")[0])
            }
            
            var results = [String:String]()
            
            for title in titleAndArticle {
                if title.contains("</title>") {
                    let split = title.components(separatedBy: "</title>")
                    let otherSplit = split[1].components(separatedBy: "<p>")
                    
                    var headline = String()
                    var article = String()
                    
                    if otherSplit.count > 1 {
                        let tempHeadline = split[0]
                        let tempArticle = otherSplit[1]
                        
                        for (index, removeFirstTag) in tempHeadline.components(separatedBy: "<").enumerated() {
                            if index == 0 {
                                headline += removeFirstTag
                            }
                            for (index, word) in removeFirstTag.components(separatedBy: ">").enumerated() {
                                if index == 1 {
                                    headline += word
                                }
                            }
                        }
                        
                        for (index, removeFirstTag) in tempArticle.components(separatedBy: "<").enumerated() {
                            if index == 0 {
                                article += removeFirstTag
                            }
                            for (index, word) in removeFirstTag.components(separatedBy: ">").enumerated() {
                                if index == 1 {
                                    article += word
                                }
                            }
                        }
                        
                        results[headline] = article
                    }
                }
            }
            
            results[""] = nil
            
            completion(results)
            
        }
        task.resume()
    }
    static func starDataPull(completion: @escaping ([String:String]) -> Void) {
        
        guard let url = URL(string: "http://www.star-magazine.co.uk/rss/all") else { print("FAILURE: URL could not be created"); return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let unwrappedData = data else { print("FAILURE: Data could not be unwrapped"); return }
            
            guard let xmlString = String(data: unwrappedData, encoding: .utf8) else { print("FAILURE: Could not retieve XML String"); return }
            
            let firstLevelUnwrap = xmlString.components(separatedBy: "<title>\n")
            
            var titleAndArticle = [String]()
            
            for string in firstLevelUnwrap {
                titleAndArticle.append(string.components(separatedBy: " ...\n]]>\n\n\n</p>]]></description>")[0])
            }
            
            var results = [String:String]()
            
            for title in titleAndArticle {
                if title.contains("</title>") {
                    let split = title.components(separatedBy: "</title>")
                    let otherSplit = split[1].components(separatedBy: "<br/>")
                    
                    var headline = String()
                    var article = String()
                    
                    if otherSplit.count > 1 {
                        let tempHeadline = split[0]
                        let tempArticle = otherSplit[1]
                        
                        for (index, removeFirstTag) in tempHeadline.components(separatedBy: "<").enumerated() {
                            if index == 0 {
                                headline += removeFirstTag
                            }
                            for (index, word) in removeFirstTag.components(separatedBy: ">").enumerated() {
                                if index == 1 {
                                    headline += word
                                }
                            }
                        }
                        
                        for (index, removeFirstTag) in tempArticle.components(separatedBy: "<").enumerated() {
                            if index == 0 {
                                article += removeFirstTag
                            }
                            for (index, word) in removeFirstTag.components(separatedBy: ">").enumerated() {
                                if index == 1 {
                                    article += word
                                }
                            }
                        }
                        
                        results[headline] = article
                    }
                }
            }
            
            results[""] = nil
            
            completion(results)
            
        }
        task.resume()
    }
    
}
