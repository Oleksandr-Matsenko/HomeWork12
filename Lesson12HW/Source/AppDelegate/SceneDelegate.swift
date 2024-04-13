//
//  SceneDelegate.swift
//  Lesson12HW
//

//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Витягаємо поточну сцену
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Створюємо нове вікно для поточонї сцени
        let window = UIWindow(windowScene: windowScene)
        
        // Витягаємо інстанс InitialViewController із Main.storyboard
        if let initialVc = InitialViewController.fromMainStoryboard() {
            
            // Створюємо Навігайійний контроллер
            // і передаємо інстанс InitialViewController параметром,
            // тобто, тепер у нас є контейнер, з initialVc всередині,
            // що дає змогу робити анімаційні переходи між екранами
            let navigationController = UINavigationController(rootViewController: initialVc)
            
            // Скриваємо верхню панель навігації, вона нам поки непотрібна
//            navigationController.isNavigationBarHidden = true
            
            // Записуємо у вікно кореневий контроллер, а саме navigationController
            window.rootViewController = navigationController
        }
        
        // Записуємо створене вікно в коді у змінну класу window
        self.window = window
        
        // Робимо активним і видимим створене вікно
        window.makeKeyAndVisible()
    }
}

