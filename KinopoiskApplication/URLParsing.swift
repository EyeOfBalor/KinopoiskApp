//
//  URLParsing.swift
//  KinopoiskApplication
//
//  Created by Анонимко on 19/12/16.
//  Copyright © 2016 Not exist. All rights reserved.
//

import Foundation
import Kanna

func getHTMLByURL(URLAdress: String) -> String {
    
   // let myURLAdress = "https://www.kinopoisk.ru/film/9028/" // Случайно выбранный фильм
    let myURL = URL(string: URLAdress)!
    var myHTMLString = ""
    do{
        myHTMLString = try String(contentsOf: myURL, encoding: String.Encoding.windowsCP1251) // Перевод считанной страницы в String
    } catch let error {
    print("Error: \(error)")
    }
    
    return myHTMLString
}
