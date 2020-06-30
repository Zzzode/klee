; ModuleID = '/home/zode/Dataset/Klee/examples/exgen/test/test.bc'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@b = common dso_local global i32 0, align 4, !dbg !0
@a = common dso_local global i32 0, align 4, !dbg !6

; Function Attrs: noinline nounwind sspstrong uwtable
define dso_local i32 @plus() #0 !dbg !15 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %1, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %2, metadata !20, metadata !DIExpression()), !dbg !21
  %3 = load i32, i32* @b, align 4, !dbg !22
  %4 = add nsw i32 %3, 1, !dbg !23
  store i32 %4, i32* @a, align 4, !dbg !24
  %5 = load i32, i32* @a, align 4, !dbg !25
  %6 = load i32, i32* @b, align 4, !dbg !26
  %7 = add nsw i32 %5, %6, !dbg !27
  store i32 %7, i32* %1, align 4, !dbg !28
  %8 = load i32, i32* @a, align 4, !dbg !29
  %9 = icmp sgt i32 %8, 0, !dbg !31
  br i1 %9, label %10, label %26, !dbg !32

10:                                               ; preds = %0
  %11 = load i32, i32* @b, align 4, !dbg !33
  %12 = icmp sgt i32 %11, 0, !dbg !34
  br i1 %12, label %13, label %26, !dbg !35

13:                                               ; preds = %10
  %14 = load i32, i32* %1, align 4, !dbg !36
  %15 = load i32, i32* @a, align 4, !dbg !39
  %16 = icmp slt i32 %14, %15, !dbg !40
  br i1 %16, label %17, label %18, !dbg !41

17:                                               ; preds = %13
  store i32 1, i32* %2, align 4, !dbg !42
  br label %25, !dbg !43

18:                                               ; preds = %13
  %19 = load i32, i32* %1, align 4, !dbg !44
  %20 = load i32, i32* @a, align 4, !dbg !46
  %21 = icmp eq i32 %19, %20, !dbg !47
  br i1 %21, label %22, label %23, !dbg !48

22:                                               ; preds = %18
  store i32 -1, i32* %2, align 4, !dbg !49
  br label %24, !dbg !50

23:                                               ; preds = %18
  store i32 0, i32* %2, align 4, !dbg !51
  br label %24

24:                                               ; preds = %23, %22
  br label %25

25:                                               ; preds = %24, %17
  br label %26, !dbg !52

26:                                               ; preds = %25, %10, %0
  %27 = load i32, i32* %2, align 4, !dbg !53
  ret i32 %27, !dbg !54
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind sspstrong uwtable
define dso_local i32 @main() #0 !dbg !55 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = call i32 @plus(), !dbg !56
  ret i32 0, !dbg !57
}

attributes #0 = { noinline nounwind sspstrong uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!9, !10, !11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 3, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "test.c", directory: "/home/zode/Dataset/Klee/examples/exgen")
!4 = !{}
!5 = !{!6, !0}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 3, type: !8, isLocal: false, isDefinition: true)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !{i32 7, !"Dwarf Version", i32 4}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{i32 7, !"PIC Level", i32 2}
!13 = !{i32 7, !"PIE Level", i32 2}
!14 = !{!"clang version 10.0.0 "}
!15 = distinct !DISubprogram(name: "plus", scope: !3, file: !3, line: 5, type: !16, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{!8}
!18 = !DILocalVariable(name: "c", scope: !15, file: !3, line: 6, type: !8)
!19 = !DILocation(line: 6, column: 7, scope: !15)
!20 = !DILocalVariable(name: "result", scope: !15, file: !3, line: 6, type: !8)
!21 = !DILocation(line: 6, column: 10, scope: !15)
!22 = !DILocation(line: 8, column: 7, scope: !15)
!23 = !DILocation(line: 8, column: 9, scope: !15)
!24 = !DILocation(line: 8, column: 5, scope: !15)
!25 = !DILocation(line: 10, column: 7, scope: !15)
!26 = !DILocation(line: 10, column: 11, scope: !15)
!27 = !DILocation(line: 10, column: 9, scope: !15)
!28 = !DILocation(line: 10, column: 5, scope: !15)
!29 = !DILocation(line: 12, column: 7, scope: !30)
!30 = distinct !DILexicalBlock(scope: !15, file: !3, line: 12, column: 7)
!31 = !DILocation(line: 12, column: 9, scope: !30)
!32 = !DILocation(line: 12, column: 13, scope: !30)
!33 = !DILocation(line: 12, column: 16, scope: !30)
!34 = !DILocation(line: 12, column: 18, scope: !30)
!35 = !DILocation(line: 12, column: 7, scope: !15)
!36 = !DILocation(line: 13, column: 9, scope: !37)
!37 = distinct !DILexicalBlock(scope: !38, file: !3, line: 13, column: 9)
!38 = distinct !DILexicalBlock(scope: !30, file: !3, line: 12, column: 23)
!39 = !DILocation(line: 13, column: 13, scope: !37)
!40 = !DILocation(line: 13, column: 11, scope: !37)
!41 = !DILocation(line: 13, column: 9, scope: !38)
!42 = !DILocation(line: 14, column: 14, scope: !37)
!43 = !DILocation(line: 14, column: 7, scope: !37)
!44 = !DILocation(line: 15, column: 13, scope: !45)
!45 = distinct !DILexicalBlock(scope: !37, file: !3, line: 15, column: 13)
!46 = !DILocation(line: 15, column: 18, scope: !45)
!47 = !DILocation(line: 15, column: 15, scope: !45)
!48 = !DILocation(line: 15, column: 13, scope: !37)
!49 = !DILocation(line: 16, column: 14, scope: !45)
!50 = !DILocation(line: 16, column: 7, scope: !45)
!51 = !DILocation(line: 18, column: 14, scope: !45)
!52 = !DILocation(line: 19, column: 3, scope: !38)
!53 = !DILocation(line: 21, column: 10, scope: !15)
!54 = !DILocation(line: 21, column: 3, scope: !15)
!55 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 24, type: !16, scopeLine: 24, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!56 = !DILocation(line: 25, column: 3, scope: !55)
!57 = !DILocation(line: 27, column: 3, scope: !55)
