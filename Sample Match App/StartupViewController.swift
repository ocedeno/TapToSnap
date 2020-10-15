import UIKit

class StartupViewController: UIViewController {
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialStyle(for: &continueButton)
        continueButton.addTarget(self, action: #selector(presentMainViewController), for: .touchUpInside)
    }

    private func setupInitialStyle(for button: inout UIButton) {
        button.setTitle("LET'S GO!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .providedKarlaMediumFont
        button.setBackgroundImage(Utilities.selectedPinkImage, for: .normal)
        button.layer.cornerRadius = 12
    }

    @objc private func presentMainViewController() {
        let viewController = MainViewController()
        viewController.view.backgroundColor = .providedBgGray
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}

