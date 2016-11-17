 
*** IR Dump After Merge Duplicate Global Constants ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge.loopexit24, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit24:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit24, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit24 ]
  ret i32 %.08.ph.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
