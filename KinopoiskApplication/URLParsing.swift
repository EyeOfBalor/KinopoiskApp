//
//  URLParsing.swift
//  KinopoiskApplication
//
//  Created by Анонимко on 19/12/16.
//  Copyright © 2016 Not exist. All rights reserved.
//

import Foundation
import Kanna

// Возвращает весь HTML указанной страницы
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

func getAllInfoAboutFilm(FilmURLAdress: String) -> (String,String,String,[String]){
    let HTMLString = getHTMLByURL(URLAdress: FilmURLAdress) // Получение html контента страницы
    
    var name = "" // Переменная для названия фильма
    var description = "" // Переменная для названия фильма
    var imageURL = "" // Переменная для ссылки на изображение
    var actors: [String] = [] // Переменная для названия фильма
    
    
    if let doc = HTML(html: HTMLString, encoding: .windowsCP1251) {
        
        for link in doc.xpath("//h1[@itemprop='name']") {
            name = link.text!
        }
        for link in doc.xpath("//div[@itemprop='description']") {
            description = link.text!
        }
        for link in doc.xpath("//div/a/img[@itemprop='image']/@src") {
            imageURL = link.text!
        }
        for link in doc.xpath("//li[@itemprop='actors']") {
            actors.append(link.text!)
        }
    }
    
    return (name,description,imageURL,actors)
}

