
(defun precedes-iter (x v)
  (let ((list nil))
	(do ((pos (position x v)
		  (position x v :start (1+ pos))))
	    ((null pos) nil)
	  (when (and (> pos 0)
		     (not (member (elt v (- pos 1)) list)))
	    (push (elt v (- pos 1)) list)))
	list))

(defun intersperse-r (obj list)
  (cond ((null list) nil)
	((null (cdr list)) list)
	(t (cons (car list)
		 (cons obj
		       (intersperse-r obj (cdr list)))))))


;; 1. Translate the following expressions into equivalent expressions that don't
;; use let or let* and don't cause an expression to be evaluated twice.

;(let ((x (car y)))
;  (cons x x))
((lambda (x)
  (cons x x))
 (car y))

;(let* ((w (car x))
;       (y (+ w z)))
;  (cons w y))
((lambda (w)
   ((lambda (y)
      (cons w y))
    (+ w z)))
 (car x))

;; 2. Re-write mystery to use cond
(defun mystery (x y)
  (if (null y)
      nil
      (if (eql (car y) x)
	  0
	  (let ((z (mystery x (cdr y))))
	    (and z (+ z 1))))))

(defun mystery-cond (x y)
  (cond ((null y) nil)
	((eql (car y) x) 0)
	(t (let ((z (mystery-cond x (cdr y))))
	     (and z (+ z 1))))))

(defun sq-if-not-less-5 (x)
  (if (and (> x 0) (< x 5) (= x 5))
      nil
      (* x x)))

(defun precedes-r (obj v)
  (let ((pos (position obj v)))
    (cons (pos
	   (if (> pos 0)
	       (cons (elt v (- pos 1))
		     (precedes-r obj (subseq v (1+ pos))))
	       (precedes-r obj (subseq v (1+ pos)))))
	  (t nil))))

