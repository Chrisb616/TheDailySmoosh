//
//  ArticleListViewController.swift
//  TheDailySmoosh
//
//  Created by Christopher Boynton on 12/20/16.
//  Copyright © 2016 Christopher. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        NewsAPIClient.cnnDataPull { (articles) in
            var news = Smoosher.smooshNews(articles)
            
            var shouldContinue = true
            
            while shouldContinue {
                if articles[news.article] == nil {
                    shouldContinue = false
                } else {
                    news = Smoosher.smooshNews(articles)
                }
            }
            
            dump(news)
        }
        NewsAPIClient.newYorkerDataPull { (articles) in
            var news = Smoosher.smooshNews(articles)
            
            var shouldContinue = true
            
            while shouldContinue {
                if articles[news.article] == nil {
                    shouldContinue = false
                } else {
                    news = Smoosher.smooshNews(articles)
                }
            }
            
            dump(news)
        }
        NewsAPIClient.bbcDataPull { (articles) in
            var news = Smoosher.smooshNews(articles)
            
            var shouldContinue = true
            
            while shouldContinue {
                if articles[news.article] == nil {
                    shouldContinue = false
                } else {
                    news = Smoosher.smooshNews(articles)
                }
            }
            
            dump(news)
        }
        NewsAPIClient.starDataPull { (articles) in
            var news = Smoosher.smooshNews(articles)
            
            var shouldContinue = true
            
            while shouldContinue {
                if articles[news.article] == nil {
                    shouldContinue = false
                } else {
                    news = Smoosher.smooshNews(articles)
                }
            }
            
            dump(news)
        }
    }

}
