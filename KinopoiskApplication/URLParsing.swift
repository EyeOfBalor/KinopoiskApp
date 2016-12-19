//
//  URLParsing.swift
//  KinopoiskApplication
//
//  Created by Анонимко on 19/12/16.
//  Copyright © 2016 Not exist. All rights reserved.
//

import Foundation
import Kanna

func displayURL(){
    let myURLAdress = "https://www.kinopoisk.ru/film/9028/" // Случайно выбранный фильм
    let myURL = URL(string: myURLAdress)
    let URLTask = URLSession.shared.dataTask(with: myURL!, completionHandler: {
        myData, response, error in
        
        guard error == nil else {return}
        
        let myHTMLString = String(data: myData!, encoding: String.Encoding.windowsCP1251) //
        
        
        if let doc = HTML(html: myHTMLString!, encoding: .windowsCP1251) {
            
            // Search for nodes by XPath
            for link in doc.xpath("//h1[@itemprop='name']") {
                print(link.text)
                //print(link["href"])
            }
            for link in doc.xpath("//li[@itemprop='actors']") {
                print(link.text)
                //print(link["href"])
            }
            for link in doc.xpath("//div[@itemprop='description']") {
                print(link.text)
                //print(link["href"])
            }
            for link in doc.xpath("//div/a/img[@itemprop='image']/@src") {
                print(link.text)
                //print(link["href"])
            }
        }
    })
    URLTask.resume()
    
}
