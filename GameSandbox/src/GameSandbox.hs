module Main where

import Control.Monad (unless)
-- import Linear (V4(..))
import SDL

main :: IO ()
main = do
  initializeAll
  window <- createWindow "Game Sandbox" defaultWindow
  renderer <- createRenderer window (-1) defaultRenderer
  appLoop renderer
  destroyWindow window

appLoop :: Renderer -> IO ()
appLoop renderer = do
  events <- pollEvents
  let
    eventIsQPress event =
      case eventPayload event of
        KeyboardEvent keyboardEvent ->
          keyboardEventKeyMotion keyboardEvent == Pressed &&
          keysymKeycode (keyboardEventKeysym keyboardEvent) == KeycodeQ
        _ -> False
    qPressed = any eventIsQPress events
  rendererDrawColor renderer $= V4 0 0 255 255
  clear renderer
  present renderer
  unless qPressed (appLoop renderer)
