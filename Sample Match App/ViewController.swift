import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    private func setupStyle(for button: UIButton) {
        button.setTitle("LET'S GO!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .providedKarlaExtraSmallFont
        button.backgroundColor = .providedPinkDark
    }
}

