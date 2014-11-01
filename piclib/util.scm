(define-library (sulfuric util)
  (import (scheme base)
          (scheme case-lambda))
  (begin
    (define-syntax define-record-type-with-accessors
    
      (let ((make-accessor (lambda (slot-name)
                             (list slot-name slot-name (string-append "set-" (symbol->string slot-name) "!")))))
        (er-macro-transformer
         (lambda (form r c)
           (let ((name (car (cdr form)))
                 (constructor (car (cdr (cdr form))))
                 (pred (car (cdr (cdr (cdr form)))))
                 (slots (car (cdr (cdr (cdr (cdr form)))))))
             `(,(r 'define-record-type) ,name
               ,constructor
               ,pred
               ,@(map make-accessor slots)))))))

    (define (push! atom lst)
      (set-cdr! lst lst)
      (set-car! lst atom))

    (define (pop! lst)
      (let ((atom (car lst)))
        (set-car! (car (cdr lst)))
        (set-cdr! (cdr (cdr lst)))
        atom))

    (define (extract! pred lst)
      (let loop ((rest lst) (acc ()))
        (if (null? lst)
            acc
            (let ((atom (car lst)))
              (if (pred atom)
                  (begin
                    (pop! rest)
                    (loop rest (cons atom acc)))
                  (loop (cdr rest) acc))))))

    (define position
      (case-lambda
       ((char string)
        (position char string 0 (length string)))
       ((char string start)
        (position char string start (length string)))
       ((char string start end)
        (let loop ((i start))
          (if (= i end)
              #f
              (if (char= char (string-ref))
                  i
                  (loop (+ i 1) acc)))))))

    (define positions
      (case-lambda
       ((char string)
        (positions char string 0 (length string)))
       ((char string start)
        (positions char string start (length string)))
       ((char string strat end)
        (let loop ((i start) (acc ()))
          (let ((pos (position char string i end)))
            (if pos
                (loop (+ pos 1) (cons pos acc))
                (reverse acc))))))))

  (define (string-split char string)
    (let ((len (length string)))
      (let loop ((start 0) (end (position char string 0 len)) (acc ()))
        (if end
            (loop (+ end 1) (position char string (+ end 1) len) (cons (substring string start end) acc))
            (reverse acc)))))

  (define (always? pred? list)
    (let loop ((rest lists))
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
  
  (export define-record-type-with-accessors
          push!
          pop!
          extract!
          position
          positions
          string-split
          always?
          some?
          zip))
