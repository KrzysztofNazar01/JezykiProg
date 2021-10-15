import System.IO ()
import System.Win32 (RegInfoKey(values))
import GHC.Num.Backend.Selected (integer_powmod)

{-- ctrl alt m  --> stop running code --}

forLoop :: Integer -> Integer -> Integer -> Integer-> Integer
forLoop i maxi counter number =
    if i <= maxi then
        if number `mod` i == 0 then
            if number `div` i == i then
                forLoop (i+1) maxi (counter + 1) number
            else
                forLoop (i+1) maxi (counter + 2) number
        else
            forLoop (i+1) maxi counter number
    else
        counter


calcSqrt :: Integer -> Integer
calcSqrt = truncate . sqrt . fromInteger


num :: Integer
num = 100
main :: IO ()
main = do
    putStrLn ("The number of divisor of " ++ show num ++ " is:") --"show x" pokazuje x jako stringa 
    let maxrep = calcSqrt num

    print (forLoop 1 maxrep 0 num)















