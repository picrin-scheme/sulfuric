(define-library (sulfuric util)
  (import (scheme base)
          (scheme case-lambda)
          (scheme write)
          (picrin macro))
  (begin
    (define (make-accessor slot-name r)
      (list slot-name slot-name (string->symbol (string-append "set-" (symbol->string slot-name) "!")))))

  (begin
    
    (define-syntax define-record-type-with-accessors
      (er-macro-transformer
       (lambda (form r c)
         (let ((name (car (cdr form)))
               (constructor (car (cdr (cdr form))))
               (pred (car (cdr (cdr (cdr form)))))
               (slots (cdr (cdr (cdr (cdr form))))))
           `(,(r 'define-record-type) ,name
             ,constructor
             ,pred
             ,@(map (lambda (name) (make-accessor name r)) slots))))))

    (define-syntax push!
      (syntax-rules ()
        ((_ atom lst)
         (if (null? lst)
             (set! lst (list atom))
             (begin
               (set-cdr! lst (cons (car lst) (cdr lst)))
               (set-car! lst atom))))))

    (define-syntax pop!
      (syntax-rules ()
        ((_ lst)
         (cond
          ((null? lst) (error "pop!: pair required but got ()"))
          ((null? (cdr lst))
           (let ((atom (car lst)))
             (set! lst ())
             atom))
          (else (let ((atom (car lst)))
                  (set-car! lst (car (cdr lst)))
                  (set-cdr! lst (cdr (cdr lst)))
                  atom))))))

    (define-syntax extract!
      (syntax-rules ()
        ((_ pred lst)
         (cond
          ((null? lst) ())
          ((null? (cdr lst))
           (let ((atom (car lst)))
             (if (pred atom)
                 (begin
                   (set! lst ())
                   (list atom))
                 ())))
          (else
           (let loop ((rest lst) (parent (cons #f lst)) (acc ()))
             (if (null? rest)
                 (reverse acc)
                 (let ((atom (car rest)))
                   (if (pred atom)
                       (begin
                         (if (null? (cdr rest))
                             (begin
                               (set! rest ())
                               (set-cdr! parent ()))
                             (begin
                               (set-car! rest (car (cdr rest)))
                               (set-cdr! rest (cdr (cdr rest)))))
                         (loop rest parent (cons atom acc)))
                       (loop (cdr rest) (cdr parent) acc))))))))))

    (define position
      (case-lambda
       ((char string)
        (position char string 0 (string-length string)))
       ((char string start)
        (position char string start (string-length string)))
       ((char string start end)
        (let loop ((i start))
          (if (= i end)
              #f
              (if (eqv? char (string-ref string i))
                  i
                  (loop (+ i 1))))))))

    (define positions
      (case-lambda
       ((char string)
        (positions char string 0 (string-length string)))
       ((char string start)
        (positions char string start (string-length string)))
       ((char string start end)
        (let loop ((i start) (acc ()))
          (let ((pos (position char string i end)))
            (if pos
                (loop (+ pos 1) (cons pos acc))
                (reverse acc))))))))

  (define (string-split char string)
    (let ((len (string-length string)))
      (let loop ((start 0) (end (position char string 0 len)) (acc ()))
        (if end
            (loop (+ end 1) (position char string (+ end 1) len) (cons (substring string start end) acc))
            (reverse (cons (substring string start) acc))))))

  (define (always? pred? list)
    (let loop ((rest list))
      (if (null? rest)
          #t
          (if (pred? (car rest))
              (loop (cdr rest))
              #f))))

  (define (some? pred? list)
    (let loop ((rest list))
      (if (null? rest)
          #f
          (if (pred? (car rest))
              #t
              (loop (cdr rest))))))

  (define (zip . lists)
    (apply map list lists))

  (define (fold proc init list)
    (if (null? list)
        init
        (fold proc (proc init (car list)) (cdr list))))

  (define (string-join sep strs)
    (if (null? strs)
        ""
        (apply string-append
               (let loop ((rest strs) (acc ()))
                 (if (null? rest)
                     (reverse (cdr acc))
                     (loop (cdr rest) (cons sep (cons (car rest) acc))))))))
  
  (export define-record-type-with-accessors
          push!
          pop!
          extract!
          position
          positions
          string-split
          always?
          some?
          zip
          fold
          string-join))
