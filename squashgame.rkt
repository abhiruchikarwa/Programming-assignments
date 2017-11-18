;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname q2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require rackunit)
(require 2htdp/universe)
(require 2htdp/image)
(require "extras.rkt")

(check-location "06" "q2.rkt")
(provide
 simulation
 initial-world
 world-ready-to-serve?
 world-after-tick
 world-after-key-event
 world-balls
 world-racket
 ball-x
 ball-y
 racket-x
 racket-y
 ball-vx
 ball-vy
 racket-vx
 racket-vy
 world-after-mouse-event
 racket-after-mouse-event
 racket-selected?
 )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; PURPOSE STATEMENT
;;; The simulation of a single squash player practicing without an
;;; opponent is the machine that consists of a ball and racket
;;; where the movement of the ball and racket responds to the
;;; passing of each tick of time.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CONSTANTS
;;; dimensions of the canvas
(define CANVAS-WIDTH 425)
(define CANVAS-HEIGHT 649)
(define EMPTY-CANVAS
  (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "white"))
(define PAUSED-CANVAS
  (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "yellow"))
;;; dimensions of the ball and racket in the world
(define BALL (circle 3 "solid" "black"))
(define RACKET (rectangle 47 7 "solid" "green"))
;;; defining the number of seconds the simulation should pause
(define WAIT-TIME 3)
(define RACKET-AREA-RADIUS 25)
;;; defining mouse-position-circle
(define MOUSE-CIRCLE (circle 4 "solid" "blue"))
(define LEFT "left")
(define RIGHT "right")
(define UP "up")
(define DOWN "down")
;;; A KeyEvent can be any one of the following events:
;;; -- " "      interp: pause-key
;;; -- "up"     interp: up-key
;;; -- "down"   interp: down-key
;;; -- "left"   interp: left-key
;;; -- "right"  interp: right-key
;;; -- "b"      interp: ball-key
;;; -- "q"      interp: non-pause-key

;;; template:
;;; kev-fn : KeyEvent -> ??
;;;(define (kev-fn kev)
;;;  (cond
;;;    [(key=? kev " ") ...]
;;;    [(key=? kev "up") ...]
;;;    [(key=? kev "down") ...]
;;;    [(key=? kev "left") ...]
;;;    [(key=? kev "right") ...]
;;;    [(key=? kev "b") ...]))
;;;    [(key=? kev "q") ...]))

;;; defining the key events
(define (is-pause-key-event? kev)
  (key=? kev " "))
(define (is-up-key-event? kev)
  (key=? kev "up"))
(define (is-down-key-event? kev)
  (key=? kev "down"))
(define (is-left-key-event? kev)
  (key=? kev "left"))
(define (is-right-key-event? kev)
  (key=? kev "right"))
(define (is-ball-key-event? kev)
  (key=? kev "b"))

;;; A MouseEvent can be any one of the following events:
;;; -- "button-down"  interp: maybe select the racket
;;; -- "drag"         interp: maybe drag the racket
;;; -- "button-up"    interp: unselect the racket

;;; template:
;;; mev-fn : MouseEvent -> ??
;;;(define (mev-fn mev)
;;;  (cond
;;;    [(mouse=? mev "button-down") ...]
;;;    [(mouse=? mev "drag") ...]
;;;    [(mouse=? mev "button-up") ...]
;;;    [else ...]))

;;; defining the mouse events
(define (is-mouse-down-event? mev)
  (mouse=? mev "button-down"))
(define (is-mouse-drag-event? mev)
  (mouse=? mev "drag"))
(define (is-mouse-up-event? mev)
  (mouse=? mev "button-up"))


;;; defining the states the world will be in
(define RALLY "rally")
(define SERVE "serve")
(define PAUSED "paused")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; DATA DEFINITIONS
;;; REPRESENTATION
;;; A World is represented as
;;; (make-world ball racket paused? speed rticks state)
;;; with the following fields:
;;; balls   : BallList  a list of the squash balls that are present in the 
;;;                     world (but does not include any balls that have 
;;;                     disappeared by colliding with the back wall)
;;; racket  : Racket    the squash racket present in the  world
;;; paused? : Boolean   tells whether or not the world is paused
;;; speed   : PosReal   the speed at which the world runs in
;;;                     seconds per tick
;;; rticks  : NonNegInt the number of ticks remaining for the world
;;;                     state to change
;;; state   : String    the state in which the game is currently
;;;                     state can be any one of SERVE or RALLY or PAUSED
;;; IMPLEMENTATION
(define-struct world (balls racket paused? speed rticks state))
;;; CONSTRUCTOR TEMPLATE
;;; (make-world BallList Racket Boolean PosReal NonNegInt String)
;;; OBSERVER TEMPLATE
;;; world-fn : World -> ??
(define (world-fn w)
  (...
   (world-balls w)
   (world-racket w)
   (world-paused? w)
   (world-speed w)
   (world-rticks w)
   (world-state w)))

;;; REPRESENTATION
;;; A Ball is represented as
;;; (make-ball x y vx vy) where:
;;; x, y   : Integer  the x and y co-ordinates of the ball's
;;;                     position in the scene in graphics coordinates
;;; vx, vy : Integer    the number of pixels the ball moves per
;;;                     tick in the x and y directions.
;;; IMPLEMENTATION
(define-struct ball (x y vx vy))
;;; CONSTRUCTOR TEMPLATE
;;; (make-ball Integer Integer Integer Integer)
;;; OBSERVER TEMPLATE
;;; ball-fn : Ball -> ??
(define (ball-fn b)
  (...
   (ball-x b)
   (ball-y b)
   (ball-vx b)
   (ball-vy b)))

;;;REPRESENTATION
;;; A BallList is represented as a list of Ball

;; CONSTRUCTOR TEMPLATES:
;; empty
;; (cons ball bl)
;; -- WHERE
;;    ball is a Ball
;;    bl   is a BallList

;; OBSERVER TEMPLATE:
;; bl-fn : BallList -> ??
#;
(define (bl-fn bl)
  (cond
    [(empty? bl) ...]
    [else (...
           (ball-fn (first bl))
           (bl-fn (rest bl)))]))

;;; REPRESENTATION
;;; A Racket is represented as
;;; (make-racket x y vx vy selected? rmx rmy) where:
;;; x, y      : Integer  the x and y co-ordinates of the racket's
;;;                        position in the scene in graphics coordinates
;;; vx, vy    : Integer    the number of pixels the racket moves per
;;;                        tick in the x and y directions.
;;; selected? : Boolean    value denoting whether racket is selected
;;; rmx, rmy  : NonNegInt  the x and y co-ordinates of the mouse's
;;;                        position in the scene
;;; IMPLEMENTATION
(define-struct racket (x y vx vy selected? rmx rmy))
;;; CONSTRUCTOR TEMPLATE
;;; (make-racket Integer Integer Integer Integer
;;;              Boolean NonNegInt NonNegInt)
;;; OBSERVER TEMPLATE
;;; racket-fn : Racket -> ??
(define (racket-fn r)
  (...
   (racket-x r)
   (racket-y r)
   (racket-vx r)
   (racket-vy r)
   (racket-selected? r)
   (racket-rmx r)
   (racket-rmy r)
   ))

;;;example constants for world
(define SERVE-WORLD
  (make-world
   (cons (make-ball 330 384 0 0) empty)
   (make-racket 330 384 0 0 #false 0 0)
   #false
   0.125
   0
   SERVE))
(define SERVE-PAUSED-WORLD
  (make-world
   (cons (make-ball 330 384 0 0) empty)
   (make-racket 330 384 0 0 #false 0 0)
   #t
   0.125
   0
   SERVE))
(define RALLY-WORLD
  (make-world
   (cons (make-ball 375 249 3 -9) empty)
   (make-racket 330 384 0 0 #false 0 0)
   #false
   0.125
   0
   RALLY))
(define RALLY-TO-PAUSE-WORLD
  (make-world
   (cons (make-ball 375 249 3 -9) empty)
   (make-racket 330 384 0 0 #false 0 0)
   #false
   0.125
   24
   RALLY))

(define PAUSED-WORLD
  (make-world
   (cons (make-ball 375 249 3 -9) empty)
   (make-racket 330 384 0 0 #false 0 0)
   #true
   0.125
   0
   PAUSED))

(define RACKET-SELECTED-WORLD
  (make-world
   (cons (make-ball 333 375 3 -9) empty)
   (make-racket 330 384 0 0 #t 330 386)
   #false
   0.125
   0
   RALLY))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MAIN FUNCTION FOR SIMULATION
;;; simulation : PosReal -> World
;;; GIVEN: the speed of the simulation, in seconds per tick
;;;     (so larger numbers run slower)
;;; EFFECT: runs the simulation, starting with the initial world
;;; RETURNS: the final state of the world
;;; EXAMPLES:
;;;     (simulation 1) runs in super slow motion
;;;     (simulation 1/24) runs at a more realistic speed
(define (simulation speed)
  (big-bang (initial-world speed)
            (on-draw world-to-scene)
            (on-tick world-after-tick speed)
            (on-key world-after-key-event)
            (on-mouse world-after-mouse-event)))

;;; initial-world : PosReal -> World
;;; GIVEN: the speed of the simulation, in seconds per tick
;;;     (so larger numbers run slower)
;;; RETURNS: the ready-to-serve state of the world
;;; EXAMPLE: (initial-world 1)
;;; STRATEGY: use constructor template for the struct World
(define (initial-world speed)
  (make-world (cons (make-ball 330 384 0 0) empty)
              (make-racket 330 384 0 0 #f 0 0)
              #true
              speed
              0
              SERVE))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; world-to-scene : World -> Scene
;;; RETURNS: a Scene that portrays the given world.
;;; EXAMPLE:
;;; (world-to-scene SERVE-WORLD)
;;; (world-to-scene PAUSED-WORLD)
;;; STRATEGY: use the observer template of struct World
(define (world-to-scene w)
  (cond
    [(equal? (world-state w) PAUSED) (scene-with-balls
                                      (world-balls w)
                                      (scene-with-racket
                                       (world-racket w)
                                       PAUSED-CANVAS))]
    [else (check-racket-selected w)]))
;;; check-racket-selected : World -> Scene
;;; RETURNS: a Scene that portrays the given world where racket is selected.
;;; EXAMPLE: (check-racket-selected RACKET-SELECTED-WORLD)
;;; STRATEGY: use the observer template of struct Racket
(define (check-racket-selected w)
  (cond
    [(racket-selected? (world-racket w))
     (scene-with-balls
      (world-balls w)
      (scene-with-mouse-circle
       (world-racket w)
       (scene-with-racket
        (world-racket w)
        EMPTY-CANVAS)))]
    [else
     (scene-with-balls
      (world-balls w)
      (scene-with-racket
       (world-racket w)
       EMPTY-CANVAS))]))

;;; scene-with-balls : BallList Scene -> Scene
;;; RETURNS: a scene like the given one, but with the given balls in the list
;;;         painted on it. 
;;; STRATEGY: use a HOF foldr on BallList
(define (scene-with-balls bl s)
  (foldr
   scene-with-ball
   s
   bl))
;(define (scene-with-balls bl s)
;  (cond
;    [(empty? bl) s]
;    [else (scene-with-ball (first bl) (scene-with-balls (rest bl) s))]))

;;; scene-with-ball : Ball Scene -> Scene
;;; RETURNS: a scene like the given one, but with the given ball painted on it. 
;;; STRATEGY: use the observer template for the Ball
(define (scene-with-ball b s)
  (place-image BALL (ball-x b) (ball-y b) s))

;;; scene-with-racket : Racket Scene -> Scene
;;; RETURNS: a scene like the given one, but with the given racket
;;;          painted on it. 
;;; STRATEGY: use the observer template for the struct Racket
(define (scene-with-racket r s)
  (place-image RACKET (racket-x r) (racket-y r) s))

;;; scene-with-mouse-circle : Racket Scene -> Scene
;;; RETURNS: a scene like the given one, but with the mouse position
;;;          circle painted on it. 
;;; STRATEGY: use the observer template for the struct Racket
(define (scene-with-mouse-circle r s)
  (place-image MOUSE-CIRCLE (racket-rmx r) (racket-rmy r) s))

;;; TESTS:
(begin-for-test
  (check-equal?
   (world-to-scene SERVE-WORLD)
   (place-image BALL 330 384 (place-image RACKET 330 384 EMPTY-CANVAS))
   "unpaused scene")
  (check-equal?
   (world-to-scene RACKET-SELECTED-WORLD)
   (place-image BALL 333 375
                (place-image MOUSE-CIRCLE 330 386
                             (place-image RACKET 330 384 EMPTY-CANVAS)))
   "unpaused scene")
  (check-equal?
   (world-to-scene PAUSED-WORLD)
   (place-image BALL 375 249 (place-image RACKET 330 384 PAUSED-CANVAS))
   "paused scene"))

;;; TESTS:
(begin-for-test
  (check-equal?
   (scene-with-balls (cons (make-ball 330 384 0 0) empty) EMPTY-CANVAS)
   (place-image BALL 330 384 EMPTY-CANVAS)
   "Correct scene"
   )
  (check-equal?
   (scene-with-balls empty EMPTY-CANVAS)
   (place-image BALL -5 -5 EMPTY-CANVAS)
   "Correct scene"
   )
  (check-equal?
   (scene-with-balls (cons (make-ball 330 384 0 0)
                           (cons (make-ball 200 200 3 -2) empty)) EMPTY-CANVAS)
   (place-image BALL 330 384
                (place-image BALL 200 200 EMPTY-CANVAS))
   "Correct scene"
   ))

;;; TESTS:
(begin-for-test
  (check-equal?
   (scene-with-racket (make-racket 330 384 0 0 #false 0 0) EMPTY-CANVAS)
   (place-image RACKET 330 384 EMPTY-CANVAS)
   "Correct scene"
   ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; world-after-tick : World -> World
;;; GIVEN: any world that's possible for the simulation
;;; RETURNS: the world that should follow the given world
;;;     after a tick
;;; EXAMPLE:
;;; (world-after-tick SERVE-WORLD)
;;; (world-after-tick RALLY-WORLD)
;;; (world-after-tick RALLY-TO-PAUSED-WORLD)
;;; (world-after-tick PAUSED-WORLD)
;;; STRATEGY: Cases on state of the world in that tick
(define (world-after-tick w)
  (cond
    [(world-ready-to-serve? w) w]
    [(equal? (world-state w) RALLY) (world-in-rally-state w)]
    [(equal? (world-state w) PAUSED) (world-in-paused-state w)]))
;;; TESTS:
(begin-for-test
  (check-equal?
   (world-after-tick SERVE-WORLD)
   (make-world
    (cons(make-ball 330 384 0 0)empty)
    (make-racket 330 384 0 0 #false 0 0)
    #false
    0.125
    0
    SERVE)
   "world after tick for serve world returned"
   )
  (check-equal?
   (world-after-tick RALLY-WORLD)
   (make-world
    (cons(make-ball 378 240 3 -9)empty)
    (make-racket 330 384 0 0 #false 0 0)
    #false
    0.125
    0
    RALLY)
   "world after tick for rally world returned")
  (check-equal?
   (world-after-tick PAUSED-WORLD)
   (make-world
    (cons(make-ball 375 249 3 -9)empty)
    (make-racket 330 384 0 0 #false 0 0)
    #true
    0.125
    1
    PAUSED)
   "world after tick for paused world returned")
  (check-equal?
   (world-after-tick
    (make-world
     (cons(make-ball 330 384 0 0)empty)
     (make-racket 330 384 0 0 #false 0 0)
     #f
     0.125
     2
     RALLY))
   (make-world
    (cons(make-ball 330 384 0 0)empty)
    (make-racket 330 384 0 0 #false 0 0)
    #false
    0.125
    2
    RALLY)
   "world in the start of rally state returned")
  )

;;; world-ready-to-serve? : World -> Boolean
;;; GIVEN: a world
;;; RETURNS: true iff the world is in its ready-to-serve state
;;; EXAMPLE: (world-ready-to-serve? SERVE-WORLD)
;;; STRATEGY: use the observer template of struct World on the
;;;           structs Ball and Racket
(define (world-ready-to-serve? w)
  (and
   (equal? (world-state w) SERVE)
   (equal? (first (world-balls w)) (make-ball 330 384 0 0))
   (equal? (world-racket w) (make-racket 330 384 0 0 #f 0 0))))

;;; TESTS:
(begin-for-test
  (check-equal?
   (world-ready-to-serve? SERVE-WORLD)
   #true
   "world that is ready-to-serve returned")
  (check-equal?
   (world-in-paused-state SERVE-WORLD)
   (make-world
    (cons(make-ball 330 384 0 0)empty)
    (make-racket 330 384 0 0 #false 0 0)
    #true
    0.125
    1
    PAUSED)
   "paused world for the world-ready-serve state returned")
  )

;;; tentative-ball : Ball -> NonNegInt
;;; GIVEN: a Ball
;;; RETURNS: the tentative x coordinate of the ball in next tick
;;; STRATEGY: use observer template of Ball
(define (tentative-ball-x b)
  (+ (ball-x b) (ball-vx b)))

;;; tentative-ball-y : Ball -> NonNegInt
;;; GIVEN: a Ball
;;; RETURNS: the tentative y coordinate of the ball in next tick
;;; STRATEGY: use observer template of Ball
(define (tentative-ball-y b)
  (+ (ball-y b) (ball-vy b)))

;;; tentative-racket-x : Racket -> NonNegInt
;;; GIVEN: a Racket
;;; RETURNS: the tentative x-coordinate of racket in the next tick
;;; STRATEGY: use observer template of Racket
(define (tentative-racket-x r)
  (+ (racket-x r) (racket-vx r)))

;;; tentative-racket-y : Racket -> NonNegInt
;;; GIVEN: a Racket
;;; RETURNS: the tentative y-coordinate of racket in the next tick
;;; STRATEGY: use observer template of Racket
(define (tentative-racket-y r)
  (+ (racket-y r) (racket-vy r)))

;;; world-in-rally-state : World -> World
;;; GIVEN: a World
;;; RETURNS: a World that is in Rally state
;;; EXAMPLE:
;;; (world-in-rally-state
;;;    (make-world (make-ball 46 415 -3 10)
;;;                (make-racket 47/2 420 0 2 #f 0 0)
;;;                #f 1/16 0 RALLY))
;;;   
;;; STRATEGY: Cases on World that checks whether the world has been paused.
(define (world-in-rally-state w)
  (cond
    [(world-paused? w) (world-in-paused-state w)]
    [(< (tentative-racket-y (world-racket w)) 0) (world-in-paused-state w)]
    [(empty? (world-balls w)) (world-in-paused-state w)]
    [else (make-world-after-collision w)]
    ))

;;TESTS:
(begin-for-test
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 333 375 0 0)empty)
                (make-racket 330 384 0 0 #false 0 0)
                #true 0.125 0 RALLY))
   (make-world (cons(make-ball 333 375 0 0)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #true 0.125 1 PAUSED)
   " paused World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 46 415 -3 10)empty)
                (make-racket 47/2 420 0 2 #false 0 0)
                #f 1/16 0 RALLY))
   (make-world (cons(make-ball 43 425 -3 -8)empty)
               (make-racket 23.5 422 0 2 #false 0 0)
               #false 0.0625 0 RALLY)
   "ball-racket World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 1 348 -3 -9)empty)
                (make-racket 47/2 384 0 0 #false 0 0)
                #f 1/8 0 RALLY))
   (make-world (cons(make-ball 2 339 3 -9)empty)
               (make-racket 23.5 384 0 0 #false 0 0)
               #false 0.125 0 RALLY)
   "ball-left wall World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 424 105 847 -9)empty)
                (make-racket 330 384 0 0 #false 0 0)
                #f 1/8 0 RALLY))
   (make-world (cons(make-ball -421 96 -847 -9)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #false 0.125 0 RALLY)
   "ball-right wall World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 116 6 3 -9)empty)
                (make-racket 47/2 7/2 0 0 #false 0 0)
                #f 1/8 0 RALLY))
   (make-world (cons(make-ball 119 3 3 9)empty)
               (make-racket 23.5 3.5 0 0 #false 0 0)
               #false 0.125 0 RALLY)
   "ball-front wall World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 64 213 -3 9)empty)
                (make-racket 1 384 -4 0 #false 0 0)
                #f 1/8 0 RALLY))
   (make-world (cons(make-ball 61 222 -3 9)empty)
               (make-racket 24 384 4 0 #false 0 0)
               #false 0.125 0 RALLY)
   "racket-left wall World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 418 105 -3 -9)empty)
                (make-racket 423 384 17 0 #false 0 0)
                #f 1/8 0 RALLY))
   (make-world (cons(make-ball 415 96 -3 -9)empty)
               (make-racket 402 384 -17 0 #false 0 0)
               #false 0.125 0 RALLY)
   "racket-right-wall World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 101 51 3 -9)empty)
                (make-racket 47/2 7/2 0 -4 #f 0 0)
                #f 1/8 0 RALLY))
   (make-world (cons(make-ball 101 51 3 -9)empty)
               (make-racket 23.5 3.5 0 -4 #f 0 0)
               #t 0.125 1 PAUSED)
   "racket-front-wall World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 172 642 -3 9)empty)
                (make-racket 330 384 0 0 #false 0 0)
                #f 1/24 0 RALLY))
   (make-world empty
               (make-racket 330 384 0 0 #false 0 0)
               #f 1/24 0 RALLY)
   "ball-back-wall World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 280 318 -3 9)empty)
                (make-racket 330 649 0 6 #false 0 0)
                #f 1/24 0 RALLY))
   (make-world (cons(make-ball 277 327 -3 9)empty)
               (make-racket 330 646 0 -6 #false 0 0)
               #f 1/24 0 RALLY)
   "racket-back-wall World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world (cons(make-ball 414 132 3 -9)empty)
                (make-racket 302 406 0 0 #t 315 417)
                #f 1/24 0 RALLY))
   (make-world (cons(make-ball 417 123 3 -9)empty)
               (make-racket 302 406 0 0 #true 315 417)
               #false 1/24 0 RALLY)
   " World returned"
   )
  (check-equal?
   (world-in-rally-state
    (make-world empty
                (make-racket 302 406 0 0 #t 315 417)
                #f 1/24 0 RALLY))
   (make-world empty
               (make-racket 302 406 0 0 #true 315 417)
               #t 1/24 1 PAUSED)
   "World returned"
   )
  )

;;; make-world-after-collision : World -> World
;;; GIVEN: a World
;;; RETURNS: an updated World after any collision of ball or racket occurs
;;; EXAMPLE: (make-world-after-collision RALLY-WORLD)
;;; STRATEGY: Use constructor template of World.
(define (make-world-after-collision w)
  (make-world
   (balls-after-tick (balls-not-colliding-with-back-wall (world-balls w))
                     (world-racket w))
   (racket-after-tick (world-balls w)
                      (world-racket w))
   (world-paused? w)
   (world-speed w)
   (world-rticks w)
   RALLY))

;;; balls-not-colliding-with-back-wall : BallList -> BallList
;;; GIVEN: a BallList
;;; RETURNS: updated BallList where balls colliding with back wall are removed
;;; EXAMPLE: (balls-not-colliding-with-back-wall (list (make-ball 330 384 0 0)))
;;; STRATEGY: Use HOF filter on BallList.
(define (balls-not-colliding-with-back-wall bl)
  (filter ball-not-collide-back-wall? bl))

;;; ball-not-collide-back-wall? : Ball -> Boolean
;;; GIVEN: a Ball
;;; RETURNS: a Boolean that denotes whether the ball does not collide with
;;;          bottom wall of scene
;;; EXAMPLE: (ball-not-collide-back-wall? (make-ball 330 384 0 0))
;;; STRATEGY: Use simpler functions on BallList.
(define (ball-not-collide-back-wall? b)
  (<= (tentative-ball-y b) 649)
  )
;(define (balls-back-wall-collision? bl)
; (> (tentative-ball-y b) 649)
;  )

;;; balls-after-tick : BallList Racket -> BallList
;;; GIVEN: a BallList and Racket
;;; RETURNS: an updated BallList after that tick
;;; EXAMPLE: (balls-after-tick (cons(make-ball 330 384 0 0)empty)
;                              (make-racket 330 384 0 0 #false 0 0))
;;; STRATEGY: Use HOF map on BallList.
(define (balls-after-tick bl r)
  (map
   ; BallList -> BallList
   ; GIVEN: a BallList
   ; RETURNS: an updated BallList after checking collision conditions on it
   (lambda (b)
     (check-ball-collision b r))
   bl)
  )

;;(define (balls-after-tick bl r bctr)
;;  (cond
;;    [(end-reached? bl bctr) empty]
;;    [(balls-back-wall-collision? bl bctr)
;;     (balls-after-tick bl r (+ bctr 1))]
;;    [else
;;     (cons
;;      (check-ball-collision (get-ball-for bl bctr) r)
;;      (balls-after-tick bl r (+ bctr 1)))]))
;; end-reached? : BallList NonNegint -> Boolean
;; GIVEN: a World and counter for checking the ball number in list
;; RETURNS: a Boolean if counter has reached the end of the length of BallList 
;; EXAMPLE: (end-reached? (cons (make-ball 292 282 -3 9)
;;                              (make-ball 330 282 -3 9) empty) 1)
;; STRATEGY: Use simpler functions on BallList.
;; (define (end-reached? bl bctr)
;;   (equal? bctr (length bl)))


;;; check-ball-collision : Ball Racket -> Ball
;;; GIVEN: a Ball and a Racket
;;; RETURNS: an updated Ball after any collision of ball occurs
;;; EXAMPLE: (check-ball-collision (make-ball 1 348 -3 -9)
;                                  (make-racket 47/2 384 0 0 #false 0 0))
;;; STRATEGY: Use simpler functions on Ball and Racket
(define (check-ball-collision b r)
  (cond
    [(< (tentative-ball-x b) 0)
     (ball-left-wall-collision b)]
    [(> (tentative-ball-x b) 425)
     (ball-right-wall-collision b)]
    [(< (tentative-ball-y b) 0)
     (ball-front-wall-collision b)]
    [(ball-collides-with-racket? b r)
     (ball-after-racket-collision b r)]
    [else
     (update-ball-position b)])
  )
;;; TESTS:
(begin-for-test
  (check-equal?
   (check-ball-collision
    (make-ball 1 348 -3 -9)
    (make-racket 47/2 384 0 0 #false 0 0))
   (make-ball 2 339 3 -9)  
   "ball-left-wall-collision")
  (check-equal?
   (check-ball-collision
    (make-ball 424 105 847 -9)
    (make-racket 330 384 0 0 #false 0 0))
   (make-ball -421 96 -847 -9)
   "ball-right-wall-collision")
  (check-equal?
   (check-ball-collision
    (make-ball 116 6 3 -9)
    (make-racket 47/2 7/2 0 0 #false 0 0))
   (make-ball 119 3 3 9)   
   "ball-front-wall-collision")
  )

;;; ball-collides-with-racket? : Ball Racket -> Boolean
;;; GIVEN: a Ball and a Racket
;;; RETURNS: a boolean value denoting whether or not the ball collides with
;;;          the racket
;;; EXAMPLE:
;;; (ball-collides-with-racket? (make-ball 292 282 -3 9)
;;;               (make-racket 293 289 -1 -2 #false 0 0))

;;; STRATEGY: use simpler functions on Ball and Racket
(define (ball-collides-with-racket? b r)
  (and
   (>= (ball-vy b) 0)
   (check-collision-coordinates? b r)))
;;; TESTS:
(begin-for-test
  (check-equal?
   (ball-collides-with-racket?
    (make-ball 292 282 -3 9)
    (make-racket 293 289 -1 -2 #false 0 0))
   #true
   "ball collides with racket")
  (check-equal?
   (ball-collides-with-racket?
    (make-ball 400 282 -3 9)
    (make-racket 293 589 -1 -2 #false 0 0))
   #false
   "ball does not collides with racket")
  )

;;; get-ball-for : BallList Non-Negint -> Ball
;;; GIVEN: a BallList and a counter for getting the ball number in the list
;;; RETURNS: a Ball at that position of counter in BallList
;;; EXAMPLE: (get-ball-for (cons (make-ball 292 282 -3 9)
;                                (make-ball 330 282 -3 9)empty) 0)
;;; STRATEGY: Use simpler functions.
;(define (get-ball-for bl i)
;  (list-ref bl i))

;;; racket-after-tick : BallList Racket -> Racket
;;; GIVEN: a BallList, Racket
;;; RETURNS: an updated Racket after any collision of racket occurs
;;; EXAMPLE:
;;; STRATEGY: Use observer template of struct Racket.
(define (racket-after-tick bl r)
  (cond
    [(< (tentative-racket-x r) 0)
     (racket-left-wall-collision r)]
    [(> (tentative-racket-x r) 425)
     (racket-right-wall-collision r)]
    [(> (tentative-racket-y r) 649)
     (racket-back-wall-collision r)]
    [(racket-collides-with-balls? bl r)
     (racket-after-ball-collision r)]
    [else
     (update-racket-position r)]))

;;; racket-collides-with-balls? : BallList Racket -> Boolean
;;; GIVEN: a BallList and a Racket
;;; RETURNS: a boolean value denoting whether the racket collides with
;;;          any ball in the list
;;; EXAMPLE:
;;; (racket-collides-with-balls? (cons (make-ball 400 282 -3 9) empty)
;;;                                    (make-racket 293 289 -1 -2 #false 0 0))
;;; STRATEGY: use HOF ormap on BallList and simpler function on Racket
(define (racket-collides-with-balls? bl r)
  (ormap
   ; BallList -> Boolean
   ; GIVEN: a BallList
   ; RETURNS: true iff either of the balls in BallList collide with the racket
   (lambda (b)
     (and
      (>= (ball-vy b) 0)
      (check-collision-coordinates? b r)))
   bl))
;;; TESTS:
(begin-for-test
  (check-equal?
   (racket-collides-with-balls?
    (cons (make-ball 292 282 -3 9) empty)
    (make-racket 293 289 -1 -2 #false 0 0))
   #true
   "racket collide with one of the balls")
  (check-equal?
   (racket-collides-with-balls?
    (cons (make-ball 400 282 -3 9) empty)
    (make-racket 293 589 -1 -2 #false 0 0))
   #false
   "racket does not collide with one of the balls")
  )

;;; check-collision-coordinates? : Ball Racket -> Boolean
;;; GIVEN: a Ball and Racket
;;; RETURNS: a Boolean denoting if the ball collides with the racket
;;; EXAMPLE:
;;; (check-collision-coordinates? (make-ball 292 282 -3 9)
;;;               (make-racket 293 289 -1 -2 #false 0 0))
;;; STRATEGY: Use simpler functions on Ball and Racket.
(define (check-collision-coordinates? b r)
  (and
   (or
    (and
     (<=
      (tentative-ball-x b)
      (+ (tentative-racket-x r) 47/2))
     (>=
      (ball-x b)
      (- (tentative-racket-x r) 47/2)))
    (and
     (>=
      (tentative-ball-x b)
      (+ (tentative-racket-x r) 47/2))
     (<=
      (ball-x b)
      (- (tentative-racket-x r) 47/2))))
   (and
    (<=
     (ball-y b)
     (tentative-racket-y r))
    (<=
     (tentative-racket-y r)
     (tentative-ball-y b)))))   

;;; ball-after-racket-collision : Ball Racket -> Ball
;;; GIVEN: a Ball and a Racket
;;; RETURNS: an updated Ball after it collides with Racket
;;; EXAMPLES :
; (ball-after-racket-collision (make-ball 292 282 -3 9)
;                              (make-racket 293 289 -1 -2 #false 0 0))
;;; STRATEGY: use constructor template of Ball
(define (ball-after-racket-collision b r)
  (make-ball
   (tentative-ball-x b)
   (tentative-ball-y b)
   (ball-vx b)
   (- (racket-vy r)
      (ball-vy b))))

;;; ball-left-wall-collision : Ball -> Ball
;;; GIVEN: a Ball
;;; RETURNS: an updated Ball after it collides with the left wall
;;; EXAMPLES :(ball-left-wall-collision (make-ball 1 348 -3 -9))
;;; STRATEGY: call a more general function
(define (ball-left-wall-collision b)
  (ball-side-wall-collision LEFT b))

;;; ball-right-wall-collision : Ball -> Ball
;;; GIVEN: a Ball
;;; RETURNS: an updated Ball after it collides with the right wall
;;; EXAMPLES : (ball-right-wall-collision (make-ball 424 105 847 -9))
;;; STRATEGY: call a more general function
(define (ball-right-wall-collision b)
  (ball-side-wall-collision RIGHT b))

;;; ball-side-wall-collision : String Ball -> Ball
;;; GIVEN: a a String(either left or right) and a Ball
;;; RETURNS: an updated Ball after it collides with the side wall
;;; EXAMPLES :
; (ball-side-wall-collision LEFT (make-ball 1 348 -3 -9))
; (ball-side-wall-collision RIGHT (make-ball 424 105 847 -9))
;;; STRATEGY: use constructor template of Ball
(define (ball-side-wall-collision str b)
  (make-ball
   (cond
     [(string=? str LEFT)(- 0 (tentative-ball-x b))]
     [(string=? str RIGHT)(- 425 (- (tentative-ball-x b) 425))])
   (tentative-ball-y b)
   (- 0 (ball-vx b))
   (ball-vy b)))

;;; ball-front-wall-collision : Ball -> Ball
;;; GIVEN: a Ball
;;; RETURNS: an updated Ball after it collides with the front wall
;;; EXAMPLES :(ball-front-wall-collision (make-ball 116 6 3 -9))
;;; STRATEGY: use constructor template of Ball
(define (ball-front-wall-collision b)
  (make-ball
   (tentative-ball-x b)
   (- 0 (tentative-ball-y b))
   (ball-vx b)
   (- 0 (ball-vy b))))

;;; racket-left-wall-collision : Racket -> Racket
;;; GIVEN: a Racket
;;; RETURNS: an updated Racket after it collides with the left wall
;;; EXAMPLES : (racket-left-wall-collision (make-racket 1 384 -4 0 #false 0 0))
;;; STRATEGY: call a more general function
(define (racket-left-wall-collision r)
  (racket-side-wall-collision LEFT r))
;;; TESTS:
(begin-for-test
  (check-equal?
   (racket-left-wall-collision
    (make-racket 1 384 -4 0 #false 0 0))
   (make-racket 24 384 4 0 #false 0 0)
   "racket-left-wall-collision")
  )

;;; racket-right-wall-collision : Racket -> Racket
;;; GIVEN: a Racket
;;; RETURNS: an updated Racket after it collides with the right wall
;;; EXAMPLE: (racket-right-wall-collision (make-racket 423 384 17 0 #false 0 0))
;;; STRATEGY: call a more general function
(define (racket-right-wall-collision r)
  (racket-side-wall-collision RIGHT r))
;;; TESTS:
(begin-for-test
  (check-equal?
   (racket-right-wall-collision
    (make-racket 423 384 17 0 #false 0 0))
   (make-racket 402 384 -17 0 #false 0 0)
   "racket-right-wall-collision"))

;;; racket-side-wall-collision : String Racket -> Racket
;;; GIVEN: a String(either left or right) and Racket
;;; RETURNS: an updated Racket after it collides with the side wall
;;; STRATEGY: use constructor template of Racket
(define (racket-side-wall-collision str r)
  (make-racket
   (cond
     [(string=? str LEFT) (round (+ 0 47/2))]
     [(string=? str RIGHT) (round (- 425 47/2))])
   (tentative-racket-y r)
   (- 0 (racket-vx r))
   (racket-vy r)
   (racket-selected? r)
   (racket-rmx r)
   (racket-rmy r)))
;;; racket-back-wall-collision : Racket -> Racket
;;; GIVEN: a Racket
;;; RETURNS: an updated Racket after it collides with the back wall
;;; EXAMPLES :(racket-back-wall-collision
;    (make-racket 47/2 7/2 0 -4 #false 0 0))
;;; STRATEGY: use constructor template of Racket
(define (racket-back-wall-collision r)
  (make-racket
   (tentative-racket-x r)
   (round (- 649 7/2))
   (racket-vx r)
   (- 0 (racket-vy r))
   (racket-selected? r)
   (racket-rmx r)
   (racket-rmy r)))

;;; TESTS:
(begin-for-test
  (check-equal?
   (racket-back-wall-collision
    (make-racket 47/2 7/2 0 -4 #false 0 0))
   (make-racket 23.5 646 0 4 #false 0 0)
   "racket-back-wall-collision")
  )

;;; racket-after-ball-collision : Racket -> Racket
;;; GIVEN: a Racket
;;; RETURNS: an updated Racket after it collides with the Ball
;;; EXAMPLES : (racket-after-ball-collision
;    (make-racket 293 289 -1 -2 #false 0 0))
;;; STRATEGY: use constructor template of Racket
(define (racket-after-ball-collision r)
  (make-racket
   (tentative-racket-x r)
   (tentative-racket-y r)
   (racket-vx r)
   (if (and (equal? (racket-selected? r) #false) (< (racket-vy r) 0))
       0
       (racket-vy r))
   (racket-selected? r)
   (racket-rmx r)
   (racket-rmy r)))
;;; TESTS:
(begin-for-test
  (check-equal?
   (racket-after-ball-collision
    (make-racket 293 289 -1 -2 #false 0 0))
   (make-racket 292 287 -1 0 #false 0 0)
   "racket-after-ball-collision incorrect")
  (check-equal?
   (racket-after-ball-collision
    (make-racket 293 289 -1 2 #false 0 0))
   (make-racket 292 291 -1 2 #false 0 0)
   "racket-after-ball-collision incorrect")
  (check-equal?
   (racket-after-ball-collision
    (make-racket 293 289 -1 2 #true 0 0))
   (make-racket 292 291 -1 2 #true 0 0)
   "racket-after-ball-collision incorrect"))
   
;;; update-ball-position : Ball -> Ball
;;; GIVEN: a Ball
;;; RETURNS: a Ball whose positions are updated after tick
;;; EXAMPLES: (update-ball-position (make-ball 210 105 23 1))
;;; STRATEGY: use constructor template of Ball
(define (update-ball-position b)
  (make-ball
   (tentative-ball-x b)
   (tentative-ball-y b)
   (ball-vx b)
   (ball-vy b)))

;;; update-racket-position : Racket -> Racket
;;; GIVEN: a Racket
;;; RETURNS: a Racket whose positions are updated after tick
;;; EXAMPLES: (update-racket-position (make-racket 293 289 -1 -2 #false 0 0))
;;; STRATEGY: use constructor template of Racket
(define (update-racket-position r)
  (if (racket-selected? r)
      r
      (make-racket
       (tentative-racket-x r)
       (tentative-racket-y r)
       (racket-vx r)
       (racket-vy r)
       (racket-selected? r)
       0
       0)))

;;; world-in-paused-state : World -> World
;;; GIVEN: a World
;;; RETURNS: a World which is in paused state in the current tick 
;;; EXAMPLE: (world-in-paused-state RALLY-WORLD)
;;;          (world-in-paused-state SERVE-WORLD)
;;; STRATEGY: use the transcribe formula and constructor template of world
(define (world-in-paused-state w)
  (if (< (world-rticks w) (- (/ WAIT-TIME (world-speed w)) 1))
      (make-world
       (world-balls w)
       (world-racket w)
       true
       (world-speed w)
       (+ (world-rticks w) 1)
       PAUSED)
      (initial-world (world-speed w))))
;;; TESTS:
(begin-for-test
  (check-equal?
   (world-in-paused-state
    (make-world (cons(make-ball 330 384 3 -9)empty)
                (make-racket 330 384 0 0 #false 0 0)
                #false 1/8 24 RALLY))
   (make-world (cons(make-ball 330 384 0 0)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #true 1/8 0 SERVE)
   "paused world returned"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; world-after-key-event : World KeyEvent -> World
;;; GIVEN: a world and a key event
;;; RETURNS: the world that should follow the given world
;;;          after the given key event
;;; EXAMPLES:
;;; (world-after-key-event RALLY-WORLD " ")
;;; (world-after-key-event RALLY-WORLD "up")
;;; (world-after-key-event RALLY-WORLD "down")
;;; (world-after-key-event RALLY-WORLD "left")
;;; (world-after-key-event RALLY-WORLD "right")
;;; (world-after-key-event SERVE-WORLD "b")
;;; (world-after-key-event SERVE-WORLD "q")
;;; STRATAGY: Cases on KeyEvent
(define (world-after-key-event w kev)
  (cond
    [(is-pause-key-event? kev) (pause-key-event-world w)]
    [(is-up-key-event? kev)    (up-key-event-world w)]
    [(is-down-key-event? kev)  (down-key-event-world w)]
    [(is-left-key-event? kev)  (left-key-event-world w)]
    [(is-right-key-event? kev) (right-key-event-world w)]
    [(is-ball-key-event? kev)  (ball-key-event-world w)]
    [else "Non-key event"]))

;;; serve-to-rally-world : World -> World
;;; GIVEN: a World
;;; RETURNS: a world after pause-key event in world that is in serve state.
;;; EXAMPLES:
;;; (serve-to-rally-world SERVE-WORLD)
;;; STRATEGY: Use constructor template for World
(define (serve-to-rally-world w)
  (make-world
   (cons (make-ball 330 384 3 -9) empty)
   (make-racket 330 384 0 0 #false 0 0)
   (not (world-paused? w))
   (world-speed w)
   (+ (world-rticks w) 1)
   RALLY))

;;; rally-to-paused-world : World -> World
;;; GIVEN: a World
;;; RETURNS: a world after pause-key event in world that is in rally state.
;;; EXAMPLES:
;;; (rally-to-paused-world RALLY-WORLD)
;;; STRATEGY: Use constructor template for World
(define (rally-to-paused-world w)
  (make-world
   (world-balls w)
   (world-racket w)
   (not (world-paused? w))
   (world-speed w)
   (world-rticks w)
   PAUSED))

;;; pause-key-event-world : World -> World
;;; GIVEN: a World
;;; RETURNS: a world just like the given one, but with paused?
;;;          toggled
;;; EXAMPLES:
;;; (world-after-key-event RALLY-WORLD)
;;; (world-after-key-event SERVE-WORLD)
;;; STRATEGY: Use constructor template for World
(define (pause-key-event-world w)
  (cond
    [(string=? (world-state w) SERVE) (serve-to-rally-world w)]
    [(string=? (world-state w) RALLY) (rally-to-paused-world w)]
    [(string=? (world-state w) PAUSED) w]))

;;; ball-key-event-world : World -> World
;;; GIVEN: a World
;;; RETURNS: a world just like the given one, but with a new Ball painted on it
;;; EXAMPLES: (world-after-key-event RALLY-WORLD)
;;; STRATEGY: Use constructor template for World
(define (ball-key-event-world w)
  (if (equal? (world-state w) RALLY)
      (make-world
       (cons (make-ball 330 384 3 -9) (world-balls w))
       (world-racket w)
       (world-paused? w)
       (world-speed w)
       (world-rticks w)
       (world-state w))
      w))

;;; up-key-event-world : World -> World
;;; GIVEN: a World
;;; RETURNS: a world just like the given one, but with racket's
;;;          decreased velocity in y-direction
;;; EXAMPLES: (world-after-key-event RALLY-WORLD)
;;; STRATEGY: use a general function
(define (up-key-event-world w)
  (world-after-arrow-key UP w))

;;; down-key-event-world : World -> World
;;; GIVEN: a World
;;; RETURNS: a world just like the given one, but with racket's
;;;          increased velocity in y-direction
;;; EXAMPLES: (world-after-key-event RALLY-WORLD)
;;; STRATEGY: use a general function
(define (down-key-event-world w)
  (world-after-arrow-key DOWN w))

;;; left-key-event-world : World -> World
;;; GIVEN: a World
;;; RETURNS: a world just like the given one, but with racket's
;;;          decreased velocity in x-direction
;;; EXAMPLES: (world-after-key-event RALLY-WORLD)
;;; STRATEGY: use a general function
(define (left-key-event-world w)
  (world-after-arrow-key LEFT w))

;;; right-key-event-world : World -> World
;;; GIVEN: a World
;;; RETURNS: a world just like the given one, but with racket's
;;;          increased velocity in x-direction
;;; EXAMPLES: (world-after-key-event RALLY-WORLD)
;;; STRATEGY: use a general function
(define (right-key-event-world w)
  (world-after-arrow-key RIGHT w))

;;; world-after-arrow-key : String World -> World
;;; GIVEN: a String (can be UP, DOWN, LEFT or RIGHT) and World
;;; RETURNS: a world just like the given, but with racket's updated velocity
;;; STRATEGY: Use constructor template for World
(define (world-after-arrow-key str w)
  (if
   (and
    (equal? (world-state w) RALLY)
    (equal? (racket-selected? (world-racket w)) #false))
   (make-world (world-balls w)
               (racket-after-arrow-key str (world-racket w))
               (world-paused? w)
               (world-speed w)
               (world-rticks w)
               RALLY)
   w))

;;; racket-after-arrow-key : String Racket -> Racket
;;; GIVEN: a String (can be UP, DOWN, LEFT or RIGHT) and Racket
;;; RETURNS: a Racket just like the given, but with the updated velocity
;;; STRATEGY: Use constructor template for Racket
(define (racket-after-arrow-key str r)
  (make-racket
   (racket-x r)
   (racket-y r)
   (cond
     [(string=? str LEFT) (- (racket-vx r) 1)]
     [(string=? str RIGHT) (+ (racket-vx r) 1)]
     [else (racket-vx r)])
   (cond
     [(string=? str UP) (- (racket-vy r) 1)]
     [(string=? str DOWN) (+ (racket-vy r) 1)]
     [else (racket-vy r)])
   (racket-selected? r)
   (racket-rmx r)
   (racket-rmy r)))

;;; testing key events
(begin-for-test
  (check-equal?
   (world-after-key-event SERVE-WORLD " ")
   (make-world (cons(make-ball 330 384 3 -9)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #true 1/8 1 RALLY)
   "space-bar is pause key event")
  (check-equal?
   (world-after-key-event RALLY-WORLD " ")
   (make-world (cons(make-ball 375 249 3 -9)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #true 1/8 0 PAUSED)
   "space-bar is pause key event")
  (check-equal?
   (world-after-key-event PAUSED-WORLD " ")
   (make-world (cons(make-ball 375 249 3 -9)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #t 1/8 0 PAUSED)
   "space-bar is pause key event")
  (check-equal?
   (world-after-key-event RALLY-WORLD "up")
   (make-world (cons(make-ball 375 249 3 -9)empty)
               (make-racket 330 384 0 -1 #false 0 0)
               #false 1/8 0 RALLY)
   "up arrow is up key event")
  (check-equal?
   (world-after-key-event SERVE-WORLD "up")
   (make-world (cons(make-ball 330 384 0 0)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #false 0.125 0 SERVE)
   "up arrow is up key event")
  (check-equal?
   (world-after-key-event RALLY-WORLD "down")
   (make-world (cons(make-ball 375 249 3 -9)empty)
               (make-racket 330 384 0 1 #false 0 0)
               #false 1/8 0 RALLY)
   "down arrow is down key event")
  (check-equal?
   (world-after-key-event SERVE-WORLD "down")
   (make-world (cons(make-ball 330 384 0 0)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #false 0.125 0 SERVE)
   "down arrow is down key event")
  (check-equal?
   (world-after-key-event RALLY-TO-PAUSE-WORLD "left")
   (make-world (cons(make-ball 375 249 3 -9)empty)
               (make-racket 330 384 -1 0 #false 0 0)
               #false 1/8 24 RALLY)
   "left arrow is left key event")
  (check-equal?
   (world-after-key-event SERVE-WORLD "left")
   (make-world (cons(make-ball 330 384 0 0)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #false 0.125 0 SERVE)
   "left arrow is left key event")
  (check-equal?
   (world-after-key-event RALLY-WORLD "right")
   (make-world (cons(make-ball 375 249 3 -9)empty)
               (make-racket 330 384 1 0 #false 0 0)
               #false 1/8 0 RALLY)
   "right arrow is right key event")
  (check-equal?
   (world-after-key-event SERVE-WORLD "right")
   (make-world (cons(make-ball 330 384 0 0)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #false 0.125 0 SERVE)
   "right arrow is right key event")
  (check-equal?
   (world-after-key-event SERVE-WORLD "q")
   "Non-key event"
   "Non-key event")
  (check-equal?
   (world-after-key-event SERVE-WORLD "b")
   (make-world (cons(make-ball 330 384 0 0)empty)
               (make-racket 330 384 0 0 #false 0 0)
               #false 0.125 0 SERVE)
   "right arrow is right key event")
  (check-equal?
   (world-after-key-event RALLY-WORLD "b")
   (make-world (cons(make-ball 330 384 3 -9)
                    (cons (make-ball 375 249 3 -9) empty))
               (make-racket 330 384 0 0 #false 0 0)
               #false 0.125 0 RALLY)
   "right arrow is right key event")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; world-after-mouse-event
;;;     : World Int Int MouseEvent -> World
;;; GIVEN: a world, the x and y coordinates of a mouse event,
;;;     and the mouse event
;;; RETURNS: the world after the given mouse event
;;; EXAMPLES:
;;;(world-after-mouse-event
;;;    (make-world (make-ball 414 132 3 -9)
;;;                (make-racket 302 406 0 0 #t 315 417)
;;;                 #f 1/24 0 RALLY)
;;;    315
;;;    417
;;;    "button-up")
;;;(world-after-mouse-event
;;;    (make-world (make-ball 385 6 -3 -9)
;;;                (make-racket 302 406 0 0 #f 0 0)
;;;                 #f 1/24 0 RALLY)
;;;    315
;;;    417
;;;    "button-down")
;;;(world-after-mouse-event
;;;     (make-world (make-ball 382 12 -3 9)
;;;                 (make-racket 302 406 0 0 #t 315 417)
;;;                  #f 1/24 0 RALLY)
;;;     315
;;;     417
;;;     "drag")
;;; STRATEGY: use constructor template for World
(define (world-after-mouse-event w mx my mev)
  (if
   (equal? (world-state w) RALLY)
   (make-world
    (world-balls w)
    (racket-after-mouse-event (world-racket w) mx my mev)
    (world-paused? w)
    (world-speed w)
    (world-rticks w)
    RALLY)
   w))
          
;;; racket-after-mouse-event
;;;     : Racket Int Int MouseEvent -> Racket
;;; GIVEN: a racket, the x and y coordinates of a mouse event,
;;;     and the mouse event
;;; RETURNS: the racket as it should be after the given mouse event
;;; EXAMPLES:
;;; (racket-after-mouse-event
;;;  (make-racket 302 406 0 0 #t 315 417) 315 417 "drag")
;;; STRATEGY: Cases on MouseEvent
(define (racket-after-mouse-event r mx my mev)
  (cond
    [(is-mouse-down-event? mev) (racket-after-button-down r mx my)]
    [(is-mouse-drag-event? mev) (racket-after-drag r mx my)]
    [(is-mouse-up-event? mev)   (racket-after-button-up r mx my)]
    [else r]))

;;; racket-after-button-down : Racket Int Int -> Racket
;;; GIVEN: a racket, the x and y coordinates of a mouse event
;;; RETURNS: the racket as it should be after mouse-button is pressed
;;; EXAMPLES:
;;;(racket-after-button-down
;;; (make-racket 302 406 0 0 #f 0 0) 315 417 "button-down")
;;; STRATEGY: use constructor template of racket
(define (racket-after-button-down r mx my)
  (if (in-racket-area? r mx my)
      (make-racket
       (racket-x r)
       (racket-y r)
       (racket-vx r)
       (racket-vy r)
       #true
       mx
       my)
      r))

;;; racket-after-drag : Racket Int Int -> Racket
;;; GIVEN: a racket, the x and y coordinates of a mouse event
;;; RETURNS: the racket as it should be after mouse-button is dragged
;;; EXAMPLES:
;;; (racket-after-drag
;;;  (make-racket 302 406 0 0 #t 315 417) 315 417 "drag")
;;; STRATEGY: use constructor template of racket
(define (racket-after-drag r mx my)
  (if (racket-selected? r)
      (make-racket
       (racket-x-after-drag r mx)
       (racket-y-after-drag r my)
       (racket-vx r)
       (racket-vy r)
       #true
       mx
       my)
      r))

;;; racket-x-after-drag : Racket Int -> Racket
;;; GIVEN: a racket, the x coordinate of a mouse event
;;; RETURNS: the x-coordinate of racket after mouse-button is dragged
;;; STRATEGY: use observer template of racket
(define (racket-x-after-drag r mx)
  (+ (- mx (racket-rmx r)) (racket-x r)))

;;; racket-y-after-drag : Racket Int -> Racket
;;; GIVEN: a racket, the y coordinate of a mouse event
;;; RETURNS: the y-coordinate of racket after mouse-button is dragged
;;; STRATEGY: use observer template of racket
(define (racket-y-after-drag r my)
  (+ (- my (racket-rmy r)) (racket-y r)))

;;; racket-after-button-up : Racket Int Int -> Racket
;;; GIVEN: a racket, the x and y coordinates of a mouse event
;;; RETURNS: the racket as it should be after mouse-button is released
;;; EXAMPLES:
;;;(racket-after-button-up
;;; (make-racket 302 406 0 0 #t 315 417) 315 417 "button-up")
;;; STRATEGY: use constructor template of racket
(define (racket-after-button-up r mx my)
  (if (racket-selected? r)
      (make-racket
       (racket-x r)
       (racket-y r)
       (racket-vx r)
       (racket-vy r)
       #false
       mx
       my)
      r))

;;; in-racket-area? : Racket Int Int -> Boolean
;;; GIVEN: a racket, the x and y coordinates of a mouse event
;;; RETURNS: true iff the givven coordinate is inside the 25-pixel
;;;          radius around the racket's center
;;; STRATEGY: use transcribe formula
(define (in-racket-area? r mx my)
  (and
   (<= (expt (- (racket-x r) mx) 2) (expt RACKET-AREA-RADIUS 2))
   (<= (expt (- (racket-y r) my) 2) (expt RACKET-AREA-RADIUS 2))))


;;;TESTS: for mouse events
(begin-for-test
  (check-equal?
   (world-after-mouse-event
    (make-world (cons (make-ball 414 132 3 -9)empty)
                (make-racket 302 406 0 0 #t 315 417)
                #f 1/24 0 RALLY)
    315
    417
    "button-up")
   (make-world (cons(make-ball 414 132 3 -9)empty)
               (make-racket 302 406 0 0 #f 315 417)
               #f 1/24 0 RALLY)
   "mouse event test")
  (check-equal?
   (world-after-mouse-event
    (make-world (cons (make-ball 414 132 3 -9)empty)
                (make-racket 302 406 0 0 #f 315 417)
                #f 1/24 0 RALLY)
    315
    417
    "button-up")
   (make-world (cons (make-ball 414 132 3 -9)empty)
               (make-racket 302 406 0 0 #f 315 417)
               #f 1/24 0 RALLY)
   "mouse event test")
  (check-equal?
   (world-after-mouse-event
    (make-world (cons (make-ball 385 6 -3 -9)empty)
                (make-racket 302 406 0 0 #f 0 0)
                #f 1/24 0 RALLY)
    315
    417
    "button-down")
   (make-world (cons(make-ball 385 6 -3 -9)empty)
               (make-racket 302 406 0 0 #t 315 417)
               #f 1/24 0 RALLY)
   "mouse event test")
  (check-equal?
   (world-after-mouse-event
    (make-world (cons(make-ball 382 12 -3 9)empty)
                (make-racket 302 406 0 0 #t 315 417)
                #f 1/24 0 RALLY)
    315
    417
    "drag")
   (make-world
    (cons(make-ball 382 12 -3 9)empty)
    (make-racket 302 406 0 0 #t 315 417)
    #f 1/24 0 RALLY)
   "mouse event test")
  (check-equal?
   (world-after-mouse-event
    (make-world (cons(make-ball 330 384 0 0)empty)
                (make-racket 330 384 0 0 #f 0 0)
                #f 1/16 0 SERVE)
    333
    392
    "button-down")
   (make-world
    (cons(make-ball 330 384 0 0)empty)
    (make-racket 330 384 0 0 #f 0 0)
    #f 1/16 0 SERVE)
   "mouse event test")
  (check-equal?
   (world-after-mouse-event
    (make-world (cons(make-ball 366 276 3 -9) empty)
                (make-racket 330 384 0 0 #f 0 0)
                #f 1/16 0 RALLY)
    356
    431
    "button-down")
   (make-world (cons (make-ball 366 276 3 -9)empty)
               (make-racket 330 384 0 0 #f 0 0)
               #f 1/16 0 RALLY)
   "mouse event test")
  (check-equal?
   (world-after-mouse-event
    (make-world (cons(make-ball 349 111 -3 9)empty)
                (make-racket 330 384 0 0 #f 0 0)
                #f 1/16 0 RALLY)
    145
    594
    "drag")
   (make-world (cons (make-ball 349 111 -3 9)empty)
               (make-racket 330 384 0 0 #f 0 0)
               #f 1/16 0 RALLY)
   "mouse event test")
  (check-equal?
   (world-after-mouse-event
    (make-world (cons (make-ball 330 384 0 0)empty)
                (make-racket 330 384 0 0 #f 0 0)
                #f 1/16 0 SERVE)
    -5
    -5
    "leave")
   (make-world (cons (make-ball 330 384 0 0) empty)
               (make-racket 330 384 0 0 #f 0 0)
               #f 1/16 0 SERVE)
   "mouse event test"
   )
  (check-equal?
   (world-after-mouse-event
    (make-world (cons(make-ball 382 12 -3 9)empty)
                (make-racket 302 406 0 0 #t 315 417)
                #f 1/24 0 RALLY)
    315
    417
    "enter")
   (make-world
    (cons(make-ball 382 12 -3 9)empty)
    (make-racket 302 406 0 0 #t 315 417)
    #f 1/24 0 RALLY)
   "mouse event test")
  )