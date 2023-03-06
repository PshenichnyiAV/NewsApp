import Foundation

extension String {
    func link() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.link, value: self, range: NSRange(location: 0, length: self.count))
        
        return attributedString
    }
}
