WARNING: You're attempting to print out a bitcode file.
This is inadvisable as it may cause display problems. If
you REALLY want to taste LLVM bitcode first-hand, you
can force output with the `-f' option.

*** IR Dump After Module Verifier ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  br label %5

; <label>:5:                                      ; preds = %21, %2
  %6 = load i32, i32* %3, align 4
  %7 = load i32, i32* %4, align 4
  %8 = icmp ne i32 %6, %7
  br i1 %8, label %9, label %22

; <label>:9:                                      ; preds = %5
  %10 = load i32, i32* %3, align 4
  %11 = load i32, i32* %4, align 4
  %12 = icmp sgt i32 %10, %11
  br i1 %12, label %13, label %17

; <label>:13:                                     ; preds = %9
  %14 = load i32, i32* %4, align 4
  %15 = load i32, i32* %3, align 4
  %16 = sub nsw i32 %15, %14
  store i32 %16, i32* %3, align 4
  br label %21

; <label>:17:                                     ; preds = %9
  %18 = load i32, i32* %3, align 4
  %19 = load i32, i32* %4, align 4
  %20 = sub nsw i32 %19, %18
  store i32 %20, i32* %4, align 4
  br label %21

; <label>:21:                                     ; preds = %17, %13
  br label %5

; <label>:22:                                     ; preds = %5
  %23 = load i32, i32* %3, align 4
  ret i32 %23
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  br label %5

; <label>:5:                                      ; preds = %13, %17, %2
  %6 = load i32, i32* %3, align 4
  %7 = load i32, i32* %4, align 4
  %8 = icmp ne i32 %6, %7
  %9 = load i32, i32* %3, align 4
  br i1 %8, label %10, label %21

; <label>:10:                                     ; preds = %5
  %11 = load i32, i32* %4, align 4
  %12 = icmp sgt i32 %9, %11
  br i1 %12, label %13, label %17

; <label>:13:                                     ; preds = %10
  %14 = load i32, i32* %4, align 4
  %15 = load i32, i32* %3, align 4
  %16 = sub nsw i32 %15, %14
  store i32 %16, i32* %3, align 4
  br label %5

; <label>:17:                                     ; preds = %10
  %18 = load i32, i32* %3, align 4
  %19 = load i32, i32* %4, align 4
  %20 = sub nsw i32 %19, %18
  store i32 %20, i32* %4, align 4
  br label %5

; <label>:21:                                     ; preds = %5
  ret i32 %9
}
*** IR Dump After SROA ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp ne i32 %.08, %.0
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Early CSE ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp ne i32 %.08, %.0
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Lower 'expect' Intrinsics ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp ne i32 %.08, %.0
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Force set function attributes ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp ne i32 %.08, %.0
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Infer set function attributes ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp ne i32 %.08, %.0
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Interprocedural Sparse Conditional Constant Propagation ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp ne i32 %.08, %.0
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Global Variable Optimizer ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp ne i32 %.08, %.0
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Promote Memory to Register ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp ne i32 %.08, %.0
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Dead Argument Elimination ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp ne i32 %.08, %.0
  br i1 %4, label %5, label %11

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After PGOIndirectCallPromotion ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}

attributes #0 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Remove unused exception handling info ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Function Integration/Inlining ***
; Function Attrs: nounwind ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Deduce function attributes ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After SROA ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Early CSE ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Speculatively execute instructions if target has divergent branches ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Jump Threading ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Value Propagation ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Tail Call Elimination ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Reassociate expressions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %3

; <label>:3:                                      ; preds = %7, %9, %2
  %.08 = phi i32 [ %0, %2 ], [ %8, %7 ], [ %.08, %9 ]
  %.0 = phi i32 [ %1, %2 ], [ %.0, %7 ], [ %10, %9 ]
  %4 = icmp eq i32 %.08, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08, %.0
  br label %3

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %.outer

.outer:                                           ; preds = %7, %2
  %.08.ph = phi i32 [ %8, %7 ], [ %0, %2 ]
  %.0.ph = phi i32 [ %.0, %7 ], [ %1, %2 ]
  br label %3

; <label>:3:                                      ; preds = %.outer, %9
  %.0 = phi i32 [ %10, %9 ], [ %.0.ph, %.outer ]
  %4 = icmp eq i32 %.08.ph, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08.ph, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = sub nsw i32 %.08.ph, %.0
  br label %.outer

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08.ph
  br label %3

; <label>:11:                                     ; preds = %3
  ret i32 %.08.ph
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  br label %.outer

.outer:                                           ; preds = %7, %2
  %.08.ph = phi i32 [ %8, %7 ], [ %0, %2 ]
  %.0.ph = phi i32 [ %.0.lcssa9, %7 ], [ %1, %2 ]
  br label %3

; <label>:3:                                      ; preds = %.outer, %9
  %.0 = phi i32 [ %10, %9 ], [ %.0.ph, %.outer ]
  %4 = icmp eq i32 %.08.ph, %.0
  br i1 %4, label %11, label %5

; <label>:5:                                      ; preds = %3
  %6 = icmp sgt i32 %.08.ph, %.0
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %.0.lcssa9 = phi i32 [ %.0, %5 ]
  %8 = sub nsw i32 %.08.ph, %.0.lcssa9
  br label %.outer

; <label>:9:                                      ; preds = %5
  %10 = sub nsw i32 %.0, %.08.ph
  br label %3

; <label>:11:                                     ; preds = %3
  %.08.ph.lcssa = phi i32 [ %.08.ph, %3 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Rotate Loops ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph, %.lr.ph ], [ %9, %8 ]
  %5 = icmp sgt i32 %.08.ph, %.010
  br i1 %5, label %6, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph
  %10 = icmp eq i32 %.08.ph, %9
  br i1 %10, label %._crit_edge, label %4
*** IR Dump After Loop Invariant Code Motion ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph, %.lr.ph ], [ %9, %8 ]
  %5 = icmp sgt i32 %.08.ph, %.010
  br i1 %5, label %6, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph
  %10 = icmp eq i32 %.08.ph, %9
  br i1 %10, label %._crit_edge, label %4
*** IR Dump After Unswitch loops ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph, %.lr.ph ], [ %9, %8 ]
  %5 = icmp sgt i32 %.08.ph, %.010
  br i1 %5, label %6, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph
  %10 = icmp eq i32 %.08.ph, %9
  br i1 %10, label %._crit_edge, label %4
*** IR Dump After Rotate Loops ***
.lr.ph:                                           ; preds = %.lr.ph.lr.ph, %.outer
  %.0.ph13 = phi i32 [ %1, %.lr.ph.lr.ph ], [ %.0.lcssa9, %.outer ]
  %.08.ph12 = phi i32 [ %0, %.lr.ph.lr.ph ], [ %6, %.outer ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp sgt i32 %.08.ph12, %.010
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %._crit_edge, label %4

.outer:                                           ; preds = %4
  %.0.lcssa9 = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.0.lcssa9
  %7 = icmp eq i32 %6, %.0.lcssa9
  br i1 %7, label %.outer..outer._crit_edge_crit_edge, label %.lr.ph
*** IR Dump After Loop Invariant Code Motion ***
.lr.ph:                                           ; preds = %.lr.ph.lr.ph, %.outer
  %.0.ph13 = phi i32 [ %1, %.lr.ph.lr.ph ], [ %.0.lcssa9, %.outer ]
  %.08.ph12 = phi i32 [ %0, %.lr.ph.lr.ph ], [ %6, %.outer ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp sgt i32 %.08.ph12, %.010
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %._crit_edge, label %4

.outer:                                           ; preds = %4
  %.0.lcssa9 = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.0.lcssa9
  %7 = icmp eq i32 %6, %.0.lcssa9
  br i1 %7, label %.outer..outer._crit_edge_crit_edge, label %.lr.ph
*** IR Dump After Unswitch loops ***
.lr.ph:                                           ; preds = %.lr.ph.lr.ph, %.outer
  %.0.ph13 = phi i32 [ %1, %.lr.ph.lr.ph ], [ %.0.lcssa9, %.outer ]
  %.08.ph12 = phi i32 [ %0, %.lr.ph.lr.ph ], [ %6, %.outer ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp sgt i32 %.08.ph12, %.010
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %._crit_edge, label %4

.outer:                                           ; preds = %4
  %.0.lcssa9 = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.0.lcssa9
  %7 = icmp eq i32 %6, %.0.lcssa9
  br i1 %7, label %.outer..outer._crit_edge_crit_edge, label %.lr.ph
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.0.lcssa9, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp sgt i32 %.08.ph12, %.010
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.0.lcssa9 = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.0.lcssa9
  %7 = icmp eq i32 %6, %.0.lcssa9
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %8, %2, %.outer
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %6, %.outer ], [ %.08.ph12, %8 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %8, %2, %.outer
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %6, %.outer ], [ %.08.ph12, %8 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit15:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit15, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %6, %.outer._crit_edge.loopexit15 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit15:                     ; preds = %.outer
  %.lcssa = phi i32 [ %6, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit15, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.lcssa, %.outer._crit_edge.loopexit15 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Induction Variable Simplification ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4
*** IR Dump After Recognize loop idioms ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4
*** IR Dump After Delete dead loops ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4
*** IR Dump After Unroll loops ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4
*** IR Dump After Induction Variable Simplification ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph
*** IR Dump After Recognize loop idioms ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph
*** IR Dump After Delete dead loops ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph
*** IR Dump After Unroll loops ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph
*** IR Dump After MergedLoadStoreMotion ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit15:                     ; preds = %.outer
  %.lcssa = phi i32 [ %6, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit15, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.lcssa, %.outer._crit_edge.loopexit15 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Global Value Numbering ***
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
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit15:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit15, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit15 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After MemCpy Optimization ***
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
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit15:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit15, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit15 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Sparse Conditional Constant Propagation ***
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
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit15:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit15, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit15 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Demanded bits analysis ***
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
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit15:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit15, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit15 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Bit-Tracking Dead Code Elimination ***
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
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit15:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit15, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit15 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Combine redundant instructions ***
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
  br i1 %7, label %.outer._crit_edge.loopexit15, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit15:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit15, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit15 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Jump Threading ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Value Propagation ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Dead Store Elimination ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
  br i1 %7, label %.outer._crit_edge.loopexit18, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit18:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit18, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit18 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit18, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit18:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit18, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit18 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Loop Invariant Code Motion ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4
*** IR Dump After Loop Invariant Code Motion ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit18, label %.lr.ph
*** IR Dump After Aggressive Dead Code Elimination ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit18, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit18:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit18, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit18 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010.lcssa, %.outer ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Remove unused exception handling info ***
Printing <null> Function
*** IR Dump After Function Integration/Inlining ***
Printing <null> Function
*** IR Dump After Deduce function attributes ***
Printing <null> Function
*** IR Dump After A No-Op Barrier Pass ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Eliminate Available Externally Globals ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Deduce function attributes in RPO ***; ModuleID = 'gcd2.ll'
source_filename = "gcd2.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}

attributes #0 = { norecurse nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Float to int ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Rotate Loops ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4
*** IR Dump After Rotate Loops ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph
*** IR Dump After Loop Distribition ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Demanded bits analysis ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Loop Vectorization ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Canonicalize natural loops ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Loop Load Elimination ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Combine redundant instructions ***
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
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Demanded bits analysis ***
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
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After SLP Vectorizer ***
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
  br i1 %7, label %.outer._crit_edge.loopexit21, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  br label %.outer._crit_edge

.outer._crit_edge.loopexit21:                     ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit21, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %.outer._crit_edge.loopexit ], [ %.010, %.outer._crit_edge.loopexit21 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Simplify the CFG ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Combine redundant instructions ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %2, %.outer
  %.0.ph13 = phi i32 [ %.010, %.outer ], [ %1, %2 ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %2 ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %6 = sub nsw i32 %.08.ph12, %.010
  %7 = icmp eq i32 %6, %.010
  br i1 %7, label %.outer._crit_edge, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge, label %4

.outer._crit_edge:                                ; preds = %.outer, %8, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12, %8 ], [ %.010, %.outer ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Canonicalize natural loops ***
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
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit24, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit24:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit24, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit24 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Unroll loops ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4
*** IR Dump After Unroll loops ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit24, label %.lr.ph
*** IR Dump After Combine redundant instructions ***
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
*** IR Dump After Canonicalize natural loops ***
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
*** IR Dump After Loop-Closed SSA Form Pass ***
; Function Attrs: norecurse nounwind readnone ssp uwtable
define i32 @gcd2(i32, i32) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  br i1 %3, label %.outer._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit24, label %.lr.ph

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer._crit_edge.loopexit:                       ; preds = %8
  %.08.ph12.lcssa = phi i32 [ %.08.ph12, %8 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit24:                     ; preds = %.outer
  %.010.lcssa.lcssa = phi i32 [ %.010.lcssa, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit24, %.outer._crit_edge.loopexit, %2
  %.08.ph.lcssa = phi i32 [ %0, %2 ], [ %.08.ph12.lcssa, %.outer._crit_edge.loopexit ], [ %.010.lcssa.lcssa, %.outer._crit_edge.loopexit24 ]
  ret i32 %.08.ph.lcssa
}
*** IR Dump After Loop Invariant Code Motion ***
; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4
*** IR Dump After Loop Invariant Code Motion ***
.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.0.ph13 = phi i32 [ %.010.lcssa, %.outer ], [ %1, %.lr.ph.preheader ]
  %.08.ph12 = phi i32 [ %6, %.outer ], [ %0, %.lr.ph.preheader ]
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %8
  %.010 = phi i32 [ %.0.ph13, %.lr.ph ], [ %9, %8 ]
  %5 = icmp slt i32 %.010, %.08.ph12
  br i1 %5, label %.outer, label %8

; <label>:8:                                      ; preds = %4
  %9 = sub nsw i32 %.010, %.08.ph12
  %10 = icmp eq i32 %.08.ph12, %9
  br i1 %10, label %.outer._crit_edge.loopexit, label %4

.outer:                                           ; preds = %4
  %.010.lcssa = phi i32 [ %.010, %4 ]
  %6 = sub nsw i32 %.08.ph12, %.010.lcssa
  %7 = icmp eq i32 %6, %.010.lcssa
  br i1 %7, label %.outer._crit_edge.loopexit24, label %.lr.ph
*** IR Dump After Remove redundant instructions ***
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
*** IR Dump After Alignment from assumptions ***
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
*** IR Dump After Strip Unused Function Prototypes ***; ModuleID = 'gcd2.ll'
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
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Dead Global Elimination ***; ModuleID = 'gcd2.ll'
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
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
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
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
*** IR Dump After Module Verifier ***
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
