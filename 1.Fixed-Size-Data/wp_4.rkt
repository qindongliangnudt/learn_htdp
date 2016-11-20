;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname wp_4) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;wp_4

;;Sample Problem:
;;Design a program that moves a car across the world canvas,
;;from left to right, at the rate of three pixels per clock tick.
;;If the mouse is clicked anywhere on the canvas,
;;the car is placed at the x-coordinate of that point.

(require 2htdp/image)
(require 2htdp/universe)

;; physical constants
(define WIDTH-OF-WORLD 800)
(define HEIGHT-OF-WORLD 50)
(define WHEEL-RADIUS 5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define Y-CAR (- HEIGHT-OF-WORLD (* 2 WHEEL-RADIUS)))

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

; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and
; the x-coordinate of the right-most edge of the car

; reder
; WorldState -> Image
; places the image of the car x pixels from
; the left margin of the BACKGROUND image
(define (render ws)
  (place-image CAR (- ws (* 9/2 WHEEL-RADIUS)) Y-CAR BACKGROUND))

; clock-tick-handler
; WorldState -> WorldState
; adds 3 to x to move the car right 
(define (tock ws)
  (+ ws 3))

; key-stroke-handler

; mouse-event-handler
; WorldState Number Number String -> WorldState
; places the car at the x-coordinate
; if the given me is "button-down"
; given: 21 10 20 "enter"
; wanted: 21
; given: 42 10 20 "button-down"
; wanted: 10
; given: 42 10 20 "move"
; wanted: 42
(define (hyper x-coordinate x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-coordinate]))

; end?: WorldState -> Boolean
; when needed, big-bang evaluates (end? cw) to determine
; whether the program should stop
(define (end? ws)
  (cond
    [(> (+ ws WHEEL-RADIUS) WIDTH-OF-WORLD) #true]
    [else #false]))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]
            [on-mouse hyper]
            [stop-when end?]))