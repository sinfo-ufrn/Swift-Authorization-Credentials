# Swift-Authorization-Credentials
Esse exemplo foi criado de modo a fornecer um código simples, fácil de usar e editar.

# Como usar Client Credentials
Esse fluxo foi implementado para ser usado por aplicações que queiram acessar os dados públicos dos sistemas da SINFO, tais como eventos, notícias, telefones, entre outros. Deste modo, aplicações que possuem esse fim devem seguir os passos abaixo:

Para se criar uma aplicação que use o "Client Credentials", é necessário criar um objeto "AcessoCredenciais" passando seu ClientId, ClientSecret e o controlador que contenha o protocolo "AcessoCredenciaisDelegate". Chame o método "requisitarCredenciais" para que a requisição seja iniciada.
Ex:
```
class ViewController: UIViewController,AcessoCredenciaisDelegate {
    
    var acessCred:AcessoCredenciais!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cId = "AppID"
        let cSt = "AppSecret"
        //
        acessCred = AcessoCredenciais(clientId: cId, clientSecret: cSt, delegate: self)
        acessCred.requisitarCredenciais()
    }
}
```
Em seguida crie o método de onde as suas credenciais retornarão, esse é um método do "AcessoCredenciaisDelegate".
Ex:
```
func resultadoRequisicao(token: SinfoToken) {
}
```
Com o método criado, pegue os dados que retornam no SinfoToken.
Ex:
```
func resultadoRequisicao(token: SinfoToken) {
        print(token.accessToken)
        print(token.expiresIn)
        print(token.scope)
        print(token.tokenType)
}
```
# Como usar Authorization Code
Esse fluxo deve ser utilizado por aplicações que queiram acessar as informações privadas das contas de usuários dos sistemas SINFO, como por exemplo: turmas de um usuário, frequências de um discente, histórico de utilização de um usuário no restaurante universitário, etc. Assim, aplicações com esse propósito precisam seguir os passos abaixo:

Para se criar uma aplicação que use o "Authorization Code", deve se criar um controlador com uma WKWebView nele, importando o "WebKit" da Apple.
Ex:
```
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
}
```
Em seguida crie um objeto "AcessoToken" passando seu ClientId, ClientSecret, WKWebView e um controlador que contenha o protocolo "AcessoTokenDelegate". Chame o método "requisitarToken" para que a requisição seja iniciada.
Ex:
```
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
}
```
Em seguida crie o método de onde seu token retornará, esse é um método do "AcessoTokenDelegate".
Ex:
```
func resultadoRequisicao(token: SinfoToken) {
}
```
Com o método criado, pegue os dados que retornam no SinfoToken e descarte o controlador(Exemplo mostra um controlador chamado de maneira modal sendo descartado).
Ex:
```
func resultadoRequisicao(token: SinfoToken) {
        print(token.accessToken)
        print(token.expiresIn)
        print(token.refreshToken)
        print(token.scope)
        print(token.tokenType)
        self.dismiss(animated: true, completion: nil)
}
```
