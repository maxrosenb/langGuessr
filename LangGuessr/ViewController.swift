//
//  ViewController.swift
//  LangGuessr
//
//  Created by Max Rosenberg on 7/19/20.
//  Copyright © 2020 Max Rosenberg. All rights reserved.
//

/*
 Things we need
 - Menu screen
 - Game screen
 - Answer object
 - Question object
 */

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func startGame() {
    let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: true)
  }

}

