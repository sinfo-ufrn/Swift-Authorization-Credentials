//
//  AcessoToken.swift
//  autenticador
//
//  Created by Dennis da Silva Nunes on 29/09/2017.
//  Copyright © 2017 Sinfo. All rights reserved.
//

import UIKit
import WebKit

protocol AcessoTokenDelegate {
    func resultadoRequisicao(token:SinfoToken)
}

class AcessoToken: NSObject,WKNavigationDelegate {
    
    var clientId:String
    var clientSecret:String
    var webView:WKWebView
    var delegate:AcessoTokenDelegate
    
    init(clientId:String,clientSecret:String,webView:WKWebView,delegate:AcessoTokenDelegate) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.webView = webView
        self.delegate = delegate
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        if let currentURL = webView.url?.absoluteString {
            if currentURL.contains("code") {
                let code = currentURL.components(separatedBy: "code=")[1]
                pegarToken(comCodigo: code)
            }
        }
    }
    
    func requisitarToken(){
        pegarCodigo()
    }
    
    func pegarCodigo(){
        let responseType = "code"
        let redirectUri = URL(string: "https://api.ufrn.br")!
        let url = URL(string: "https://autenticacao-sustentacao.info.ufrn.br/authz-server/oauth/authorize?client_id=\(clientId)&response_type=\(responseType)&redirect_uri=\(redirectUri)")!
        let request = URLRequest(url: url)
        webView.navigationDelegate = self
        webView.load(request)
    }
    
    func pegarToken(comCodigo codigo:String){
        let redirectUri = URL(string: "https://api.ufrn.br")!
        let grantType = "authorization_code"
        let url = URL(string: "https://autenticacao-sustentacao.info.ufrn.br/authz-server/oauth/token?client_id=\(clientId)&client_secret=\(clientSecret)&redirect_uri=\(redirectUri)&grant_type=\(grantType)&code=\(codigo)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            let decoder = JSONDecoder()
            do{
                let sinfoToken = try decoder.decode(SinfoToken.self, from: data!)
                self.delegate.resultadoRequisicao(token: sinfoToken)
            }catch{
                print("Erro ao tentar criar struct SinfoToken")
                print(error.localizedDescription)
            }
        })
        dataTask.resume()
    }
    
}
