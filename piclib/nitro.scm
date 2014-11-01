(define-library (sulfuric nitro)
  (import (scheme base)
          (scheme write)
          (sulfuric util))

  (begin
    (define nitros ())

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
      src
      c-src
      doc
      test
      extra-files))
  (export nitros))
