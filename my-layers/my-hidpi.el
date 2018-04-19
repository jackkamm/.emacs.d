;; scale images by 2x for hidpi/retina screens
;; https://github.com/syl20bnr/spacemacs/issues/8770

;; scale all images by 2
(defun create-image-2x (old-create-image-fun file-or-data &optional type data-p &rest props)
(let ((original (apply old-create-image-fun (append (list file-or-data type data-p) props))))
    ;;(if (memq type '(xpm xbm pbm imagemagick)) ;not sure about xbm,pbm,imagemagick
    (if (memq type '(xpm xbm pbm))
	original
    (let* ((width-height (image-size original t))
	    (width (car width-height))
	    (height (cdr width-height))
	    (width-2x (* 2 width))
	    (height-2x (* 2 height))
	    (newprops props)
	    (newprops (plist-put props :format type))
	    (newprops (plist-put newprops :width width-2x))
	    (newprops (plist-put newprops :height height-2x))
	    (newargs (append (list file-or-data 'imagemagick data-p) newprops))
	    )
	(apply old-create-image-fun newargs)))))

(if (>= (default-font-height) 28)
    (advice-add 'create-image :around #'create-image-2x))

