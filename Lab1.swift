import Foundation


func function(x: Double) -> Double {
    return (-5 + x/2 + (x * x/10) * cos(x))
}

func interpolation(n: Int, minValue: Double, maxValue: Double) -> (first: (xPoints: [Double], yPoints: [Double]),
                                                                   second: (xPoints: [Double], yPoints: [Double]),
                                                                   difference: Double)
{
    var basePoints = [Double]()
    let distance: Double = (maxValue - minValue)/Double(n)
    var x: Double = minValue

    for _ in 0..<n {
        basePoints.append(x)
        x += distance
    }

    var newPoints = [Double]()

    for i in 1..<n {
        newPoints.append((basePoints[i] + basePoints[i - 1])/2)
    }


    var finalYPoints = [Double]()
    for currentPoint in newPoints {

        var temp: Double = 1
        var result: Double = 0

        for j in 0..<basePoints.count {
            for i in 0..<basePoints.count  {
                if i != j {
                    temp *= ((currentPoint - basePoints[i])/(basePoints[j] - basePoints[i]))
                }
            }

            temp *= function(x: basePoints[j])
            result += temp
            temp = 1
        }

        finalYPoints.append(result)
        result = 0
    }

    


    var baseYPoints = [Double]()
    for i in basePoints {
        baseYPoints.append(function(x: i))
    }
    
    var difference: Double = 0
    for index in 0..<min(baseYPoints.count, finalYPoints.count) {
        difference += abs(finalYPoints[index] - baseYPoints[index])
    }
    difference = difference/Double(min(baseYPoints.count, finalYPoints.count))
    
    // newPoints test - значения x и y для новой функции
    // points tr - значения x и y для старой функции
    
    return ((basePoints, baseYPoints) , (newPoints, finalYPoints), difference)
}

func interpolationChebishev(n: Int, minValue: Double, maxValue: Double) -> (first: (xPoints: [Double], yPoints: [Double]),
                                                                   second: (xPoints: [Double], yPoints: [Double]),
                                                                   difference: Double)
{
    var basePoints = [Double]()

    for i in 0..<n {
        let temp = (minValue + maxValue)/2
        let t2 = ((maxValue - minValue)*cos(Double(2*i + 1)*Double.pi/Double(2*n)))/2
        let t = temp + t2
        basePoints.append(t)
    }
    
    basePoints.sort()
    
    var newPoints = [Double]()
    let distance: Double = (maxValue - minValue)/Double(n)
    var x: Double = minValue

    for _ in 0..<n {
        newPoints.append(x)
        x += distance
    }


    var finalYPoints = [Double]()
    for currentPoint in newPoints {

        var temp: Double = 1
        var result: Double = 0

        for j in 0..<basePoints.count {
            for i in 0..<basePoints.count  {
                if i != j {
                    temp *= ((currentPoint - basePoints[i])/(basePoints[j] - basePoints[i]))
                }
            }

            temp *= function(x: basePoints[j])
            result += temp
            temp = 1
        }

        finalYPoints.append(result)
        result = 0
    }

    
    var baseYPoints = [Double]()
    for i in basePoints {
        baseYPoints.append(function(x: i))
    }
    
    var difference: Double = 0
    for index in 0..<min(baseYPoints.count, finalYPoints.count) {
        difference += abs(finalYPoints[index] - baseYPoints[index])
    }
    difference = difference/Double(min(baseYPoints.count, finalYPoints.count))
    
    // newPoints test - значения x и y для новой функции
    // points tr - значения x и y для старой функции
    
    return ((basePoints, baseYPoints), (newPoints, finalYPoints), difference)
}
