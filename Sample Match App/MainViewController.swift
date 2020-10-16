import Foundation
import UIKit

class MainViewController: UIViewController, UINavigationControllerDelegate {
    let viewModel = MainViewModel(initialState: .init(tiles: Array(repeating: MainViewModel.Tile(), count: 4)))

    lazy var footerView: UIView = {
        let footerView = UIView()
        footerView.backgroundColor = .providedBgGrayDark
        return footerView
    }()

    lazy var countdownLabel: UILabel = {
        createLabel(with: viewModel.state.countdownText, font: .providedKarlaLargeFont)
    }()

    lazy var titleLabel: UILabel = {
        createLabel(with: "Tap to snap", font: .providedKarlaMediumFont)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure(viewModel.formatter)
        addSubviews()
        NotificationCenter.default.addObserver(self, selector: #selector(addSubviews), name: viewModel.notificationName, object: nil)
    }

    private func configure(_ formatter: DateComponentsFormatter) {
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropLeading
        formatter.unitsStyle = .positional
    }

    @objc private func addSubviews() {
        let stackView = createMainStackView()
        stackView.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        view.subviews.forEach { $0.removeFromSuperview() }
        footerView.addSubview(countdownLabel)
        view.addSubview(stackView)
        view.addSubview(footerView)
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            stackView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: -45),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: view.frame.height - footerView.frame.height),

            countdownLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 0),
            countdownLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -16),
            countdownLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 8),
            countdownLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -8),
            countdownLabel.widthAnchor.constraint(equalToConstant: footerView.frame.width - 16),
            countdownLabel.heightAnchor.constraint(equalToConstant: footerView.frame.height - 16),

            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func createTile(for tile: MainViewModel.Tile) -> UIView {
        let view = UIView()

        if let image = tile.image {
            let imageView = UIImageView(image: image)
            view.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 160),
                imageView.heightAnchor.constraint(equalToConstant: 263)
            ])
        }

        let button = UIButton()
        let imageName: String

        switch tile.state {
        case .verify:
            imageName = "tileVerify"
            button.isUserInteractionEnabled = false
        case .default:
            imageName = "tileDefault"
            button.isUserInteractionEnabled = true
        case .incorrect:
            imageName = "tileIncorrect"
            button.isUserInteractionEnabled = true
        case.success:
            imageName = "tileSuccess"
            button.isUserInteractionEnabled = true
        }

        button.setImage(UIImage(named: imageName), for: .normal)
        button.tag = tile.id

        let titleView: UIView = createLabel(with: tile.title, font: .providedKarlaSmallFont)
        view.addSubview(button)
        view.addSubview(titleView)

        titleView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.widthAnchor.constraint(equalToConstant: 160),
            button.heightAnchor.constraint(equalToConstant: 263),

            titleView.widthAnchor.constraint(equalToConstant: 160),
            titleView.heightAnchor.constraint(equalToConstant: 54),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return view
    }

    @objc private func showCamera(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }

        viewModel.updateSelectedTile(with: button.tag, tileState: .verify)

        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }

    private func createMainStackView() -> UIStackView {
        let view = UIView()
        view.backgroundColor = .purple
        let verticalStack1 = createHorizontalStack(with: [
            createTile(for: viewModel.state.tiles[0]),
            createTile(for: viewModel.state.tiles[1])
        ])

        let verticalStack2 = createHorizontalStack(with: [
            createTile(for: viewModel.state.tiles[2]),
            createTile(for: viewModel.state.tiles[3])
        ])

        let stackView =  UIStackView(arrangedSubviews: [
            titleLabel,
            verticalStack1,
            verticalStack2
        ])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 15

        return stackView
    }

    private func createHorizontalStack(with views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    private func createLabel(with text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = font
        label.textAlignment = .center
        label.text = text

        return label
    }
}

extension MainViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage, let id = viewModel.state.currentlySelectedTile?.id else {
            //TODO: Handle error of no image found
            return
        }

        viewModel.updateSelectedTile(with: id, tileState: .verify, image: image)
    }
}