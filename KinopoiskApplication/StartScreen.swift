//
//  StartScreen.swift
//  KinopoiskApplication
//
//  Created by Danil on 07/01/17.
//  Copyright © 2017 Not exist. All rights reserved.
//

import UIKit

class StartScreen: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Кнопка отправляющая на страницу с поиском и фильтрами
        let searchButton = UIButton(type: UIButtonType.system)
        searchButton.setTitle("Искать", for: UIControlState.normal)
        stackView.addArrangedSubview(searchButton)
        
        for _ in 0..<3 {
            createViewElement(name: "Кнопка")
        }
        // Do any additional setup after loading the view.
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func createViewElement(name: String) -> () {
        
        let button = UIButton(type: UIButtonType.system)
        button.setTitle(name, for: UIControlState.normal)
        stackView.addArrangedSubview(button)
    }

}
