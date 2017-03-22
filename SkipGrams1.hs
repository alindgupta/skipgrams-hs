-- TODO: Change documentation to reflect new functions

module SkipGrams
    ( rollSkipGrams     -- *
    , rollSkipGrams'    -- *
    , paddedSkipGrams   -- *
    ) where

{-# LANGUAGE ExistentialQuantification #-}

-- | Generate n-skip k-grams from a list for the first
-- element only
-- This function is buggy for edge cases
-- Use validSkipGrams if using a finite list
skipGrams :: forall t.
       [t]          -- ^ list, works correctly only if list is infinite
    -> Int          -- ^ n-skips
    -> Int          -- ^ k-grams
    -> [[t]]        -- ^ list of n-skip k-grams
skipGrams [] _ _ = [[]]
skipGrams (x:xs) n k = skipGrams' (x:xs) n k n 0
    where skipGrams' []     _ _ _ _ = [[]]
          skipGrams' (x:_)  _ 1 _ _ = [[x]]
          skipGrams' (x:xs) nSkips kGrams nSkips' iter =
              concat [(x:) <$> 
                skipGrams' (drop nSkips'' xs) 
                           (nSkips)
                           (kGrams-1)
                           (nSkips'') 
                           (iter+1)
                | nSkips'' <- range nSkips nSkips' iter ] 
          range n n' i = if i == 0
                            then [0..n]
                            else [0..(n-n')]
            
-- | Generate n-skips k-grams
validSkipGrams (x:xs) n k = filter (\sublist -> length sublist == k)
                                (skipGrams (x:xs) n k)


-- | Generate n-skip k-grams from a finite list for the
-- first element with padding
-- Since Haskell lists are homogeneous, padValue should
-- be the same type as the type of list
paddedSkipGrams :: forall t.
       t            -- ^ padded value
    -> [t]          -- ^ list
    -> Int          -- ^ n-skips
    -> Int          -- ^ k-grams
    -> [[t]]        -- ^ list of n-skip k-grams
paddedSkipGrams _ [] _ _ = [[]]
paddedSkipGrams padValue x n k = skipGrams (x ++ repeat padValue) n k

-- | Generate skipgrams from all elements in a (finite) list
-- Rightmost elements may not get a chance to be considered as
-- initial elements depending on values of n and k
rollSkipGrams [] _ _ = [[]]
rollSkipGrams (x:xs) n k = skipGrams (x:xs) n k ++ skipGrams xs n k

-- | Generate skipgrams from all elements in a finite list
-- with a pad, ensuring all elements are visited
rollSkipGrams' [] _ _ _ = [[]]
rollSkipGrams' padValue (x:xs) n k =   paddedSkipGrams padValue (x:xs) n k
                                    ++ paddedSkipGrams padValue xs n k


