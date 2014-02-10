cube_sum :: Int -> Int -> Int
cube_sum x y = x * x * x + y * y * y

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib(n-2)