; ModuleID = 'test_with_sym.bc'
source_filename = "test_with_sym.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@a = common dso_local global i32 0, align 4, !dbg !0
@.str = private unnamed_addr constant [2 x i8] c"a\00", align 1
@b = common dso_local global i32 0, align 4, !dbg !6
@.str.1 = private unnamed_addr constant [2 x i8] c"b\00", align 1

; Function Attrs: noinline nounwind sspstrong uwtable
define dso_local i32 @plus() #0 !dbg !15 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %1, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %2, metadata !20, metadata !DIExpression()), !dbg !21
  call void @klee_make_symbolic(i8* bitcast (i32* @a to i8*), i64 4, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i64 0, i64 0)), !dbg !22
  call void @klee_make_symbolic(i8* bitcast (i32* @b to i8*), i64 4, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0)), !dbg !23
  %3 = load i32, i32* @a, align 4, !dbg !24
  %4 = load i32, i32* @b, align 4, !dbg !25
  %5 = add nsw i32 %3, %4, !dbg !26
  %6 = load i32, i32* @a, align 4, !dbg !27
  %7 = icmp slt i32 %5, %6, !dbg !28
  %8 = zext i1 %7 to i32, !dbg !28
  %9 = sext i32 %8 to i64, !dbg !24
  call void @klee_assume(i64 %9), !dbg !29
  %10 = load i32, i32* @a, align 4, !dbg !30
  %11 = load i32, i32* @b, align 4, !dbg !31
  %12 = add nsw i32 %10, %11, !dbg !32
  store i32 %12, i32* %1, align 4, !dbg !33
  %13 = load i32, i32* @a, align 4, !dbg !34
  %14 = icmp sgt i32 %13, 0, !dbg !36
  %15 = load i32, i32* @b, align 4, !dbg !37
  %16 = icmp sgt i32 %15, 0, !dbg !38
  %or.cond = and i1 %14, %16, !dbg !39
  br i1 %or.cond, label %17, label %28, !dbg !39

17:                                               ; preds = %0
  %18 = load i32, i32* %1, align 4, !dbg !40
  %19 = load i32, i32* @a, align 4, !dbg !43
  %20 = icmp slt i32 %18, %19, !dbg !44
  br i1 %20, label %21, label %22, !dbg !45

21:                                               ; preds = %17
  store i32 1, i32* %2, align 4, !dbg !46
  br label %28, !dbg !47

22:                                               ; preds = %17
  %23 = load i32, i32* %1, align 4, !dbg !48
  %24 = load i32, i32* @a, align 4, !dbg !50
  %25 = icmp eq i32 %23, %24, !dbg !51
  br i1 %25, label %26, label %27, !dbg !52

26:                                               ; preds = %22
  store i32 -1, i32* %2, align 4, !dbg !53
  br label %28, !dbg !54

27:                                               ; preds = %22
  store i32 0, i32* %2, align 4, !dbg !55
  br label %28

28:                                               ; preds = %21, %27, %26, %0
  %29 = load i32, i32* %2, align 4, !dbg !56
  ret i32 %29, !dbg !57
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @klee_make_symbolic(i8*, i64, i8*) #2

declare void @klee_assume(i64) #2

; Function Attrs: noinline nounwind sspstrong uwtable
define dso_local i32 @main() #0 !dbg !58 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = call i32 @plus(), !dbg !59
  ret i32 0, !dbg !60
}

attributes #0 = { noinline nounwind sspstrong uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!9, !10, !11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 4, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "test_with_sym.c", directory: "/home/zode/Dataset/Klee/examples/exgen")
!4 = !{}
!5 = !{!0, !6}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 4, type: !8, isLocal: false, isDefinition: true)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !{i32 7, !"Dwarf Version", i32 4}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{i32 7, !"PIC Level", i32 2}
!13 = !{i32 7, !"PIE Level", i32 2}
!14 = !{!"clang version 10.0.0 "}
!15 = distinct !DISubprogram(name: "plus", scope: !3, file: !3, line: 6, type: !16, scopeLine: 6, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{!8}
!18 = !DILocalVariable(name: "c", scope: !15, file: !3, line: 7, type: !8)
!19 = !DILocation(line: 7, column: 7, scope: !15)
!20 = !DILocalVariable(name: "result", scope: !15, file: !3, line: 7, type: !8)
!21 = !DILocation(line: 7, column: 10, scope: !15)
!22 = !DILocation(line: 9, column: 3, scope: !15)
!23 = !DILocation(line: 10, column: 3, scope: !15)
!24 = !DILocation(line: 11, column: 15, scope: !15)
!25 = !DILocation(line: 11, column: 19, scope: !15)
!26 = !DILocation(line: 11, column: 17, scope: !15)
!27 = !DILocation(line: 11, column: 23, scope: !15)
!28 = !DILocation(line: 11, column: 21, scope: !15)
!29 = !DILocation(line: 11, column: 3, scope: !15)
!30 = !DILocation(line: 12, column: 7, scope: !15)
!31 = !DILocation(line: 12, column: 11, scope: !15)
!32 = !DILocation(line: 12, column: 9, scope: !15)
!33 = !DILocation(line: 12, column: 5, scope: !15)
!34 = !DILocation(line: 14, column: 7, scope: !35)
!35 = distinct !DILexicalBlock(scope: !15, file: !3, line: 14, column: 7)
!36 = !DILocation(line: 14, column: 9, scope: !35)
!37 = !DILocation(line: 14, column: 16, scope: !35)
!38 = !DILocation(line: 14, column: 18, scope: !35)
!39 = !DILocation(line: 14, column: 13, scope: !35)
!40 = !DILocation(line: 15, column: 9, scope: !41)
!41 = distinct !DILexicalBlock(scope: !42, file: !3, line: 15, column: 9)
!42 = distinct !DILexicalBlock(scope: !35, file: !3, line: 14, column: 23)
!43 = !DILocation(line: 15, column: 13, scope: !41)
!44 = !DILocation(line: 15, column: 11, scope: !41)
!45 = !DILocation(line: 15, column: 9, scope: !42)
!46 = !DILocation(line: 16, column: 14, scope: !41)
!47 = !DILocation(line: 16, column: 7, scope: !41)
!48 = !DILocation(line: 17, column: 13, scope: !49)
!49 = distinct !DILexicalBlock(scope: !41, file: !3, line: 17, column: 13)
!50 = !DILocation(line: 17, column: 18, scope: !49)
!51 = !DILocation(line: 17, column: 15, scope: !49)
!52 = !DILocation(line: 17, column: 13, scope: !41)
!53 = !DILocation(line: 18, column: 14, scope: !49)
!54 = !DILocation(line: 18, column: 7, scope: !49)
!55 = !DILocation(line: 20, column: 14, scope: !49)
!56 = !DILocation(line: 23, column: 10, scope: !15)
!57 = !DILocation(line: 23, column: 3, scope: !15)
!58 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 26, type: !16, scopeLine: 26, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!59 = !DILocation(line: 27, column: 3, scope: !58)
!60 = !DILocation(line: 29, column: 3, scope: !58)
