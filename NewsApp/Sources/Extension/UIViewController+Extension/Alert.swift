import UIKit

extension UIViewController {
    func showAlert(_ alertText: String, _ alertMessage: String? = nil) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
