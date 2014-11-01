(define-library (sulfuric nitro version)
  (import (scheme base)
          (sulfuric util))
  
  (begin
    (define (version-split v)
      (map string->number (string-split v)))
    
    (define (make-version-comparator op)
      (lambda (v1 v2)
        (let loop ((v1 (version-split v1)) (v2 (version-split v2)))
          (if (null? v1)
              (if (null? v2)
                  (op 0 0)
                  (op 0 (car v2)))
              (if (null? v2)
                  (op (car v1) 0)
                  (cond
                   ((op (car v1) (car v2)) #t)
                   ((= (car v1) (car v2)) (loop (cdr v1) (cdr v2)))
                   (#t  #f)))))))

    (define version=
      (make-version-comparator =))
    (define version/=
      (make-version-comparator /=))
    (define version>
      (make-version-comparator >))
    (define version<
      (make-version-comparator <))
    (define version<=
      (make-version-comparator <=))
    (define version>=
      (make-version-comparator >=))

    (define (version~ v1 v2)
      (let ((v1 (version-split v1))
            (v2 (version-split v2)))
        (and (= (car v1) (car v2))
             (= (cadr v1) (cadr v2)))))

    (define (version<~ v1 v2)
      (and (version~ v1 v2)
           (version<= v1 v2)))

    (define (version>~ v1 v2)
      (and (version~ v1 v2)
           (version>= v1 v2)))
    ))
