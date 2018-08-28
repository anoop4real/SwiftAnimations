//
//  AnimationsViewController.swift
//  MyCatalogue
//
//  Created by anoopm on 01/02/17.
//  Copyright © 2017 anoopm. All rights reserved.
//

import UIKit
import AudioToolbox
class AnimationsViewController: UIViewController {

    @IBOutlet weak var slideViewl: UIView!
    @IBOutlet weak var smiley: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func animateSlideView() {

        UIView.animate(withDuration: 0.5, delay: 0.4,
                       options: [.repeat, .autoreverse, .curveEaseInOut],
                       animations: {[weak self] in
                        self?.slideViewl.center.x += (self?.view.bounds.width)!
            },
                       completion: nil
        )
    }

    func animateSlideViewWithDamping() {

        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: [.autoreverse], animations: {[weak self] in
            self?.slideViewl.center.x += (self?.view.bounds.width)!
        }, completion: nil)

    }
    func shakeAnimation() -> CAAnimation {
        let shakeAnim = CAKeyframeAnimation(keyPath: "position")
        let mypath: CGMutablePath = CGMutablePath()
        mypath.move(to: CGPoint(x: CGFloat(smiley.frame.origin.x), y: CGFloat(smiley.frame.origin.y)), transform: .identity)
        mypath.addLine(to: CGPoint(x: CGFloat(smiley.frame.origin.x - 5), y: CGFloat(smiley.frame.origin.y)), transform: .identity)
        mypath.addLine(to: CGPoint(x: CGFloat(smiley.frame.origin.x - 5), y: CGFloat(smiley.frame.origin.y)), transform: .identity)
        mypath.addLine(to: CGPoint(x: CGFloat(smiley.frame.origin.x), y: CGFloat(smiley.frame.origin.y)), transform: .identity)
        mypath.addLine(to: CGPoint(x: CGFloat(smiley.frame.origin.x + 5), y: CGFloat(smiley.frame.origin.y)), transform: .identity)
        mypath.addLine(to: CGPoint(x: CGFloat(smiley.frame.origin.x + 5), y: CGFloat(smiley.frame.origin.y)), transform: .identity)
        mypath.addLine(to: CGPoint(x: CGFloat(smiley.frame.origin.x), y: CGFloat(smiley.frame.origin.y)), transform: .identity)
        mypath.closeSubpath()
        shakeAnim.path = mypath
        shakeAnim.repeatCount = 3
        shakeAnim.isRemovedOnCompletion = false
        shakeAnim.duration = 0.2
        return shakeAnim
    }
    func fadeAnim() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.values = [0.0, 0.2, 0.5, 0.75, 1.0]
        animation.keyTimes = [0.0, 0.2, 0.5, 0.75, 1.0]
        animation.duration = 5.0
        return animation
    }

    func moveAnimation() -> CAAnimation {

        let moveAnim = CAKeyframeAnimation(keyPath: "position")

        let path = CGMutablePath()
        let bezierPath = UIBezierPath(ovalIn: CGRect(x: 80, y: 120, width: 200, height: 200))
        path.addPath(bezierPath.cgPath, transform: .identity)
        moveAnim.path = path
        //moveAnim.repeatCount = 2;
        moveAnim.autoreverses = true
        moveAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        moveAnim.duration = 3.0
        return moveAnim
    }

    func rotateAnim() -> CABasicAnimation {
        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnim.fromValue = 0.0
        rotateAnim.toValue = 6.0
        rotateAnim.duration = 3.0
        rotateAnim.repeatCount = Float(BIG_ENDIAN)
        return rotateAnim
    }

    func scaleAnim() -> CABasicAnimation {
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 2.0
        scaleAnim.toValue = 1.0
        scaleAnim.duration = 1.0
        scaleAnim.repeatCount = Float(BIG_ENDIAN)
        return scaleAnim
    }

    func springIt() -> CASpringAnimation {

        let spring = CASpringAnimation(keyPath: "position.x")
        spring.damping = 5
        spring.fromValue = 0.0
        spring.toValue = 100.0
        spring.duration = spring.settlingDuration
        return spring
    }

    func animGroup() -> CAAnimationGroup {
        let animGroup = CAAnimationGroup()
        animGroup.animations = [self.scaleAnim(), self.rotateAnim()]
        animGroup.duration = 6.0
        return animGroup
    }

    func addRippleEffectTo(view referenceView: UIView) {

        /*! Creates a circular path around the view*/
        let path = UIBezierPath(ovalIn: CGRect(x: 0.0, y: 0.0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height))
        /*! Position where the shape layer should be */
        let shapePosition = CGPoint(x: referenceView.bounds.size.width/2.0, y: referenceView.bounds.size.height/2.0)

        // Create ripple shape
        let rippleShape = CAShapeLayer()
        rippleShape.bounds = CGRect(x: 0.0, y: 0.0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height)
        rippleShape.path = path.cgPath
        rippleShape.fillColor = UIColor.clear.cgColor
        rippleShape.strokeColor = UIColor.red.cgColor
        rippleShape.lineWidth = 4
        rippleShape.position = shapePosition
        rippleShape.opacity = 0

        /*! Add the ripple layer as the sublayer of the reference view */
        referenceView.layer.addSublayer(rippleShape)

        /*! Create scale animation of the ripples */
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))

        /*! Create animation for opacity of the ripples */
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 1
        opacityAnim.toValue = 0

        /*! Group the opacity and scale animations */
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnim, opacityAnim]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.duration = 0.7
        animation.repeatCount = 25
        animation.isRemovedOnCompletion = true
        rippleShape.add(animation, forKey: "rippleEffect")

    }

    func addANewView() {
        let view = UIView(frame: CGRect(x: CGFloat(self.view.center.x - 300 / 2), y: CGFloat(self.view.center.y - 300 / 2), width: CGFloat(300), height: CGFloat(300)))
        view.backgroundColor = UIColor.red
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        //choose your animation
        transition.subtype = kCATransitionFromTop
        view.layer.add(transition, forKey: nil)
        self.view.addSubview(view)
    }

    func addANewViewUsingTransition() {
        let view = UIView(frame: CGRect(x: CGFloat(self.view.center.x - 300 / 2), y: CGFloat(self.view.center.y - 300 / 2), width: CGFloat(300), height: CGFloat(300)))
        view.backgroundColor = UIColor.red
        UIView.transition(with: self.view, duration: 0.33, options: [.curveEaseInOut, .transitionCurlUp], animations: {
             self.view.addSubview(view)
        }, completion: nil)

    }
    func fadeIn(imageView: UIImageView, toImage: UIImage) {
        UIView.transition(with: imageView, duration: 1.0,
                          options: [.transitionCrossDissolve],
                          animations: {
                            imageView.image = toImage
        },
                          completion: nil
        )
    }

    @IBAction func shake(_ sender: Any) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        //[smiley.layer addAnimation:[self fade] forKey:@"Pos"];
        smiley.layer.add(self.shakeAnimation(), forKey: "Pos")

    }

    @IBAction func fade(_ sender: Any) {

        smiley.layer.add(self.fadeAnim(), forKey: "Fade")
    }
    @IBAction func crossDissolve(_ sender: Any) {
        
        fadeIn(imageView:smiley , toImage: UIImage(named: "angry")!)
    }

    @IBAction func move(_ sender: Any) {

        smiley.layer.add(self.moveAnimation(), forKey: "Move")
    }

    @IBAction func rotate(_ sender: Any) {

        smiley.layer.add(self.rotateAnim(), forKey: "Rotate")
    }

    @IBAction func scale(_ sender: UIButton) {
        let btn = sender
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping:
            0.2, initialSpringVelocity: 0.0, options: [.autoreverse], animations: {
                btn.bounds.size.width += 80.0
        }, completion: {(_) in
            btn.bounds.size.width -= 80.0
        })

        smiley.layer.add(self.scaleAnim(), forKey: "scale")
    }

    @IBAction func scaleAndRotate(_ sender: Any) {

        smiley.layer.add(self.animGroup(), forKey: "scalerotate")
    }
    @IBAction func springIt(_ sender: Any) {

        smiley.layer.add(self.springIt(), forKey: "spring")
    }

    @IBAction func rippleIt(_ sender: Any) {

        addRippleEffectTo(view: smiley)
    }

    @IBAction func addView(_ sender: Any) {

        addANewView()
        //addANewViewUsingTransition()
    }
    @IBAction func slide(_ sender: Any) {

        animateSlideView()
        //animateSlideViewWithDamping()
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
