-- | Implementation of the skipgram algorithm in Haskell
-- Note - the algorithm here only calculate skipgrams for
-- the context on the right, not simultaneously left+right contexts


{-# OPTIONS_GHC -fwarn-unused-matches -fwarn-incomplete-patterns #-}


-- | Generate n-skip k-grams from a list of Ints
-- only for the first element in the list
skipgrams :: [Int]          -- ^ list, ideally infinite
          -> Int            -- ^ n-grams
          -> Int            -- ^ k-skips
          -> [[Int]]        -- ^ list of n-skip k-grams
skipgrams [] _ _ = [[]]
skipgrams (x:xs) n k = skipgrams' (x:xs) n k k 0
  where skipgrams' :: [Int] -> Int -> Int -> Int -> Int -> [[Int]]
        skipgrams' [] _ _ _ _ = [[]]
        skipgrams' (x:_) 1 _ _ _ = [[x]]
        skipgrams' (x:xs) nGrams kSkips currKSkips iter =
          concat [(x:) <$> 
            (skipgrams' (drop currKSkips xs) (nGrams-1) (kSkips) (currKSkips) (iter+1))
                | currKSkips <- range kSkips currKSkips iter]
        range s c i = if i == 0
                          then [0..s]
                          else [0..(s-c)]
        {-# INLINE range #-}


-- | Wrapper for skipgrams
-- given a finite list, this function will pad -1 if required
paddedSkipgrams :: [Int]        -- ^ list of any size
                -> Int          -- ^ n-grams
                -> Int          -- ^ k-skips
                -> [[Int]]
paddedSkipgrams [] _ _ = [[]]
paddedSkipgrams x n k = skipgrams (x ++ repeat (-1)) n k


-- | Generate n-skip k-grams by rolling along
-- a given list (i.e. all possible n-skip k-grams)
rollSkipgrams :: [Int]          -- ^ finite list
              -> Int            -- ^ n-grams
              -> Int            -- ^ k-skips
              -> [[Int]]
rollSkipgrams [] _ _ = []
rollSkipgrams (x:xs) n k = paddedSkipgrams (x:xs) n k ++ rollSkipgrams xs n k


-- | Generate n-skip k-grams by rolling along
-- a given list, filter valid ngrams (i.e. those without a pad element)
validSkipgrams :: [Int] -> Int -> Int -> [[Int]]
validSkipgrams =  ((filter (notElem (-1)) . ) . ) . rollSkipgrams
