import System.IO ()
import System.Win32 (RegInfoKey(values))

{-- ctrl alt m  --> stop running code --}
-- liczenie znakow online: https://www.charactercountonline.com/

cyfryJedn :: Integer -> Integer
cyfryJedn 0 = 0  --zero
cyfryJedn 1 = 5  --jeden
cyfryJedn 2 = 3  --dwa
cyfryJedn 3 = 4  --trzy
cyfryJedn 4 = 6  --cztery
cyfryJedn 5 = 4  --piec
cyfryJedn 6 = 5  --szesc
cyfryJedn 7 = 6  --siedem
cyfryJedn 8 = 5  --osiem
cyfryJedn 9 = 8  --dziewiec


cyfryDzies :: Integer -> Integer
cyfryDzies 0 = 0  --zero
cyfryDzies 1 = 8  --dziesiec
cyfryDzies 2 = 11  --dwadziescia
cyfryDzies 3 = 11  --trzydziesci
cyfryDzies 4 = 12  --czterdziesci
cyfryDzies 5 = 12  --piecdziesiat
cyfryDzies 6 = 13  --szescdziesiat
cyfryDzies 7 = 15  --siedemdziesciat
cyfryDzies 8 = 14  --osiemdziesciat
cyfryDzies 9 = 17  --dziewiecdziesciat


cyfryDziesSpec :: Integer -> Integer
cyfryDziesSpec 1 = 10  --jedenascie
cyfryDziesSpec 2 = 9   --dwanascie
cyfryDziesSpec 3 = 10  --trzynascie
cyfryDziesSpec 4 = 11  --czternascie
cyfryDziesSpec 5 = 10  --pietnascie
cyfryDziesSpec 6 = 10  --szesnascie
cyfryDziesSpec 7 = 12  --siedemnascie
cyfryDziesSpec 8 = 11  --osiemnascie
cyfryDziesSpec 9 = 14  --dziewietnascie


cyfrySetek :: Integer -> Integer
cyfrySetek 0 = 0  --zero
cyfrySetek 1 = 3  --sto
cyfrySetek 2 = 8  --dwiescie
cyfrySetek 3 = 7  --trzysta
cyfrySetek 4 = 9  --czterysta
cyfrySetek 5 = 7  --piecset
cyfrySetek 6 = 8  --szescset
cyfrySetek 7 = 9  --siedemset
cyfrySetek 8 = 8  --osiemset
cyfrySetek 9 = 11  --dziewiecset



calcRes :: (Integer, Integer, Integer) -> Integer
calcRes (set, dzies, jedn) =
    if dzies == 1 && jedn /= 0 then
        cyfryDziesSpec jedn + cyfrySetek set
    else
        cyfryJedn jedn + cyfryDzies dzies + cyfrySetek set


checkVal :: Integer -> Bool
checkVal value =
    value > 0 && value < 1000




val :: Integer
val = -2
main :: IO ()
main = do

       if checkVal val then do
            let jedn = val `mod` 10 :: Integer
            let dzies = (val `mod` 100 - val `mod` 10) `div` 10 :: Integer
            let setek = (val `mod` 1000 - val `mod` 100) `div` 100 :: Integer

            print setek 
            print dzies
            print jedn

            print(calcRes(setek, dzies, jedn))
       else do
            print "Invalid number"












