;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex_34) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;exercise 34
;String -> String
;extract extracts the first character from a non-empty string
;given: "string" expected: "s"
;given: "to be" expected: "t"
;given: "u" expected: "u"
(define (string-first s)
  (substring s 0 1))
(check-expect (string-first "string") "s")
(check-expect (string-first "to be") "t")
(check-expect (string-first "u") "u")