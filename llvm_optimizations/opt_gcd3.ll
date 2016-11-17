WARNING: You're attempting to print out a bitcode file.
This is inadvisable as it may cause display problems. If
you REALLY want to taste LLVM bitcode first-hand, you
can force output with the `-f' option.

*** IR Dump After Module Verifier ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %10

; <label>:8:                                      ; preds = %2
  %9 = load i32, i32* %4, align 4
  store i32 %9, i32* %3, align 4
  br label %16

; <label>:10:                                     ; preds = %2
  %11 = load i32, i32* %5, align 4
  %12 = load i32, i32* %4, align 4
  %13 = load i32, i32* %5, align 4
  %14 = srem i32 %12, %13
  %15 = call i32 @gcd3(i32 %11, i32 %14)
  store i32 %15, i32* %3, align 4
  br label %16

; <label>:16:                                     ; preds = %10, %8
  %17 = load i32, i32* %3, align 4
  ret i32 %17
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %10

; <label>:8:                                      ; preds = %2
  %9 = load i32, i32* %4, align 4
  store i32 %9, i32* %3, align 4
  br label %16

; <label>:10:                                     ; preds = %2
  %11 = load i32, i32* %5, align 4
  %12 = load i32, i32* %4, align 4
  %13 = load i32, i32* %5, align 4
  %14 = srem i32 %12, %13
  %15 = call i32 @gcd3(i32 %11, i32 %14)
  store i32 %15, i32* %3, align 4
  br label %16

; <label>:16:                                     ; preds = %10, %8
  %17 = load i32, i32* %3, align 4
  ret i32 %17
}
*** IR Dump After SROA ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}
*** IR Dump After Early CSE ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}
*** IR Dump After Lower 'expect' Intrinsics ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}
*** IR Dump After Force set function attributes ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Infer set function attributes ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Interprocedural Sparse Conditional Constant Propagation ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Global Variable Optimizer ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Promote Memory to Register ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}
*** IR Dump After Dead Argument Elimination ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %8

; <label>:5:                                      ; preds = %2
  %6 = srem i32 %0, %1
  %7 = call i32 @gcd3(i32 %1, i32 %6)
  br label %8

; <label>:8:                                      ; preds = %5, %4
  %.0 = phi i32 [ %0, %4 ], [ %7, %5 ]
  ret i32 %.0
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After PGOIndirectCallPromotion ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Remove unused exception handling info ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After Function Integration/Inlining ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After Deduce function attributes ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After SROA ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After Early CSE ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After Speculatively execute instructions if target has divergent branches ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After Jump Threading ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After Value Propagation ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %7, label %4

; <label>:4:                                      ; preds = %2
  %5 = srem i32 %0, %1
  %6 = call i32 @gcd3(i32 %1, i32 %5)
  br label %7

; <label>:7:                                      ; preds = %2, %4
  %.0 = phi i32 [ %6, %4 ], [ %0, %2 ]
  ret i32 %.0
}
*** IR Dump After Tail Call Elimination ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  br label %tailrecurse

tailrecurse:                                      ; preds = %4, %2
  %.tr = phi i32 [ %0, %2 ], [ %.tr6, %4 ]
  %.tr6 = phi i32 [ %1, %2 ], [ %5, %4 ]
  %3 = icmp eq i32 %.tr6, 0
  br i1 %3, label %6, label %4

; <label>:4:                                      ; preds = %tailrecurse
  %5 = srem i32 %.tr, %.tr6
  br label %tailrecurse

; <label>:6:                                      ; preds = %tailrecurse
  ret i32 %.tr
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  br label %tailrecurse

tailrecurse:                                      ; preds = %4, %2
  %.tr = phi i32 [ %0, %2 ], [ %.tr6, %4 ]
  %.tr6 = phi i32 [ %1, %2 ], [ %5, %4 ]
  %3 = icmp eq i32 %.tr6, 0
  br i1 %3, label %6, label %4

; <label>:4:                                      ; preds = %tailrecurse
  %5 = srem i32 %.tr, %.tr6
  br label %tailrecurse

; <label>:6:                                      ; preds = %tailrecurse
  ret i32 %.tr
}
*** IR Dump After Reassociate expressions ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  br label %tailrecurse

tailrecurse:                                      ; preds = %4, %2
  %.tr = phi i32 [ %0, %2 ], [ %.tr6, %4 ]
  %.tr6 = phi i32 [ %1, %2 ], [ %5, %4 ]
  %3 = icmp eq i32 %.tr6, 0
  br i1 %3, label %6, label %4

; <label>:4:                                      ; preds = %tailrecurse
  %5 = srem i32 %.tr, %.tr6
  br label %tailrecurse

; <label>:6:                                      ; preds = %tailrecurse
  ret i32 %.tr
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  br label %tailrecurse

tailrecurse:                                      ; preds = %4, %2
  %.tr = phi i32 [ %0, %2 ], [ %.tr6, %4 ]
  %.tr6 = phi i32 [ %1, %2 ], [ %5, %4 ]
  %3 = icmp eq i32 %.tr6, 0
  br i1 %3, label %6, label %4

; <label>:4:                                      ; preds = %tailrecurse
  %5 = srem i32 %.tr, %.tr6
  br label %tailrecurse

; <label>:6:                                      ; preds = %tailrecurse
  ret i32 %.tr
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  br label %tailrecurse

tailrecurse:                                      ; preds = %4, %2
  %.tr = phi i32 [ %0, %2 ], [ %.tr6, %4 ]
  %.tr6 = phi i32 [ %1, %2 ], [ %5, %4 ]
  %3 = icmp eq i32 %.tr6, 0
  br i1 %3, label %6, label %4

; <label>:4:                                      ; preds = %tailrecurse
  %5 = srem i32 %.tr, %.tr6
  br label %tailrecurse

; <label>:6:                                      ; preds = %tailrecurse
  %.tr.lcssa = phi i32 [ %.tr, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Rotate Loops ***
tailrecurse:                                      ; preds = %.lr.ph, %tailrecurse
  %.tr68 = phi i32 [ %1, %.lr.ph ], [ %4, %tailrecurse ]
  %.tr7 = phi i32 [ %0, %.lr.ph ], [ %.tr68, %tailrecurse ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse
*** IR Dump After Loop Invariant Code Motion ***
tailrecurse:                                      ; preds = %.lr.ph, %tailrecurse
  %.tr68 = phi i32 [ %1, %.lr.ph ], [ %4, %tailrecurse ]
  %.tr7 = phi i32 [ %0, %.lr.ph ], [ %.tr68, %tailrecurse ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse
*** IR Dump After Unswitch loops ***
tailrecurse:                                      ; preds = %.lr.ph, %tailrecurse
  %.tr68 = phi i32 [ %1, %.lr.ph ], [ %4, %tailrecurse ]
  %.tr7 = phi i32 [ %0, %.lr.ph ], [ %.tr68, %tailrecurse ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
*** IR Dump After Loop-Closed SSA Form Pass ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Induction Variable Simplification ***
tailrecurse:                                      ; preds = %tailrecurse.preheader, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %tailrecurse.preheader ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %tailrecurse.preheader ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge.loopexit, label %tailrecurse
*** IR Dump After Recognize loop idioms ***
tailrecurse:                                      ; preds = %tailrecurse.preheader, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %tailrecurse.preheader ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %tailrecurse.preheader ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge.loopexit, label %tailrecurse
*** IR Dump After Delete dead loops ***
tailrecurse:                                      ; preds = %tailrecurse.preheader, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %tailrecurse.preheader ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %tailrecurse.preheader ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge.loopexit, label %tailrecurse
*** IR Dump After Unroll loops ***
tailrecurse:                                      ; preds = %tailrecurse.preheader, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %tailrecurse.preheader ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %tailrecurse.preheader ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge.loopexit, label %tailrecurse
*** IR Dump After MergedLoadStoreMotion ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Global Value Numbering ***
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
*** IR Dump After MemCpy Optimization ***
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
*** IR Dump After Sparse Conditional Constant Propagation ***
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
*** IR Dump After Demanded bits analysis ***
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
*** IR Dump After Bit-Tracking Dead Code Elimination ***
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
*** IR Dump After Combine redundant instructions ***
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
*** IR Dump After Jump Threading ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Value Propagation ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Dead Store Elimination ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
*** IR Dump After Loop-Closed SSA Form Pass ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Loop Invariant Code Motion ***
tailrecurse:                                      ; preds = %tailrecurse.preheader, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %tailrecurse.preheader ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %tailrecurse.preheader ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge.loopexit, label %tailrecurse
*** IR Dump After Aggressive Dead Code Elimination ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Remove unused exception handling info ***
Printing <null> Function
*** IR Dump After Function Integration/Inlining ***
Printing <null> Function
*** IR Dump After Deduce function attributes ***
Printing <null> Function
*** IR Dump After A No-Op Barrier Pass ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}

attributes #0 = { nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Eliminate Available Externally Globals ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}

attributes #0 = { nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Deduce function attributes in RPO ***; ModuleID = 'gcd3.ll'
source_filename = "gcd3.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}

attributes #0 = { nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Float to int ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
*** IR Dump After Loop-Closed SSA Form Pass ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Rotate Loops ***
tailrecurse:                                      ; preds = %tailrecurse.preheader, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %tailrecurse.preheader ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %tailrecurse.preheader ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge.loopexit, label %tailrecurse
*** IR Dump After Loop Distribition ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Demanded bits analysis ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Loop Vectorization ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Loop Load Elimination ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Combine redundant instructions ***
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
*** IR Dump After Demanded bits analysis ***
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
*** IR Dump After SLP Vectorizer ***
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
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: nounwind readnone ssp uwtable
define i32 @gcd3(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse:                                      ; preds = %2, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %2 ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %2 ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge, label %tailrecurse

tailrecurse._crit_edge:                           ; preds = %tailrecurse, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68, %tailrecurse ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
*** IR Dump After Loop-Closed SSA Form Pass ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Unroll loops ***
tailrecurse:                                      ; preds = %tailrecurse.preheader, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %tailrecurse.preheader ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %tailrecurse.preheader ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge.loopexit, label %tailrecurse
*** IR Dump After Combine redundant instructions ***
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
*** IR Dump After Canonicalize natural loops ***
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
*** IR Dump After Loop-Closed SSA Form Pass ***
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
  %.tr68.lcssa = phi i32 [ %.tr68, %tailrecurse ]
  br label %tailrecurse._crit_edge

tailrecurse._crit_edge:                           ; preds = %tailrecurse._crit_edge.loopexit, %2
  %.tr.lcssa = phi i32 [ %0, %2 ], [ %.tr68.lcssa, %tailrecurse._crit_edge.loopexit ]
  ret i32 %.tr.lcssa
}
*** IR Dump After Loop Invariant Code Motion ***
tailrecurse:                                      ; preds = %tailrecurse.preheader, %tailrecurse
  %.tr68 = phi i32 [ %4, %tailrecurse ], [ %1, %tailrecurse.preheader ]
  %.tr7 = phi i32 [ %.tr68, %tailrecurse ], [ %0, %tailrecurse.preheader ]
  %4 = srem i32 %.tr7, %.tr68
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %tailrecurse._crit_edge.loopexit, label %tailrecurse
*** IR Dump After Remove redundant instructions ***
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
*** IR Dump After Alignment from assumptions ***
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
*** IR Dump After Strip Unused Function Prototypes ***; ModuleID = 'gcd3.ll'
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
*** IR Dump After Dead Global Elimination ***; ModuleID = 'gcd3.ll'
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
*** IR Dump After Module Verifier ***
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
