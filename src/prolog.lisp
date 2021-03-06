;;; Copyright (c) 2014, Fereshta Yazdani <yazdani@cs.uni-bremen.de>
;;; All rights reserved.
;; 
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions are met:
;;; 
;;;     * Redistributions of source code must retain the above copyright
;;;       notice, this list of conditions and the following disclaimer.
;;;     * Redistributions in binary form must reproduce the above copyright
;;;       notice, this list of conditions and the following disclaimer in the
;;;       documentation and/or other materials provided with the distribution.
;;;     * Neither the name of the Institute for Artificial Intelligence/
;;;       Universitaet Bremen nor the names of its contributors may be used to 
;;;       endorse or promote products derived from this software without 
;;;       specific prior written permission.
;;; 
;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
;;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;;; POSSIBILITY OF SUCH DAMAGE.

(in-package :sherpa)

(defmethod costmap-generator-name->score ((name (eql 'sherpa-spatial-generator))) 5)

(defclass range-generator () ())
(defmethod costmap-generator-name->score ((name range-generator)) 2)

(defclass gaussian-generator () ())
(defmethod costmap-generator-name->score ((name gaussian-generator)) 6)

(def-fact-group spatial-relations-costmap (desig-costmap)
  
  (<- (desig-costmap ?designator ?costmap)
    (desig-prop ?designator (left-of ?location))
    (costmap ?costmap)
    (costmap-add-function
     sherpa-spatial-generator
     (make-spatial-relation-cost-function ?location :Y >)
     ?costmap))
  
  (<- (desig-costmap ?designator ?costmap)
    (desig-prop ?designator (right-of ?location))
    (costmap ?costmap)
    (costmap-add-function 
     sherpa-spatial-generator
     (make-spatial-relation-cost-function ?location :Y <)
     ?costmap)
    (costmap-add-height-generator
     (make-constant-height-function 6.0)
     ?costmap)) 

  (<- (desig-costmap ?designator ?costmap)
    (desig-prop ?designator (behind ?location))
    (costmap ?costmap)
    (costmap-add-function
     sherpa-spatial-generator
     (make-spatial-relation-cost-function ?location :X >)
     ?costmap))
  
  (<- (desig-costmap ?designator ?costmap)
    (desig-prop ?designator (in-front ?location))
    (costmap ?costmap)
    (costmap-add-function
     sherpa-spatial-generator
     (make-spatial-relation-cost-function ?location :X <)
     ?costmap)))

