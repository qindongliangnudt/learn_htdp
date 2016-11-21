;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname keh) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A Position is a Number.
; interpretation distance between the left
; margin and the ball

; Position KeyEvent -> Position
; computes the next location of the ball

;;physical constants definition
(define CIRCLE-RADIUS 10)
(define SCENE-WIDTH 1000)
(define SCENE-HEIGHT 100)
(define Y-COR (- SCENE-HEIGHT CIRCLE-RADIUS))

;;graphical constants definition
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))
(define CIRCLE (circle CIRCLE-RADIUS "solid" "red"))

(check-expect (keh 13 "left") 8)
(check-expect (keh 13 "right") 18)
(check-expect (keh 13 "a") 13)

(define (keh p k)
  (cond
    [(= (string-length k) 1) p]
    [(string=? "left" k) (- p 5)]
    [(string=? "right" k) (+ p 5)]
    [else p]))

; reder
; WorldState -> Image
; places the image of the ball x pixels from
; the left margin of the SCENE image
(define (render ws)
  (place-image CIRCLE ws Y-COR SCENE))

(define (main ws)
  (big-bang ws
            [on-key keh]
            [to-draw render]))