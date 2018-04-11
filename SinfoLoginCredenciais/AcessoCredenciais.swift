//
//  AcessoCredenciais.swift
//  autenticador
//
//  Created by Dennis da Silva Nunes on 29/09/2017.
//  Copyright © 2017 Sinfo. All rights reserved.
//

import Foundation

protocol AcessoCredenciaisDelegate {
    func resultadoRequisicao(token:SinfoToken)
}

class AcessoCredenciais {
    
    var clientId:String
    var clientSecret:String
    var delegate:AcessoCredenciaisDelegate
    
    init(clientId:String,clientSecret:String,delegate:AcessoCredenciaisDelegate) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.delegate = delegate
    }
    
    func requisitarCredenciais(){
        let request = NSMutableURLRequest(url: NSURL(string: "https://autenticacao-sustentacao.info.ufrn.br/authz-server/oauth/token?client_id=\(clientId)&client_secret=\(clientSecret)&grant_type=client_credentials")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
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
