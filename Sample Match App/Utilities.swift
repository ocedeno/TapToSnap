import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }

    public class var providedPink: UIColor {
        UIColor(hex: "#FF00A9") ?? .systemPink
    }

    public class var providedPinkDark: UIColor {
        UIColor(hex: "#AD1078") ?? .systemIndigo
    }

    public class var providedGradientTop: UIColor {
        UIColor(hex: "#1395B7") ?? .systemBlue
    }

    public class var providedGradientBottom: UIColor {
        UIColor(hex: "#541177") ?? .systemPurple
    }

    public class var providedBgGray: UIColor {
        UIColor(hex: "#302236") ?? .systemGray
    }

    public class var providedBgGrayDark: UIColor {
        UIColor(hex: "#271C2B") ?? .systemGray4
    }

    public class var providedTileGray: UIColor {
        UIColor(hex: "#584D5D") ?? .systemGray
    }

    public class var providedTileGrayDark: UIColor {
        UIColor(hex: "#473C4D") ?? .systemGray4
    }

    public class var providedGreen: UIColor {
        UIColor(hex: "#8BF388") ?? .systemGreen
    }

    public class var providedRed: UIColor {
        UIColor(hex: "#FF4545") ?? .systemRed
    }

    public class var providedWhite: UIColor {
        UIColor(hex: "#FF00A9") ?? .white
    }
}

extension UIFont {
    public class var providedKarlaLargeFont : UIFont {
        UIFont(name: "Karla-Regular", size: 48) ?? .systemFont(ofSize: 48)
    }

    public class var providedKarlaMediumFont : UIFont {
        UIFont(name: "Karla-Regular", size: 28) ?? .systemFont(ofSize: 28)
    }

    public class var providedKarlaSmallFont : UIFont {
        UIFont(name: "Karla-Regular", size: 24) ?? .systemFont(ofSize: 24)
    }

    public class var providedKarlaExtraSmallFont : UIFont {
        UIFont(name: "Karla-Regular", size: 14) ?? .systemFont(ofSize: 14)
    }
}
