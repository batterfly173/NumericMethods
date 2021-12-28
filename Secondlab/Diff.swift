import Foundation


//MARK: - Функция оригинальной производная
func originalDiff(x: Double) -> Double {
    return -2*cos(x)*sin(x)
}

//MARK: - Функция оригинальной 2 производная
func originalDiff2(x: Double) -> Double {
    return -2*cos(x)*cos(x) + 2*sin(x)*sin(x)
}

//MARK: - Оригиналы
class Diff {
    func functionForDiff(x: Double) -> Double {
        return cos(x)*cos(x)
    }
    
    // MARK: - Оригинальная производная которую посчитал Я
    func calculateOriginalDiff(x0: Double, xK: Double, h: Double) -> (xs: [Double], ys: [Double]) {
        var xs = [Double]()
        var ys = [Double]()
        
        for i in stride(from: x0, to: xK, by: h) {
            xs.append(i)
            ys.append(originalDiff(x: i))
        }
        
        return (xs: xs, ys: ys)
    }
    
    // MARK: - Оригинальная 2 производная которую посчитал Я
    func calculateOriginalDiff2(x0: Double, xK: Double, h: Double) -> (xs: [Double], ys: [Double]) {
        
        var xs = [Double]()
        var ys = [Double]()
        
        for i in stride(from: x0, to: xK, by: h) {
            xs.append(i)
            ys.append(originalDiff2(x: i))
        }
        
        return (xs: xs, ys: ys)
    }
}
