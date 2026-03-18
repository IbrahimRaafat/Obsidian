-- Reusing double from the lecture
double :: Int -> Int 
double x = x * 2

-- Solutions to the exercises 

-- 1. Double and add 
doubleAdd :: Int -> Int -> Int
doubleAdd x y = double x + double y   
-- or directly:
doubleAdd' :: Int -> Int -> Int
doubleAdd' x y = x * 2 + y * 2

-- 2. Countdown 
countdown :: Int -> [Int]
countdown 0 = []
countdown n = n : countdown (n - 1)

-- 3. List maximum
myMax :: [Int] -> Int
myMax [x]    = x
myMax (x:xs) = max x (myMax xs)

-- 4. Partial Application
triple :: Int -> Int
triple = (*3)

addTen :: Int -> Int
addTen = (+10)

isEven :: Int -> Bool
isEven = (== 0) . (`mod` 2)

-- 5. Fibonacci
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fibFast :: Int -> Int
fibFast n = ff n 0 1
  where
    ff 0 a _ = a
    ff n a b = ff (n-1) b (a+b)
   

-- 6. Tuple pattern matching
classify :: (Int, Int) -> String
classify (0, 0) = "origin"
classify (0, _) = "on y-axis"
classify (_, 0) = "on x-axis"
classify (_, _) = "somewhere else"

-- 7. List comprehensions
pairs :: Int -> [(Int, Int)]
pairs n = [ (x, y) | x <- [1..n], y <- [1..n], x < y ]

-- 8. takeWhile
takeWhile' :: (Int -> Bool) -> [Int] -> [Int]
takeWhile' _ []     = []
takeWhile' p (x:xs) = if p x then x : takeWhile' p xs else []

-- 9. zipWith
myZipWith :: (Int -> Int -> Int) -> [Int] -> [Int] -> [Int]
myZipWith _ []     _      = []
myZipWith _ _      []     = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys

-- 10. Pipeline Challenge
challenge :: [Int] -> Int
challenge = sum . map (^2) . filter odd
-- or without composition:
challenge' :: [Int] -> Int
challenge' xs = sum (map (^2) (filter odd xs))
