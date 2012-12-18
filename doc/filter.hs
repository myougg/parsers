-- compile with:  ghc --make Pygments
-- run with:      pandoc -t json test.md | ./Pygments | pandoc -f json -s -H pygments.header > test.html

import Text.Pandoc
import System.Process

main = toJsonFilter hilight
  where hilight (CodeBlock (_,[lang], _) code) = RawBlock "html" `fmap` pygments code lang
        hilight x = return x

{-
css :: IO String
css = readProcess "pygmentize" ["-S", "default",  "-f", "html"]
-}

pygments:: String -> String -> IO String
pygments code lang = readProcess "pygmentize" ["-l", lang,  "-f", "html"] code
