import Foundation
import UIKit

class MainViewController: UIViewController {
    let viewModel = MainViewModel(initialState: .init(tiles: []))

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

    lazy var stackView: UIStackView = {
        let view = UIView()
        view.backgroundColor = .purple
        let verticalStack1 = createHorizontalStack(with: [
            createDefaultTile(with: "Mug"),
            createDefaultTile(with: "Dog")
        ])

        let verticalStack2 = createHorizontalStack(with: [
            createDefaultTile(with: "Tree"),
            createDefaultTile(with: "Basketball")
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
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure(viewModel.formatter)
        addSubviews()
    }

    private func configure(_ formatter: DateComponentsFormatter) {
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropLeading
        formatter.unitsStyle = .positional
    }

    private func addSubviews() {
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

    private func createDefaultTile(with title: String) -> UIView {
        let view = UIView()
        let imageView = UIImageView(image: UIImage(named: "tileDefault"))
        let title = createLabel(with: title, font: .providedKarlaSmallFont)

        view.addSubview(imageView)
        view.addSubview(title)

        title.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 263),

            title.widthAnchor.constraint(equalToConstant: 160),
            title.heightAnchor.constraint(equalToConstant: 54),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        return view
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
