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

// Получение всей информации о фильме
func getAllInfoAboutFilm(FilmURLAdress: String) -> (name: String,description: String,imageURL: String,actors: [String]){
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

// Получение списка из названий жанров и ссылок на них
func getAllGenres(navigatorURL: String) -> [(name: String,URL: String)]{
    let HTMLString = getHTMLByURL(URLAdress: navigatorURL) // Страница с поиском по фильмам в прокате
    
    var genresNameAndURL: [(String,String)] = []
    var tempGenre : (name: String,URL: String)
    
    if let doc = HTML(html: HTMLString, encoding: .windowsCP1251){
        for link in doc.xpath("//div[@class='genresNav']/table/tr/td/ul/li/a/@href"){
            tempGenre.URL = link.text!
            tempGenre.name = (link.parent?.text)!
            genresNameAndURL.append(tempGenre)
        }
    }
    
    return genresNameAndURL
}

// Расширение для String для упрощения работы с регулярными выражениями
extension String{
    
    // Возвращает список всех совпадений с паттерном в строке
    func matches(pattern regex: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    // Возвращает список всех групп записи данного совпадения
    func captureGroups(for match: NSTextCheckingResult) -> [String] {
        
        let NSText = self as NSString
        var result = [String]()
        for index in 1..<match.numberOfRanges{
            result.append(NSText.substring(with: match.rangeAt(index)))
        }
        return result
    }
}

extension NSTextCheckingResult{
    
    // Возвращает список всех групп записи данного совпадения
    func captureGroups(in text: String) -> [String] {
        
        let NSText = text as NSString
        var result = [String]()
        for index in 1..<self.numberOfRanges{
            result.append(NSText.substring(with: self.rangeAt(index)))
        }
        return result
    }
}
