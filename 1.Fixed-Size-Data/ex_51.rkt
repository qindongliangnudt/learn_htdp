;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex_51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume

;;physical constants definition
(define DURATION 100)
(define LIGHT-RADIUS 50)
(define SCENE-WIDTH 100)
(define SCENE-HEIGHT 100)

;;graphical constants definition
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))

; clock-tick-handler
; WorldState -> WorldState
; traffic-light-next every 100 ticks 
(define (tock ws)
  (traffic-light-next ws))

; reder
; WorldState -> Image
; 
(define (render ws)
  (place-image (circle LIGHT-RADIUS "solid" ws)
               (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 2)
               SCENE))
  
(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]))