; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [12 x i8] c"Hello, %s!\0A\00", align 1
@.str.1 = private unnamed_addr constant [34 x i8] c"Welcome to the obfuscation test.\0A\00", align 1
@.str.2 = private unnamed_addr constant [18 x i8] c"SecretPassword123\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"User\00", align 1
@.str.4 = private unnamed_addr constant [24 x i8] c"Calculation result: %d\0A\00", align 1
@.str.5 = private unnamed_addr constant [20 x i8] c"Factorial of 5: %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [19 x i8] c"Complex logic: %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [17 x i8] c"Access granted!\0A\00", align 1
@.str.8 = private unnamed_addr constant [16 x i8] c"Access denied!\0A\00", align 1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local void @greet(ptr noundef %0) #0 {
  %2 = alloca ptr, align 8
  store ptr %0, ptr %2, align 8
  %3 = load ptr, ptr %2, align 8
  %4 = call i32 (ptr, ...) @printf(ptr noundef @.str, ptr noundef %3)
  %5 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @calculate(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  %6 = load i32, ptr %4, align 4
  %7 = load i32, ptr %5, align 4
  %8 = icmp sgt i32 %6, %7
  br i1 %8, label %9, label %13

9:                                                ; preds = %2
  %10 = load i32, ptr %4, align 4
  %11 = load i32, ptr %5, align 4
  %12 = add nsw i32 %10, %11
  store i32 %12, ptr %3, align 4
  br label %25

13:                                               ; preds = %2
  %14 = load i32, ptr %4, align 4
  %15 = load i32, ptr %5, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %21

17:                                               ; preds = %13
  %18 = load i32, ptr %4, align 4
  %19 = load i32, ptr %5, align 4
  %20 = mul nsw i32 %18, %19
  store i32 %20, ptr %3, align 4
  br label %25

21:                                               ; preds = %13
  %22 = load i32, ptr %4, align 4
  %23 = load i32, ptr %5, align 4
  %24 = sub nsw i32 %22, %23
  store i32 %24, ptr %3, align 4
  br label %25

25:                                               ; preds = %21, %17, %9
  %26 = load i32, ptr %3, align 4
  ret i32 %26
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @factorial(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 1, ptr %3, align 4
  store i32 1, ptr %4, align 4
  br label %5

5:                                                ; preds = %13, %1
  %6 = load i32, ptr %4, align 4
  %7 = load i32, ptr %2, align 4
  %8 = icmp sle i32 %6, %7
  br i1 %8, label %9, label %16

9:                                                ; preds = %5
  %10 = load i32, ptr %4, align 4
  %11 = load i32, ptr %3, align 4
  %12 = mul nsw i32 %11, %10
  store i32 %12, ptr %3, align 4
  br label %13

13:                                               ; preds = %9
  %14 = load i32, ptr %4, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %4, align 4
  br label %5, !llvm.loop !6

16:                                               ; preds = %5
  %17 = load i32, ptr %3, align 4
  ret i32 %17
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @complex_logic(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  store i32 0, ptr %7, align 4
  %8 = load i32, ptr %4, align 4
  %9 = icmp sgt i32 %8, 10
  br i1 %9, label %10, label %22

10:                                               ; preds = %3
  %11 = load i32, ptr %5, align 4
  %12 = icmp slt i32 %11, 5
  br i1 %12, label %13, label %17

13:                                               ; preds = %10
  %14 = load i32, ptr %4, align 4
  %15 = load i32, ptr %5, align 4
  %16 = add nsw i32 %14, %15
  store i32 %16, ptr %7, align 4
  br label %21

17:                                               ; preds = %10
  %18 = load i32, ptr %4, align 4
  %19 = load i32, ptr %5, align 4
  %20 = sub nsw i32 %18, %19
  store i32 %20, ptr %7, align 4
  br label %21

21:                                               ; preds = %17, %13
  br label %34

22:                                               ; preds = %3
  %23 = load i32, ptr %6, align 4
  %24 = icmp eq i32 %23, 0
  br i1 %24, label %25, label %29

25:                                               ; preds = %22
  %26 = load i32, ptr %4, align 4
  %27 = load i32, ptr %5, align 4
  %28 = mul nsw i32 %26, %27
  store i32 %28, ptr %7, align 4
  br label %33

29:                                               ; preds = %22
  %30 = load i32, ptr %4, align 4
  %31 = load i32, ptr %6, align 4
  %32 = sdiv i32 %30, %31
  store i32 %32, ptr %7, align 4
  br label %33

33:                                               ; preds = %29, %25
  br label %34

34:                                               ; preds = %33, %21
  %35 = load i32, ptr %7, align 4
  ret i32 %35
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca ptr, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store ptr @.str.2, ptr %2, align 8
  call void @greet(ptr noundef @.str.3)
  store i32 15, ptr %3, align 4
  store i32 20, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = call i32 @calculate(i32 noundef %5, i32 noundef %6)
  %8 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %7)
  %9 = call i32 @factorial(i32 noundef 5)
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %9)
  %11 = call i32 @complex_logic(i32 noundef 12, i32 noundef 3, i32 noundef 2)
  %12 = call i32 (ptr, ...) @printf(ptr noundef @.str.6, i32 noundef %11)
  %13 = load ptr, ptr %2, align 8
  %14 = call i32 @strcmp(ptr noundef %13, ptr noundef @.str.2) #3
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %16, label %18

16:                                               ; preds = %0
  %17 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  br label %20

18:                                               ; preds = %0
  %19 = call i32 (ptr, ...) @printf(ptr noundef @.str.8)
  br label %20

20:                                               ; preds = %18, %16
  ret i32 0
}

; Function Attrs: nounwind willreturn memory(read)
declare i32 @strcmp(ptr noundef, ptr noundef) #2

attributes #0 = { noinline nounwind optnone sspstrong uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind willreturn memory(read) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind willreturn memory(read) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 20.1.8"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
