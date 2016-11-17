 
*** IR Dump After Merge Duplicate Global Constants ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse.preheader

tailrecurse.preheader:                            ; preds = %2
  br label %tailrecurse

tailrecurse:                                      ; preds = %tailrecurse.preheader, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %tailrecurse.preheader ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %tailrecurse.preheader ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge.loopexit, label %tailrecurse

tailrecurse._crit_edge.loopexit:                  ; preds = %tailrecurse
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}

attributes #0 = { nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
