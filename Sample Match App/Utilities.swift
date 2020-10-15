import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.currentIndex = String.Index(utf16Offset: 1, in: hexString)
        }
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

    public class var providedPink: UIColor {
        UIColor(hex: "#FF00A9")
    }

    public class var providedPinkDark: UIColor {
        UIColor(hex: "#AD1078")
    }

    public class var providedGradientTop: UIColor {
        UIColor(hex: "#1395B7")
    }

    public class var providedGradientBottom: UIColor {
        UIColor(hex: "#541177")
    }

    public class var providedBgGray: UIColor {
        UIColor(hex: "#302236")
    }

    public class var providedBgGrayDark: UIColor {
        UIColor(hex: "#271C2B")
    }

    public class var providedTileGray: UIColor {
        UIColor(hex: "#584D5D")
    }

    public class var providedTileGrayDark: UIColor {
        UIColor(hex: "#473C4D")
    }

    public class var providedGreen: UIColor {
        UIColor(hex: "#8BF388")
    }

    public class var providedRed: UIColor {
        UIColor(hex: "#FF4545")
    }

    public class var providedWhite: UIColor {
        UIColor(hex: "#FF00A9")
    }

    func createOnePixelImage() -> UIImage? {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
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

final class Utilities {
    static let selectedPinkImage: UIImage = {
        UIColor.providedPink.createOnePixelImage() ?? UIImage()
    }()

    static let selectedDarkPinkImage: UIImage = {
        UIColor.providedPinkDark.createOnePixelImage() ?? UIImage()
    }()
}
