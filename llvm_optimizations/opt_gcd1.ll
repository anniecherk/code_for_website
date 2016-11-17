WARNING: You're attempting to print out a bitcode file.
This is inadvisable as it may cause display problems. If
you REALLY want to taste LLVM bitcode first-hand, you
can force output with the `-f' option.

*** IR Dump After Module Verifier ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  br label %6

; <label>:6:                                      ; preds = %9, %2
  %7 = load i32, i32* %4, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %15

; <label>:9:                                      ; preds = %6
  %10 = load i32, i32* %4, align 4
  store i32 %10, i32* %5, align 4
  %11 = load i32, i32* %3, align 4
  %12 = load i32, i32* %4, align 4
  %13 = srem i32 %11, %12
  store i32 %13, i32* %4, align 4
  %14 = load i32, i32* %5, align 4
  store i32 %14, i32* %3, align 4
  br label %6

; <label>:15:                                     ; preds = %6
  %16 = load i32, i32* %3, align 4
  ret i32 %16
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  br label %6

; <label>:6:                                      ; preds = %9, %2
  %7 = load i32, i32* %4, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %15

; <label>:9:                                      ; preds = %6
  %10 = load i32, i32* %4, align 4
  store i32 %10, i32* %5, align 4
  %11 = load i32, i32* %3, align 4
  %12 = load i32, i32* %4, align 4
  %13 = srem i32 %11, %12
  store i32 %13, i32* %4, align 4
  %14 = load i32, i32* %5, align 4
  store i32 %14, i32* %3, align 4
  br label %6

; <label>:15:                                     ; preds = %6
  %16 = load i32, i32* %3, align 4
  ret i32 %16
}
*** IR Dump After SROA ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp ne i32 %.06, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Early CSE ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp ne i32 %.06, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Lower 'expect' Intrinsics ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp ne i32 %.06, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Force set function attributes ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp ne i32 %.06, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Infer set function attributes ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp ne i32 %.06, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Interprocedural Sparse Conditional Constant Propagation ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp ne i32 %.06, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Global Variable Optimizer ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp ne i32 %.06, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Promote Memory to Register ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp ne i32 %.06, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Dead Argument Elimination ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp ne i32 %.06, 0
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After PGOIndirectCallPromotion ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Remove unused exception handling info ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Function Integration/Inlining ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Deduce function attributes ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After SROA ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Early CSE ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Speculatively execute instructions if target has divergent branches ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Jump Threading ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Value Propagation ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Tail Call Elimination ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Reassociate expressions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  ret i32 %.0
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %5, %2
  %.06 = phi i32 [ %1, %2 ], [ %6, %5 ]
  %.0 = phi i32 [ %0, %2 ], [ %.06, %5 ]
  %4 = icmp eq i32 %.06, 0
  br i1 %4, label %7, label %5

; <label>:5:                                      ; preds = %3
  %6 = srem i32 %.0, %.06
  br label %3

; <label>:7:                                      ; preds = %3
  %.0.lcssa = phi i32 [ %.0, %3 ]
  ret i32 %.0.lcssa
}
*** IR Dump After Rotate Loops ***
; <label>:4:                                      ; preds = %.lr.ph, %4
  %.08 = phi i32 [ %0, %.lr.ph ], [ %.067, %4 ]
  %.067 = phi i32 [ %1, %.lr.ph ], [ %5, %4 ]
  %5 = srem i32 %.08, %.067
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %._crit_edge, label %4
*** IR Dump After Loop Invariant Code Motion ***
; <label>:4:                                      ; preds = %.lr.ph, %4
  %.08 = phi i32 [ %0, %.lr.ph ], [ %.067, %4 ]
  %.067 = phi i32 [ %1, %.lr.ph ], [ %5, %4 ]
  %5 = srem i32 %.08, %.067
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %._crit_edge, label %4
*** IR Dump After Unswitch loops ***
; <label>:4:                                      ; preds = %.lr.ph, %4
  %.08 = phi i32 [ %0, %.lr.ph ], [ %.067, %4 ]
  %.067 = phi i32 [ %1, %.lr.ph ], [ %5, %4 ]
  %5 = srem i32 %.08, %.067
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %._crit_edge, label %4
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Induction Variable Simplification ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph
*** IR Dump After Recognize loop idioms ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph
*** IR Dump After Delete dead loops ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph
*** IR Dump After Unroll loops ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph
*** IR Dump After MergedLoadStoreMotion ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Global Value Numbering ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After MemCpy Optimization ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Sparse Conditional Constant Propagation ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Demanded bits analysis ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Bit-Tracking Dead Code Elimination ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Jump Threading ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Value Propagation ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Dead Store Elimination ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop Invariant Code Motion ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph
*** IR Dump After Aggressive Dead Code Elimination ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Remove unused exception handling info ***
Printing <null> Function
*** IR Dump After Function Integration/Inlining ***
Printing <null> Function
*** IR Dump After Deduce function attributes ***
Printing <null> Function
*** IR Dump After A No-Op Barrier Pass ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Eliminate Available Externally Globals ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Deduce function attributes in RPO ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Float to int ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Rotate Loops ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph
*** IR Dump After Loop Distribition ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Demanded bits analysis ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop Vectorization ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop Load Elimination ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Demanded bits analysis ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After SLP Vectorizer ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %2 ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %2 ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %.lr.ph ]
  ret i32 %.0.lcssa
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Unroll loops ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.067.lcssa = phi i32 [ %.067, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067.lcssa, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Loop Invariant Code Motion ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph
*** IR Dump After Remove redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Alignment from assumptions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
*** IR Dump After Strip Unused Function Prototypes ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Dead Global Elimination ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Merge Duplicate Global Constants ***; ModuleID = 'gcd1.ll'
source_filename = "gcd1.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Module Verifier ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd1(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.08 = phi i32 [ %.067, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.067 = phi i32 [ %4, %.lr.ph ], [ %1, %.lr.ph.preheader ]
  %4 = srem i32 %.08, %.067
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0.lcssa = phi i32 [ %0, %2 ], [ %.067, %._crit_edge.loopexit ]
  ret i32 %.0.lcssa
}
