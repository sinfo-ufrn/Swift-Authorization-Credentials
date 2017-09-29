//
//  ViewController.swift
//  SinfoLoginCredenciais
//
//  Created by Dennis da Silva Nunes on 29/09/2017.
//  Copyright © 2017 Sinfo. All rights reserved.
//

import UIKit

class ViewController: UIViewController,AcessoCredenciaisDelegate {
    
    var acessCred:AcessoCredenciais!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func PegarCredenciais(_ sender: UIButton) {
        let cId = ""
        let cSt = ""
        //
        acessCred = AcessoCredenciais(clientId: cId, clientSecret: cSt, delegate: self)
        acessCred.requisitarCredenciais()
    }
    
    func resultadoRequisicao(token: SinfoToken) {
        print(token)
    }
    
}

