import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordStackView: UIStackView!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var loginStackView: UIStackView!
    
    var alertControler: UIAlertController!

    
    override func viewDidLoad() {
        super .viewDidLoad()

        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertControler = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        alertControler.addAction(cancelAction)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification,object: nil )
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification,object: nil )
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange(notification:)), name: UIDevice.orientationDidChangeNotification,object: nil )
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil )
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil )
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil )
    }
    
    @IBAction func loginButton(_ sender: UIButton) {

            
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let login = loginTextField.text?.lowercased() else { return false}
        guard let password = passwordTextField.text else { return false}
        if (isLoginCredentialsCorrect(login: login, password: password)){
            return true
        }else{
            passwordTextField.text = ""
            return false
        }
        }

    func isLoginCredentialsCorrect(login:String, password: String)->Bool{
        guard login == "admin" else {
            showAllert(title: "Ошибка авторизации", message: "Неправильный логин")
            return false
        }
        guard password == "123" else {
            showAllert(title: "Ошибка авторизации", message: "Неправильный пароль")
            return false
        }
        return true
    }
    
    func showAllert(title: String, message: String){
        alertControler.title = title
        alertControler.message = message
        self.present(alertControler, animated: true, completion: nil)
    }
    
    @objc func hideKeyboard(){
        self.scrollView?.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.size.height, right: 0)
        scrollView.contentInset = insets
    }
    
    @objc func keyboardWillHide(notification: Notification){
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
    }
    
    @objc func orientationDidChange(notification: Notification){
        //guard let orientation = notification.userInfo?[UIDevice.current.orientation] else {return};

        if UIDevice.current.orientation.isLandscape{
            passwordStackView.axis = .horizontal
            loginStackView.axis = .horizontal
            buttonsStackView.axis = .horizontal
        }else{
            passwordStackView.axis = .vertical
            loginStackView.axis = .vertical
            buttonsStackView.axis = .vertical
        }
    }
    
}
