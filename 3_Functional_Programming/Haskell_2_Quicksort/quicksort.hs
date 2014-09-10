quickSort :: Ord a => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = quickSort(left) ++ [ x ] ++ quickSort(right)
          where
                left = [y | y <- xs, y < x] 
                right = [z | z <- xs, z >= x]

