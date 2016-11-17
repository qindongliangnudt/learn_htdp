;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex_34) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;exercise 35
;String -> String
;extracts the last character from a non-empty string
;given: "string" expect: "g"
;given: "utinh" expect: "h"
;given: "x" expect: "x"
(define (string-last s)
  (string-ith s (- (string-length s) 1)))
(check-expect (string-last "string") "g")
(check-expect (string-last "utinh") "h")
(check-expect (string-last "x") "x")