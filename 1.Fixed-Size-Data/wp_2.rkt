;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname wp_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;wp_1 includes the following exercises:
;;Exercise 43

(require 2htdp/image)
(require 2htdp/universe)

(define WIDTH-OF-WORLD 800)
(define HEIGHT-OF-WORLD 50)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define Y-CAR (- HEIGHT-OF-WORLD (* 2 WHEEL-RADIUS)))
(define SPEED WHEEL-RADIUS)

;; graphical constants
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define SPACE
  (rectangle (* 5 WHEEL-RADIUS)  WHEEL-RADIUS "solid" "white"))
(define ONE-WHEEL
  (underlay/xy SPACE (- WHEEL-RADIUS) (- WHEEL-RADIUS) WHEEL))
(define BOTH-WHEELS
  (underlay/xy ONE-WHEEL (* 5 WHEEL-RADIUS) 0 WHEEL))

(define CAR-BODY
  (underlay/xy
   (rectangle (* 9 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red")
   (* 2 WHEEL-RADIUS) (* -1 WHEEL-RADIUS)
   (rectangle (* 5 WHEEL-RADIUS) WHEEL-RADIUS "solid" "red")))

(define CAR
  (underlay/xy CAR-BODY WHEEL-RADIUS (* 2 WHEEL-RADIUS) BOTH-WHEELS))

(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

; An AnimationState is a Number.
; interpretation the number of clock ticks
; since the animation started

; render
; WorldState -> Image
; places the image of the car ws*SPEED pixels from
; the left margin of the BACKGROUND image
(define (render ws)
  (place-image CAR (- (* ws SPEED) (* 9/2 WHEEL-RADIUS)) Y-CAR BACKGROUND))

; clock-tick-handler
; WorldState -> WorldState
; adds 1 to ws to move the car right 
(define (tock ws)
  (+ ws 1))

; end?: WorldState -> Boolean
; when needed, big-bang evaluates (end? cw) to determine
; whether the program should stop
(define (end? ws)
  (cond
    [(> (+ (* ws SPEED) WHEEL-RADIUS) WIDTH-OF-WORLD) #true]
    [else #false]))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]
            [stop-when end?]))