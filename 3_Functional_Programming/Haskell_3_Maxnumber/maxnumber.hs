
max2 :: Integer -> Integer -> Integer
max2 a b = if a >= b then a else b

max3 :: Integer -> Integer -> Integer -> Integer
max3 a b c = max2 a (max2 b c)

max4 :: Integer -> Integer -> Integer -> Integer -> Integer
max4 a b c d = max2 a (max3 b c d)

max3' :: Integer -> Integer -> Integer -> Integer
max3' a b c = if a >= b then 
                 if a >= c then 
                    a
                 else
                    c
              else
                 if b >= c then
                    b
                 else
                    c