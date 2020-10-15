import Foundation
import UIKit

class MainViewController: UIViewController {
    lazy var footerView: UIView = {
        let footerView = UIView()
        footerView.backgroundColor = .providedBgGrayDark
        return footerView
    }()

    lazy var countdownLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .providedKarlaLargeFont
        label.textAlignment = .center

        return label
    }()

    let startTime: Date = Date()
    let duration: TimeInterval = 1440 * 60
    var runningTime: TimeInterval = 0
    let formatter = DateComponentsFormatter()
    var time: Date = Date()
    let cal: Calendar = Calendar.current

    override func viewDidLoad() {
        super.viewDidLoad()

        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .dropLeading
        formatter.unitsStyle = .short

        footerView.addSubview(countdownLabel)
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
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
            footerView.heightAnchor.constraint(equalToConstant: 83)
        ])

        beginTimer()
    }

    func beginTimer() {
        repeat {
            time = cal.date(byAdding: .minute, value: 1, to: time)!
            runningTime = time.timeIntervalSince(startTime)

            if runningTime < duration {
                countdownLabel.text = formatter.string(from: duration - runningTime)
            }
        } while runningTime < duration
    }
}
