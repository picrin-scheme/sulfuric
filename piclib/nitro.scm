(define-library (sulfuric nitro)
  (import (scheme base)
          (scheme write)
          (sulfuric util)
          (sulfuric util version))

  (begin
    (define-record-type-with-accessors <nitro>
      (make-nitro name)
      nitro?
      license
      authors
      version
      dependencies
      summary
      description
      homepage
      base-dir
      fetch-from
      src
      c-src
      doc
      test
      extra-files))

  (define nitros ())

  (define-syntax process-entry
    (syntax-rules (license
                   authors
                   version
                   dependencies
                   summary
                   description
                   homepage
                   base-dir
                   fetch-from
                   src
                   c-src
                   doc
                   test
                   extra-files)
      ((_ n (license l))
       (set-license! n l))
      ((_ n (authors . a))
       (set-authors! n 'a))
      ((_ n (version v))
       (set-version! n (string->version v)))
      ((_ n (dependencies . d))
       (set-dependencies! n 'd))
      ((_ n (summary s))
       (set-summary! n s))
      ((_ n (description d))
       (set-description! n d))
      ((_ n (homepage h))
       (set-homepage! n h))
      ((_ n (base-dir b))
       ;; :FIXME: correctly manupilate pathname
       (set-base-dir! n b))
      ((_ n (fetch-from f))
       (set-fetch-from! n f))
      ((_ n (src . s))
       ;; :FIXME: correctly manupilate pathname and blob
       (set-src! n 's))
      ((_ n (c-src . c))
       ;; :FIXME: correctly manupilate pathname and blob
       (set-c-src! n 'c))
      ((_ n (doc d))
       (set-doc! n d))
      ((_ n (test . t))
       ;; :FIXME: correctly manupilate pathname and blob
       (set-test! n 't))
      ((_ n (extra-files . e))
       ;; :FIXME: correctly manupilate pathname and blob
       (set-extra-files! n 'e))))

  (define (register-nito n)
    ;; :TODO: store in efficient data structure
    (push! n nitros))


  (define-syntax define-nitro
    (syntax-rules ()
      ((_ name entry ...)
       (let ((n (make-nitro 'name)))
         (process-entry n entry) ...
         (register-nito n)))
      ((_ name entry)
       (let ((n (make-nitro 'name)))
         (process-entry n entry)
         (register-nito n)))))
  
  (export
   license
   authors
   version
   dependencies
   summary
   description
   homepage
   base-dir
   fetch-from
   src
   c-src
   doc
   test
   extra-files)
  (export nitros
          define-nitro))
