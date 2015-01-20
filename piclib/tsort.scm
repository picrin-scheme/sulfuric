(define-library (sulfuric tsort)
  (import (scheme base)
          (scheme write)
          (sulfuric util))

  (define-record-type-with-accessors <vertex>
    (make-vertex name ndepends depended-by)
    vertex?
    name
    ndepends
    depended-by)

  (define (vassoq want vertexes)
    (let loop ((rest vertexes))
      (if (null? rest)
          #f
          (if (equal? (name (car rest)) want)
              (car rest)
              (loop (cdr rest))))))

  (define (dec-ndepends! vertex)
    (set-ndepends! vertex (- (ndepends vertex) 1)))

  (define-syntax update-or-add
    (syntax-rules ()
      ((_ name proc! list)
       (let ((vertex (vassoq name list)))
         (if vertex
             (proc! vertex)
             (let ((vertex (make-vertex name 0 ())))
               (proc! vertex)
               (push! vertex list)))))))

  (define (depend-vertex! vertex name)
    (set-depended-by! vertex (cons name (depended-by vertex))))

  (define (undepend-vertex! vertex vertexes)
    (for-each
     (lambda (v)
       (dec-ndepends! (vassoq v vertexes)))
     (depended-by vertex)))

  (define (init input)
    (let loop ((rest input) (acc ()))
      ;; each vertex looks (name the-number-of-dependencies depended) 
      (if (null? rest)
          acc
          (let* ((entry (car rest))
                 (name (car entry))
                 (dependencies (cdr entry)))
            (for-each
             (lambda (dep)
               (update-or-add dep (lambda (v) (depend-vertex! v name)) acc))
             dependencies)
            (update-or-add name (lambda (v) (set-ndepends! v (length dependencies))) acc)
            (loop (cdr rest) acc)))))

  (define-syntax extract-free!
    (syntax-rules ()
      ((_ vs)
       (extract! (lambda (v)
                   (= 0 (ndepends v))) vs))))

  (define (cyclic-dependency-error vs)
    ;; :FIXME: more kind error
    (error "tsort: cyclic dependency detected"))

  (define (tsort input)
    (let ((vs (init input)))
      (let loop ((sorted ()))
        (if (null? vs)
            (map name (reverse sorted))
            (let ((frees (extract-free! vs)))
              (if (null? frees)
                  (cyclic-dependency-error vs))
              (for-each
               (lambda (v)
                 (undepend-vertex! v vs))
               frees)
              (loop (append frees sorted))
              )))))
  (export tsort))
