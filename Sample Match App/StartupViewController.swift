import UIKit

class StartupViewController: UIViewController {
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialStyle(for: continueButton)
    }

    private func setupInitialStyle(for button: UIButton) {
        button.setTitle("LET'S GO!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .providedKarlaMediumFont
        button.setBackgroundImage(Utilities.selectedPinkImage, for: .normal)
        button.layer.cornerRadius = 12
    }
}

