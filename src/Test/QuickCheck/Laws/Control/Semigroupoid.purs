module Test.QuickCheck.Laws.Control.Semigroupoid where

import Console (log)
import Test.QuickCheck (QC(..), quickCheck)
import Test.QuickCheck.Arbitrary (Arbitrary, Coarbitrary)
import Type.Proxy (Proxy(), Proxy3())

-- | - Associativity: `p <<< (q <<< r) = (p <<< q) <<< r`
checkSemigroupoid :: forall a b c d e. (Semigroupoid a,
                                        Arbitrary (a b c),
                                        Arbitrary (a c d),
                                        Arbitrary (a d e),
                                        Eq (a b e)) => Proxy3 a
                                                    -> Proxy b
                                                    -> Proxy c
                                                    -> Proxy d
                                                    -> Proxy e
                                                    -> QC Unit
checkSemigroupoid _ _ _ _ _ = do

  log "Checking 'Associativity' law for Semigroupoid"
  quickCheck associativity

  where

  associativity :: a d e -> a c d -> a b c -> Boolean
  associativity p q r = (p <<< (q <<< r)) == ((p <<< q) <<< r)
