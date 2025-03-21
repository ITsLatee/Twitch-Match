import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        
        let card = createCardView()
        
        func createCardView() -> UIView {
            let cardView = UIView()
            view.addSubview(cardView) //Само отображение карточки
            cardView.frame = CGRect(x: 0, y: 0, width: 350, height: 600)
            cardView.backgroundColor = .white
            cardView.center = view.center
            
            // Закругляем углы
            cardView.layer.cornerRadius = 15
            
            // Добавляем тень
            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cardView.layer.shadowOpacity = 0.3
            cardView.layer.shadowRadius = 4
            
            //работаем с жестом свайпа
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
            cardView.addGestureRecognizer(gesture)
            return cardView
        }
        
    }
    //сложное обрабатывание свайпа
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        guard let card = gesture.view else { return }
        
        let translation = gesture.translation(in: view)
        card.center = CGPoint(x: card.center.x + translation.x, y: card.center.y)
        
        // Сбрасываем смещение
        gesture.setTranslation(.zero, in: view)
        
        // Обработка завершения жеста
        if gesture.state == .ended {
            // Получаем скорость жеста
            let velocity = gesture.velocity(in: view)
            
            // Определяем, достаточно ли сильный свайп
            let minimumVelocity: CGFloat = 500 // Минимальная скорость для улетания
            let minimumTranslation: CGFloat = 100 // Минимальное смещение для улетания
            
            // Проверяем, был ли свайп достаточно сильным
            if abs(velocity.x) > minimumVelocity || abs(translation.x) > minimumTranslation {
                // Определяем направление свайпа
                let direction: CGFloat = velocity.x > 0 ? 1 : -1 // 1 = вправо, -1 = влево

                // Анимация улетания карточки
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(
                        x: direction * (self.view.frame.width + card.frame.width),
                        y: card.center.y
                    )
                }) { _ in
                    // Удаляем карточку после улетания
                    card.removeFromSuperview()
                }
            } else {
                // Возвращаем карточку на место
                UIView.animate(withDuration: 0.3) {
                    card.center = self.view.center
                }
            }
        }
    }
}

