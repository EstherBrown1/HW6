//
//  HobbyViewController.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/26/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import UIKit
import AVFoundation

/// A view controller to display a hobby animation
final class HobbyViewController: UIViewController {
    /// Dismiss instructions
    private let dismissLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to dismiss"
        label.font = UIFont.systemFont(ofSize: 16)

        return label
    }()

    /// Soccer ball
    private let soccerBall: SoccerBall = {
        let ballSize: CGFloat = 80
        return SoccerBall(size: ballSize)
    }()

    /// Goal
    private let goalView: UIImageView = {
        let goal = UIImage(named: "goal")
        return  UIImageView(image: goal)
    }()

    /// Goal label
    private let goalLabel: UILabel = {
        let label = UILabel()
        label.text = "Goal!"
        label.font = UIFont.boldSystemFont(ofSize: 50)

        return label
    }()

    /// Tap to dismiss
    private lazy var tapToDismiss: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(tap))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(tapToDismiss)
        view.backgroundColor = .skyBlue

        setupSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startAnimation()
    }

    private func setupSubviews() {
        // Tap to dismiss label
        view.addSubview(dismissLabel)
        dismissLabel.pinTop(inset: 2 * .standard)
        dismissLabel.pinLeft(inset: .standard)

        // Ground
        let ground = UIView()
        ground.backgroundColor = .mint
        view.addSubview(ground)

        ground.pinBottom()
        ground.pinLeft()
        ground.pinRight()
        ground.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.1
        ).isActive = true

        // Grass patch
        let grass = GrassPatch(height: 50)
        view.addSubview(grass)

        grass.pinLeft()
        grass.bottomAnchor.makeEqual(ground.topAnchor)

        // Soccer ball
        view.addSubview(soccerBall)

        soccerBall.pinLeft(inset: 2 * .standard)
        soccerBall.bottomAnchor.makeEqual(ground.topAnchor)

        // Goal
        view.addSubview(goalView)

        goalView.pinRight()
        goalView.pinBottom()
        goalView.heightAnchor.constraint(
            equalTo: view.heightAnchor,
            multiplier: 0.4
        ).isActive = true
        goalView.widthAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: 0.4
        ).isActive = true

        // Clouds
        let cloud1 = Cloud(radius: 30)
        view.addSubview(cloud1)

        cloud1.pinTop(inset: 4 * .standard)
        cloud1.pinRight(inset: 2 * .standard)

        let cloud2 = Cloud(radius: 40)
        view.addSubview(cloud2)

        cloud2.pinTop(inset: 6 * .standard)
        cloud2.pinLeft(inset: 2 * .standard)

        // Goal label
        view.addSubview(goalLabel)

        goalLabel.makeCenter()
        goalLabel.transform = goalLabel.transform.scaledBy(x: 0.001, y: 0.001)
        goalLabel.isHidden = true
    }

    @objc private func tap() {
        dismiss(animated: true, completion: nil)
    }

    private func startAnimation() {
        let animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
            self.soccerBall.frame.origin.x = self.goalView.center.x - self.soccerBall.bounds.width / 2
            self.soccerBall.transform = self.soccerBall.transform.rotated(by: .pi)
        }

        animator.addCompletion { _ in
            self.goalLabel.isHidden = false

            let completionAnimator = UIViewPropertyAnimator(duration: 1, curve: .easeOut, animations: {
                self.soccerBall.alpha = 0.0
            })
            completionAnimator.addAnimations {
                self.goalLabel.transform = self.goalLabel.transform.scaledBy(x: 1000, y: 1000)
            }
            completionAnimator.startAnimation()
        }

        animator.startAnimation()
    }

    private func playAudio() {
        guard let fileURL = Bundle.main.path(forResource: "applause", ofType: "wav") else {
            return
        }

        if let audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL)) {
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }
    }
}
