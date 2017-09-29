//
//  WebViewController.swift
//  SinfoLoginCredenciais
//
//  Created by Dennis da Silva Nunes on 29/09/2017.
//  Copyright © 2017 Sinfo. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,AcessoTokenDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var acessTkn:AcessoToken!
    
    override func loadView() {
        super.loadView()
        let cId = ""
        let cSt = ""
        acessTkn = AcessoToken(clientId: cId, clientSecret: cSt, webView: webView, delegate: self)
        acessTkn.requisitarToken()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func resultadoRequisicao(token:SinfoToken){
        print(token)
        self.dismiss(animated: true, completion: nil)
    }
}
