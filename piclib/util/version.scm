(define-library (sulfuric util version)
  (import (scheme base)
          (scheme case-lambda)
          (sulfuric util))
  
  (begin
    (define-record-type-with-accessors <version>
      (make-version% major minor patch)
      version?
      major
      minor
      patch)

    (define make-version
      (case-lambda
       ((major)
        (make-version% major 0 0))
       ((major minor)
        (make-version% major minor 0))
       ((major minor patch)
        (make-version% major minor patch))))
    
    (define (string->version str)
      (apply make-version (map string->number (string-split #\. str))))

    (define (version->list v)
      (list (major v) (minor v) (patch v)))

    (define (version->string v)
      (string-join "." (map number->string (version->list v))))
    
    (define (make-version-comparator op include-equal?)
      (lambda (v1 v2)
        (let loop ((v1 (version->list v1))
                   (v2 (version->list v2)))
          (if (null? v1)
              include-equal?
              (cond
               ((op (car v1) (car v2)) #t)
               ((= (car v1) (car v2))
                (loop (cdr v1) (cdr v2))))))))

    (define (/= x y) (not (= x y)))
    (define (id x) x)

    (define (version= v1 v2)     
      (always? id (map = (version->list v1) (version->list v2))))
    (define version/=
      (make-version-comparator /= #f))
    (define version>
      (make-version-comparator > #f))
    (define version<
      (make-version-comparator < #f))
    (define version<=
      (make-version-comparator <= #t))
    (define version>=
      (make-version-comparator >= #t))

    (define (version~ v1 v2)
      (and (= (major v1) (major v2))
           (= (minor v1) (minor v2))))

    (define (version<~ v1 v2)
      (let ((upper (make-version (major v1) (+ (minor v1) 1))))
        (and (version<= v1 v2)
             (version< v2 upper))))

    (define (version>~ v1 v2)
      (let ((upper (make-version (major v2) (+ (minor v2) 1))))
        (and (version>= v1 v2)
             (version> upper v1)))))

  (export
   make-version
   string->version
   version->list
   version->string
   version=
   version/=
   version~
   version<
   version<=
   version<~
   version>
   version>=
   version>~))
